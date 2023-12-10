part of 'aquar_details_cubit.dart';

abstract class AquarDetailsState extends Equatable {
  const AquarDetailsState();

  @override
  List<Object> get props => [];
}

class AquarDetailsInitial extends AquarDetailsState {}

class AquarDetailsLoadingState extends AquarDetailsState {}

class AquarDetailsSuccessState extends AquarDetailsState {}

class AquarDetailsErrorState extends AquarDetailsState {
  final String message;

  const AquarDetailsErrorState({required this.message});
}
