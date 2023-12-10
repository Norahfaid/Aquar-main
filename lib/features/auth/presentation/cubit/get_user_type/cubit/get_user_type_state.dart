part of 'get_user_type_cubit.dart';

abstract class GetUserTypeState extends Equatable {
  const GetUserTypeState();

  @override
  List<Object> get props => [];
}

class GetUserTypeInitial extends GetUserTypeState {}

class ChooseStateState extends GetUserTypeState {}

class GetUserTypeLoadingState extends GetUserTypeState {}

class GetUserTypeErrorState extends GetUserTypeState {
  final String message;

  const GetUserTypeErrorState({required this.message});
}

class GetUserTypeSuccessState extends GetUserTypeState {}
