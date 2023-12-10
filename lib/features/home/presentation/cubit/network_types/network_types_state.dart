import 'package:equatable/equatable.dart';

import '../../../domain/models/network_types.dart';

abstract class GetNetWorkTypesState extends Equatable {
  const GetNetWorkTypesState();

  @override
  List<Object> get props => [];
}

class GetNetWorkTypesInitial extends GetNetWorkTypesState {}

class ChooseRealStateState extends GetNetWorkTypesState {}

class GetNetWorkTypesSuccessState extends GetNetWorkTypesState {
  final List<NetWorkTypes> data;

  const GetNetWorkTypesSuccessState({required this.data});
}

class GetNetWorkTypesErrorState extends GetNetWorkTypesState {
  final String message;

  const GetNetWorkTypesErrorState({required this.message});
}

class GetNetWorkTypesLoadingState extends GetNetWorkTypesState {}
