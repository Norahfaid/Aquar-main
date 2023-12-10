part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoodingState extends RegisterState {}

class RejectTermsState extends RegisterState {}

class AcceptTermsState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  final RegisterResponse response;
  const RegisterSuccessState({
    required this.response,
  });
}

class RegisterErrorState extends RegisterState {
  final String message;
  const RegisterErrorState({required this.message});
}
