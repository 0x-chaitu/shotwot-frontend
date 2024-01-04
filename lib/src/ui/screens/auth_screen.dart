import 'package:flutter/material.dart';
import 'package:shotwot_frontend/main.dart';
import 'package:shotwot_frontend/src/models/token.dart';
import 'package:shotwot_frontend/src/ui/screens/home_screen.dart';
import 'package:shotwot_frontend/src/ui/screens/signup_screen.dart';

class AuthFlowScreen extends StatelessWidget {
  const AuthFlowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<Token?>(
        stream: objectBox.streamToken(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return const SignupScreen();
          }
        },
      ),
    );
  }
}
