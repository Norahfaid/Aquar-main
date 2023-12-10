part of 'get_profile_cubit.dart';

abstract class GetProfileState extends Equatable {
  const GetProfileState();

  @override
  List<Object> get props => [];
}

class GetProfileInitial extends GetProfileState {}

class GetProfileLoadingState extends GetProfileState {}

class GetProfileErrorState extends GetProfileState {
  final String message;
  const GetProfileErrorState({required this.message});
}

class GetProfileLoadedState extends GetProfileState {
  final User profileData;
  const GetProfileLoadedState({required this.profileData});
}
