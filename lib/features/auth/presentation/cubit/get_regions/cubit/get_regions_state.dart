part of 'get_regions_cubit.dart';

abstract class GetRegionsState extends Equatable {
  const GetRegionsState();

  @override
  List<Object> get props => [];
}

class GetRegionsInitial extends GetRegionsState {}

class GetRegionsSuccess extends GetRegionsState {}

class GetRegionsLoading extends GetRegionsState {}

class GetRegionsError extends GetRegionsState {
  final String message;

  const GetRegionsError({required this.message});
}
