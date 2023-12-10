part of 'update_annoncement_cubit.dart';

abstract class UpdateAnnoncementState extends Equatable {
  const UpdateAnnoncementState();

  @override
  List<Object> get props => [];
}

class UpdateAnnoncementInitial extends UpdateAnnoncementState {}

class RemoveId extends UpdateAnnoncementState {}

class AddId extends UpdateAnnoncementState {}

class SelectNetWorkId extends UpdateAnnoncementState {}

class UpdateAnnoncementLoadingState extends UpdateAnnoncementState {}

class ImageNotChangeState extends UpdateAnnoncementState {}

class UpdatedImage extends UpdateAnnoncementState {
  // final List<File> images;
  // const UpdatedImage({required this.images});
}

class ImagesChangeStates extends UpdateAnnoncementState {
  // final File avtar;

  // const ImagesChangeStates({required this.avtar});
}

class UploadImage extends UpdateAnnoncementState {}

class UpdateAnnoncementErrorState extends UpdateAnnoncementState {
  final String mesage;

  const UpdateAnnoncementErrorState({required this.mesage});
}

class UpdateAnnoncementSuccessState extends UpdateAnnoncementState {
  final UpdateAdData data;

  const UpdateAnnoncementSuccessState({required this.data});
}

class UploadingImageState extends UpdateAnnoncementState {}

class UploadoingImageState extends UpdateAnnoncementState {}

class UploadoingImageDoneState extends UpdateAnnoncementState {
  final String collection;
  const UploadoingImageDoneState({required this.collection});
}

class NoImageSelected extends UpdateAnnoncementState {}

class UploadoingImageErrorState extends UpdateAnnoncementState {}

class UploadiImageLoading extends UpdateAnnoncementState {}
