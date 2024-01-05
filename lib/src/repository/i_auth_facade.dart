import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthFacade {
  Future<bool> signIn({required String email, required String password,});
  Future<bool> register({required String email, required String password});
  Future<User?> getUser();
  Future<void> logOut();
  Future<bool> signWithGoogle();
}