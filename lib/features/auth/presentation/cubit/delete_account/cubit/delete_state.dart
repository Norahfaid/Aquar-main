part of 'delete_cubit.dart';

abstract class DeleteState extends Equatable {
  const DeleteState();

  @override
  List<Object> get props => [];
}

class DeleteInitial extends DeleteState {}

class DeleteAccountLoading extends DeleteState {}

class DeleteAccountSuccess extends DeleteState {}

class DeleteAccountError extends DeleteState {
  const DeleteAccountError({required this.message});
  final String message;
}
