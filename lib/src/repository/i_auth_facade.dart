import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthFacade {
  Future<User?> signIn({required String email, required String password,});
  Future<User?> register({required String email, required String password});
  Future<User?> getUser();
  Future<void> logOut();
  Future<User?> signWithGoogle();
}