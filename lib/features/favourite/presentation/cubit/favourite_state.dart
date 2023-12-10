part of 'favourite_cubit.dart';

abstract class FavouriteState extends Equatable {
  const FavouriteState();

  @override
  List<Object> get props => [];
}

class FavouriteInitial extends FavouriteState {}

class GetfavouritiesSuccessState extends FavouriteState {}

class GetfavouritiesErrorState extends FavouriteState {
  final String message;

  const GetfavouritiesErrorState({required this.message});
}

class GetfavouritiesLoadingState extends FavouriteState {}
