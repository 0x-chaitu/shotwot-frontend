import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shotwot_frontend/injection.dart';
import 'package:shotwot_frontend/src/blocs/auth/auth_bloc.dart';

class HomeScreen extends StatelessWidget {
  static String id = 'home_screen';
  HomeScreen({super.key});
  final authBloc = locator<AuthBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Hello User',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocConsumer<AuthBloc, AuthState>(
              bloc: authBloc,
              listener: (context, state) {
                if (state is AuthLoadingState) {
                  const CircularProgressIndicator();
                } else if (state is AuthFailureState) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                          content: Text('error'),
                        );
                      });
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                    onPressed: () {
                      authBloc.add(SignOut());
                    },
                    child: const Text('logOut'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
