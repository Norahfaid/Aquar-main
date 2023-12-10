part of 'social_links_cubit.dart';

abstract class SocialLinksState extends Equatable {
  const SocialLinksState();

  @override
  List<Object> get props => [];
}

class SocialLinksInitial extends SocialLinksState {}

class SocialLinksSuccessState extends SocialLinksState {
  final SocialLinksResponse response;

  const SocialLinksSuccessState({required this.response});
}

class SocialLinksErrorState extends SocialLinksState {
  final String message;

  const SocialLinksErrorState({required this.message});
}

class SocialLinksLoadingState extends SocialLinksState {}
