library auth;

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:shotwot_frontend/src/repository/i_auth_facade.dart';

part 'auth_state.dart';
part 'auth_event.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthFacade _authFacade;

  AuthBloc(this._authFacade) : super(AuthInitalState()) {
    on<AuthEvent>((event, emit) {});

    on<Signup>((event, emit) async {
      emit(AuthLoadingState(isLoading: true));
      try {
        final User? user = await _authFacade.register(
            email: event.email, password: event.password);
        if (user != null) {
          emit(AuthSuccessState(user: user));
        } else {
          emit(AuthFailureState("user Signup failed!"));
        }
      } catch (e) {
        log(e.toString());
      }
      // emit(AuthLoadingState(isLoading: false));
    });

    on<SignOut>((event, emit) async {
      try {
        await _authFacade.logOut();
      } catch (e) {
        log(e.toString());
      }
    });

    on<SignWithGoogle>((event, emit) async {
      emit(AuthLoadingState(isLoading: true));
      try {
        await _authFacade.signWithGoogle();
      } catch (e) {
        log(e.toString());
      }
      emit(AuthLoadingState(isLoading: false));
    });

    on<Signin>((event, emit) async {
      emit(AuthLoadingState(isLoading: true));
      try {
        final User? user = await _authFacade.signIn(
            email: event.email, password: event.password);
        if (user != null) {
          emit(AuthSuccessState(user: user));
        } else {
          emit(AuthFailureState("user Signup failed!"));
        }
      } catch (e) {
        log(e.toString());
      }
      emit(AuthLoadingState(isLoading: false));
    });
  }
}
