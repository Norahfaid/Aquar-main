part of 'home_cubit.dart';

abstract class FilterState extends Equatable {
  const FilterState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends FilterState {}

class ChangeSelected extends FilterState {}

class NotMineAd extends FilterState {}

class MineAd extends FilterState {}

class ChangeSelectedId extends FilterState {}

class UnitCurrentPage extends FilterState {}

class GetFilterLoadingState extends FilterState {}

class GetFilterPaginationLoadingState extends FilterState {}

class GetFilterErrorState extends FilterState {
  final String message;

  const GetFilterErrorState({required this.message});
}

class GetFilterSuccessState extends FilterState {
  final List<AnnounceData> data;

  final List<Marker> markers;
  const GetFilterSuccessState({required this.data, required this.markers});
}
