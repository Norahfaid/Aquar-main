part of 'edit_profile_cubit.dart';

abstract class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object> get props => [];
}

class EditProfileInitial extends EditProfileState {}

class ImageNotChangeState extends EditProfileState {}

class UploadImage extends EditProfileState {}

class ImagesChangeStates extends EditProfileState {
  final File avatar;
  const ImagesChangeStates({required this.avatar});
}

class NoChangeDetectedState extends EditProfileState {}

class EditProfileLoodingState extends EditProfileState {}

class EditProfileErrorState extends EditProfileState {
  final String message;
  const EditProfileErrorState({required this.message});
}

class EditProfileSuccessState extends EditProfileState {
  final User userProfile;
  const EditProfileSuccessState({required this.userProfile});
}
