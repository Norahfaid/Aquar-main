part of 'resend_code_cubit.dart';

abstract class ResendCodeState extends Equatable {
  const ResendCodeState();

  @override
  List<Object> get props => [];
}

class ResendCodeInitial extends ResendCodeState {}

class ResendCodeLoadingState extends ResendCodeState {}

class ResendCodeErrorState extends ResendCodeState {
  final String message;

  const ResendCodeErrorState({required this.message});
}

class ResendCodeSuccessState extends ResendCodeState {
  final SensVerificationCodeRegisterResponse response;

  const ResendCodeSuccessState({required this.response});
}
