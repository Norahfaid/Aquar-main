import 'package:aquar/features/auth/domain/models/logout_response.dart';
import 'package:equatable/equatable.dart';

abstract class LogoutState extends Equatable {
  const LogoutState();

  @override
  List<Object> get props => [];
}

class LogoutInitial extends LogoutState {}

class LogoutLoadingState extends LogoutState {}

class LogoutErrorState extends LogoutState {
  final String message;
  const LogoutErrorState({required this.message});
}

class LogoutSuccessState extends LogoutState {
  final LogoutResponse logoutResponse;
  const LogoutSuccessState({required this.logoutResponse});
}
