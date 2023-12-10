part of 'reset_pass_cubit.dart';

abstract class ResetPassState extends Equatable {
  const ResetPassState();

  @override
  List<Object> get props => [];
}

class ResetPassInitial extends ResetPassState {}

class ResetPassSuccessState extends ResetPassState {
  final ResetPassResponse response;

  const ResetPassSuccessState({required this.response});
}

class ResetPassErrorState extends ResetPassState {
  final String message;

  const ResetPassErrorState({required this.message});
}

class ResetPassLoadingState extends ResetPassState {}
