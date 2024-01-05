import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shotwot_frontend/main.dart';
import 'package:shotwot_frontend/src/routes/route_utils.dart';
import 'package:shotwot_frontend/src/services/app_service.dart';
import 'package:shotwot_frontend/src/ui/screens/home_screen.dart';
import 'package:shotwot_frontend/src/ui/screens/login_screen.dart';
import 'package:shotwot_frontend/src/ui/screens/signup_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
      refreshListenable: AppService.instance,
      debugLogDiagnostics: true,
      navigatorKey: AppService.instance.navigatorKey,
      redirect: _redirect,
      routes: [
        GoRoute(
          path: PAGES.home.screenPath,
          name: PAGES.home.screenName,
          builder: (context, state) => HomeScreen(),
        ),
        GoRoute(
          path: PAGES.signup.screenPath,
          name: PAGES.signup.screenName,
          builder: (context, state) => const SignupScreen(),
        ),
        GoRoute(
          path: PAGES.login.screenPath,
          name: PAGES.login.screenName,
          builder: (context, state) => const LoginScreen(),
        )
      ]);
}

String? _redirect(BuildContext context, GoRouterState state) {
  final bool isLoggedIn = AppService.instance.isLoggedIn;
  if (isLoggedIn) {
    return state.fullPath;
  } else if (state.fullPath == PAGES.login.screenPath) {
    return state.fullPath;
  } else {
    final token = objectBox.getToken();
    if (token != null) {
      return state.fullPath;
    }
  }
  return PAGES.signup.screenPath;
}
