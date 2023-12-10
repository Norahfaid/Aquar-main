part of 'about_us_cubit.dart';

abstract class AboutUsState extends Equatable {
  const AboutUsState();

  @override
  List<Object> get props => [];
}

class AboutUsInitial extends AboutUsState {}

class AboutUsErrorState extends AboutUsState {
  final String message;

  const AboutUsErrorState({required this.message});
}

class AboutUsSuccessState extends AboutUsState {
  final AboutUsResponse response;

  const AboutUsSuccessState({required this.response});
}

class AboutUsLoadingState extends AboutUsState {}
