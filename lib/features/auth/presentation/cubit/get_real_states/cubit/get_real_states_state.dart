part of 'get_real_states_cubit.dart';

abstract class GetRealStatesState extends Equatable {
  const GetRealStatesState();

  @override
  List<Object> get props => [];
}

class GetRealStatesInitial extends GetRealStatesState {}
// class ChooseRealStateState extends GetRealStatesState {}

class GetRealStatesSuccessState extends GetRealStatesState {
  final List<RealStates> data;

  const GetRealStatesSuccessState({required this.data});
}

class GetRealStatesErrorState extends GetRealStatesState {
  final String message;

  const GetRealStatesErrorState({required this.message});
}

class GetRealStatesLoadingState extends GetRealStatesState {}
