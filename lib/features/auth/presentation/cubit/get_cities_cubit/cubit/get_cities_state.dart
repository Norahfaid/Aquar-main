part of 'get_cities_cubit.dart';

abstract class GetCitiesState extends Equatable {
  const GetCitiesState();

  @override
  List<Object> get props => [];
}

class GetCitiesInitial extends GetCitiesState {}

class GetCitiesSuccessState extends GetCitiesState {}

class GetCitiesErrorState extends GetCitiesState {
  final String message;

  const GetCitiesErrorState({required this.message});
}

class GetCitiesLoadingState extends GetCitiesState {}
