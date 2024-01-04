import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:shotwot_frontend/src/services/app_service.dart';
import 'package:shotwot_frontend/src/services/firebase_service.dart';

@module
abstract class AppModule {
  @preResolve
  Future<FirebaseService> get firebaseService => FirebaseService.init();

  @injectable
  AppService get appService => AppService.instance.init();

  @injectable
  FirebaseAuth get auth => FirebaseAuth.instance;

  @injectable
  GoogleSignIn get gauth => GoogleSignIn();

}
