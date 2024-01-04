part of 'auth_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();

  List<Object> get props => [];
}

class Signup extends AuthEvent {
  final String email;
  final String password;

  const Signup(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class Signin extends AuthEvent {
  final String email;
  final String password;

  const Signin(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class SignWithGoogle extends AuthEvent {


  const SignWithGoogle();

  @override
  List<Object> get props => [];
}


class SignOut extends AuthEvent {}
