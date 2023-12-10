part of 'get_user_ads_count_cubit.dart';

abstract class GetUserAdsCountState extends Equatable {
  const GetUserAdsCountState();

  @override
  List<Object> get props => [];
}

class GetUserAdsCountInitial extends GetUserAdsCountState {}

class UserAdsCountsLoadingState extends GetUserAdsCountState {}

class UserAdsCountsErrorState extends GetUserAdsCountState {
  final String message;

  const UserAdsCountsErrorState({required this.message});
}

class UserAdsCountsSuccessState extends GetUserAdsCountState {
  final UserAdsCountsResponse adsCount;

  const UserAdsCountsSuccessState({required this.adsCount});
}
