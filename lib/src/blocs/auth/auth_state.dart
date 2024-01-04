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
  final User user;

  AuthSuccessState({
    required this.user
  });

  @override
  List<Object> get props => [user];

}

class AuthFailureState extends AuthState {
  final String errorMessage;

  AuthFailureState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}