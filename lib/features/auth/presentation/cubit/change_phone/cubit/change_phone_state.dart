part of 'change_phone_cubit.dart';

abstract class ChangePhoneState extends Equatable {
  const ChangePhoneState();

  @override
  List<Object> get props => [];
}

class ChangePhoneInitial extends ChangePhoneState {}

class ChangePhoneSuccessState extends ChangePhoneState {}

class ChangePhoneLoadingState extends ChangePhoneState {}

class ChangePhoneErrorState extends ChangePhoneState {
  final String message;

  const ChangePhoneErrorState({required this.message});
}
