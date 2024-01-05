part of 'auth_bloc.dart';



abstract class AuthState {
  bool isLoading = false;

  AuthState();

  List<Object> get props => [];
}

class AuthInitalState extends AuthState {}

class AuthLoadingState extends AuthState {

  AuthLoadingState({required isLoading}) {
    super.isLoading = isLoading;
  }
}

class AuthSuccessState extends AuthState {
  final bool status;

  AuthSuccessState({
    required this.status
  });

  @override
  List<bool> get props => [status];

}

class AuthFailureState extends AuthState {
  final String errorMessage;

  AuthFailureState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}