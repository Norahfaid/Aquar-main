part of 'register_nafaz_cubit.dart';

abstract class RegisterNafazState extends Equatable {
  const RegisterNafazState();

  @override
  List<Object?> get props => [];
}

class RegisterNafazInitialState extends RegisterNafazState {}

class RegisterNafazLoadingState extends RegisterNafazState {}

class RegisterNafazLoadedState extends RegisterNafazState {
  final User? registerNafazUser;

  const RegisterNafazLoadedState({this.registerNafazUser});

  @override
  List<Object?> get props => [registerNafazUser,];
}

class RegisterNafazErrorState extends RegisterNafazState {
  final String message;

  const RegisterNafazErrorState({required this.message});

  @override
  List<Object?> get props => [message,];
}