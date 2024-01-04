import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:shotwot_frontend/src/models/token.dart';
import 'package:shotwot_frontend/src/repository/i_auth_facade.dart';
import 'package:shotwot_frontend/src/services/app_service.dart';

@Injectable(as: IAuthFacade)
class AuthFacade implements IAuthFacade {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleAuth;
  final AppService _authService;

  AuthFacade(this._firebaseAuth, this._googleAuth, this._authService);
  @override
  Future<User?> getUser() {
    throw UnimplementedError();
  }

  @override
  Future<User?> register(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim());

      final User? user = userCredential.user;
      return _setJwtAReturnUser(user);
    } on FirebaseAuthException catch (e) {
      log(e.toString());
    }
    return null;
  }

  @override
  Future<User?> signWithGoogle() async {
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
      return _setJwtAReturnUser(user);
    } on FirebaseAuthException catch (e) {
      log(e.toString());
    }
    return null;
  }

  @override
  Future<User?> signIn(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
              email: email.trim(), password: password.trim());

      final User? user = userCredential.user;
      return _setJwtAReturnUser(user);
    } on FirebaseAuthException catch (e) {
      log(e.toString());
    }
    return null;
  }

  @override
  Future<void> logOut() async {
    final User? user = _firebaseAuth.currentUser;
    if (user != null) {
      await _firebaseAuth.signOut();
      await _authService.terminate();
    }
  }

  User? _setJwtAReturnUser(User? user) {
    if (user != null) {
      Token jwt = Token();
      jwt.name = user.uid;
      jwt.id = 1;
      _authService.setUserToken(jwt);
      return user;
    }
    return null;
  }
}
