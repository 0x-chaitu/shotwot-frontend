import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:shotwot_frontend/main.dart';
import 'package:shotwot_frontend/src/models/tokens.dart';
import 'package:shotwot_frontend/src/routes/route_utils.dart';

class AppService with ChangeNotifier {
  AppService._();

  static final AppService _instance = AppService._();

  factory AppService() => _instance;

  static AppService get instance => _instance;

  final navigatorKey = GlobalKey<NavigatorState>();

  BuildContext get context => navigatorKey.currentContext!;

  Token? userToken;

  bool get isLoggedIn => userToken != null;

  AppService init() {
    final token = objectBox.getToken();
    if (token != null) {
      log("token: ${token.accessToken}");
      userToken = token;
    }
    return AppService();
  }

  void setUserToken(Token token) {
    objectBox.putToken(token);
    userToken = token;
    notifyListeners();
  }

  void manageAutoLogout() {
    terminate();
    context.go(PAGES.signup.screenPath);
  }

  Future<void> terminate() async {
    userToken = null;
    objectBox.remove();
  }

  Stream<Token?> streamToken() => objectBox.streamToken();
}
