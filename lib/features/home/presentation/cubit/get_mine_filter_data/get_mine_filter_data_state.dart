part of 'get_mine_filter_data_cubit.dart';

abstract class GetMineFilterDataState {}

class GetMineFilterDataInitial extends GetMineFilterDataState {}

class GetMineFilterLoadingState extends GetMineFilterDataState {}

class GetMineFilterPaginationLoadingState extends GetMineFilterDataState {}

class GetMineFilterErrorState extends GetMineFilterDataState {
  final String message;

  GetMineFilterErrorState({required this.message});
}

class GetMineFilterSuccessState extends GetMineFilterDataState {
  final List<AnnounceData> data;

  GetMineFilterSuccessState({required this.data});
}
