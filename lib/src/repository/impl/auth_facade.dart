import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:shotwot_frontend/src/models/tokens.dart';
import 'package:shotwot_frontend/src/repository/i_auth_facade.dart';
import 'package:shotwot_frontend/src/services/app_service.dart';

@Injectable(as: IAuthFacade)
class AuthFacade implements IAuthFacade {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleAuth;
  final AppService _authService;

  Client client = Client();

  AuthFacade(this._firebaseAuth, this._googleAuth, this._authService);
  @override
  Future<User?> getUser() {
    throw UnimplementedError();
  }

  @override
  Future<bool> register(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim());

      final User? user = userCredential.user;

      return _getJwt(user, "signup");
    } on FirebaseAuthException catch (e) {
      log(e.toString());
    }
    return false;
  }

  @override
  Future<bool> signWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleAuth.signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (userCredential.additionalUserInfo!.isNewUser) {
        return _getJwt(user, "signup");
      } else {
        return _getJwt(user, "signin");
      }
    } on FirebaseAuthException catch (e) {
      log(e.toString());
    }
    return false;
  }

  @override
  Future<bool> signIn({required String email, required String password}) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
              email: email.trim(), password: password.trim());

      final User? user = userCredential.user;

      return _getJwt(user, "signin");
    } on FirebaseAuthException catch (e) {
      log(e.toString());
    }
    return false;
  }

  @override
  Future<void> logOut() async {
    final User? user = _firebaseAuth.currentUser;
    if (user != null) {
      await _firebaseAuth.signOut();
      _authService.manageAutoLogout();
    }
  }

  Future<bool> _getJwt(User? user, String path) async {
    final Response response;
    if (user != null) {
      Uri uri = Uri(
        host: "10.0.2.2",
        path: "/api/v1/users/$path",
        scheme: "http",
        port: 8000,
      );
      try {
        response = await client.post(uri,
            body: json.encode({"idToken": await user.getIdToken()}));
        if (response.statusCode == 200) {
          Tokens tokens = Tokens.fromJson(json.decode(response.body));
          Token token = Token();
          Map<String, String> tokenList = tokens.tokens;
          token.accessToken = tokenList["accesstoken"];
          token.id = 1;
          if (token.accessToken != null) {
            _authService.setUserToken(token);
            return true;
          }
        } else {
          throw Exception(response);
        }
      } catch (e) {
        log(e.toString());
      }
    }
    return false;
  }

  User? _setJwtAReturnUser(User? user) {
    if (user != null) {
      Token token = Token();
      token.accessToken = user.uid;
      token.id = 1;
      _authService.setUserToken(token);
      return user;
    }
    return null;
  }
}
