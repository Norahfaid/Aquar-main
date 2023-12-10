part of 'check_code_cubit.dart';

abstract class CheckCodeState extends Equatable {
  const CheckCodeState();

  @override
  List<Object> get props => [];
}

class CheckCodeInitial extends CheckCodeState {}

class CheckCodeErrorState extends CheckCodeState {
  final String message;

  const CheckCodeErrorState({required this.message});
}

class CheckCodeSuccessState extends CheckCodeState {
  final CheckCodeForgetPassResponse response;

  const CheckCodeSuccessState({required this.response});
}

class CheckCodeLoadingState extends CheckCodeState {}
