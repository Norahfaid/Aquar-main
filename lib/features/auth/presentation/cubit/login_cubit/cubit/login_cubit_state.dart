part of 'login_cubit_cubit.dart';

abstract class LoginCubitState extends Equatable {
  const LoginCubitState();

  @override
  List<Object> get props => [];
}

class LoginCubitInitial extends LoginCubitState {}

class LoginLoadingState extends LoginCubitState {}

class LoginSuccessState extends LoginCubitState {
  final User user;

  const LoginSuccessState({required this.user});
}

class LoginErrorState extends LoginCubitState {
  final String message;
  const LoginErrorState({required this.message});
}
