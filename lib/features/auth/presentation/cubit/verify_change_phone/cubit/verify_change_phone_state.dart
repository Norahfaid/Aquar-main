part of 'verify_change_phone_cubit.dart';

abstract class VerifyChangePhoneState extends Equatable {
  const VerifyChangePhoneState();

  @override
  List<Object> get props => [];
}

class VerifyChangePhoneInitial extends VerifyChangePhoneState {}

class VerifyChangePhoneLoadingState extends VerifyChangePhoneState {}

class VerifyChangePhoneSuccessState extends VerifyChangePhoneState {}

class VerifyChangePhoneErrorState extends VerifyChangePhoneState {
  final String message;

  const VerifyChangePhoneErrorState({required this.message});
}
