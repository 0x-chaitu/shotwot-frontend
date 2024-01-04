import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shotwot_frontend/src/routes/route_utils.dart';
import 'package:shotwot_frontend/src/ui/screens/auth_screen.dart';
import 'package:shotwot_frontend/src/ui/screens/login_screen.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
      debugLogDiagnostics: true,
      navigatorKey: _rootNavigatorKey,
      routes: [
        GoRoute(
          path: PAGES.home.screenPath,
          name: PAGES.home.screenName,
          builder: (context, state) => const AuthFlowScreen(),
        ),
        GoRoute(
          path: PAGES.login.screenPath,
          name: PAGES.login.screenName,
          builder: (context, state) => const LoginScreen(),
        )
      ]);
}
