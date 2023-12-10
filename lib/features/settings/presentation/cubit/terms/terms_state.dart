part of 'terms_cubit.dart';

abstract class TermsState extends Equatable {
  const TermsState();

  @override
  List<Object> get props => [];
}

class GettermsInitial extends TermsState {}

class TermsLoadingState extends TermsState {}

class TermsErrorState extends TermsState {
  final String message;
  const TermsErrorState({required this.message});
}

class TermsSuccessState extends TermsState {
  final TermsResponse response;
  const TermsSuccessState({required this.response});
}
