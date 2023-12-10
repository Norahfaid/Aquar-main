part of 'forget_pass_cubit.dart';

abstract class ForgetPassState extends Equatable {
  const ForgetPassState();

  @override
  List<Object> get props => [];
}

class ForgetPassInitial extends ForgetPassState {}

class ForgetPassLoadingState extends ForgetPassState {}

class ForgetPassSuccessState extends ForgetPassState {
  final ForgetPassResponse response;

  const ForgetPassSuccessState({required this.response});
}

class ForgetPassErrorState extends ForgetPassState {
  final String message;

  const ForgetPassErrorState({required this.message});
}
