part of 'delete_image_cubit.dart';

abstract class DeleteImageState extends Equatable {
  const DeleteImageState();

  @override
  List<Object> get props => [];
}

class DeleteImageInitial extends DeleteImageState {}

class DeleteImageSuccessState extends DeleteImageState {}

class DeleteImageErrorState extends DeleteImageState {
  final String message;

  const DeleteImageErrorState({required this.message});
}

class DeleteImageLoadingState extends DeleteImageState {}
