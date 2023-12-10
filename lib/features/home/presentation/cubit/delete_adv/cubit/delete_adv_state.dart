part of 'delete_adv_cubit.dart';

abstract class DeleteAdvState extends Equatable {
  const DeleteAdvState();

  @override
  List<Object> get props => [];
}

class DeleteAdvInitial extends DeleteAdvState {}

class DeleteAdvSuccessState extends DeleteAdvState {
  final DeleteAdvResponse res;

  const DeleteAdvSuccessState({required this.res});
}

class DeleteAdvErrorState extends DeleteAdvState {
  final String message;

  const DeleteAdvErrorState({required this.message});
}

class DeleteAdvLoadingState extends DeleteAdvState {}
