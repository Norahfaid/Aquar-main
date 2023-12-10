part of 'submit_register_cubit.dart';

abstract class SubmitRegisterState extends Equatable {
  const SubmitRegisterState();

  @override
  List<Object> get props => [];
}

class SubmitRegisterInitial extends SubmitRegisterState {}

class SubmitRegisterNewCode extends SubmitRegisterState {}

class VerifyRegisterLoodingState extends SubmitRegisterState {}

class VerifyRegisterErrorState extends SubmitRegisterState {
  final String message;

  const VerifyRegisterErrorState({required this.message});
}

class VerifyRegisterSuccessState extends SubmitRegisterState {
  final VerifyRegisterResponse response;

  const VerifyRegisterSuccessState({required this.response});
}

class EmptyCodeState extends SubmitRegisterState {
  final String message;
  const EmptyCodeState({required this.message});
}

class WrongCodeState extends SubmitRegisterState {
  final String message;
  const WrongCodeState({required this.message});
}

class CodeChangeState extends SubmitRegisterState {}
