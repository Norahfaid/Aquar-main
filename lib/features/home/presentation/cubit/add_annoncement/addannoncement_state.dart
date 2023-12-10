part of 'addannoncement_cubit.dart';

@immutable
abstract class AddannoncementState {}

class AddannoncementInitial extends AddannoncementState {}

class SelectNetWorkId extends AddannoncementState {}

class RemoveId extends AddannoncementState {}

class AddId extends AddannoncementState {}

class AddAnnoncementLoadingState extends AddannoncementState {}

class ImageNotChangeState extends AddannoncementState {}

class UpdatedImage extends AddannoncementState {
  final List<File> images;
  UpdatedImage({required this.images});
}

class ImagesChangeStates extends AddannoncementState {
  final File avtar;

  ImagesChangeStates({required this.avtar});
}

class UploadImage extends AddannoncementState {}

class AddAnnoncementErrorState extends AddannoncementState {
  final String mesage;

  AddAnnoncementErrorState({required this.mesage});
}

class AddAnnoncementSuccessState extends AddannoncementState {
  final AnnonceData data;

  AddAnnoncementSuccessState({required this.data});
}

class UploadingImageState extends AddannoncementState {}

class UploadoingImageState extends AddannoncementState {}

class UploadoingImageDoneState extends AddannoncementState {
  final String collection;
  UploadoingImageDoneState({required this.collection});
}

class NoImageSelected extends AddannoncementState {}

class UploadoingImageErrorState extends AddannoncementState {}

class UploadiImageLoading extends AddannoncementState {}
