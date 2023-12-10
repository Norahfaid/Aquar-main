part of 'similar_ads_cubit.dart';

abstract class SimilarAdsState extends Equatable {
  const SimilarAdsState();

  @override
  List<Object> get props => [];
}

class SimilarAdsInitial extends SimilarAdsState {}

class GetSimilarAdsSuccessState extends SimilarAdsState {
  final List<AnnounceData> data;

  const GetSimilarAdsSuccessState({required this.data});
}

class GetSimilarAdsErrorState extends SimilarAdsState {
  final String message;

  const GetSimilarAdsErrorState({required this.message});
}

class GetSimilarAdsLoadingState extends SimilarAdsState {}

class GetSimilarAdsPaginationLoadingState extends SimilarAdsState {}
