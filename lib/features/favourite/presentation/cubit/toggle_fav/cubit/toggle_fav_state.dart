part of 'toggle_fav_cubit.dart';

abstract class ToggleFavState extends Equatable {
  const ToggleFavState();

  @override
  List<Object> get props => [];
}

class ToggleFavInitial extends ToggleFavState {}

class TogglefavouritiesSuccessState extends ToggleFavState {}

class TogglefavouritiesErrorState extends ToggleFavState {
  final String message;

  const TogglefavouritiesErrorState({required this.message});
}

class TogglefavouritiesLoadingState extends ToggleFavState {}
