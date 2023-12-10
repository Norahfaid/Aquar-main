import 'package:equatable/equatable.dart';

import '../../../../domain/models/terms_annonce.dart';

abstract class TermsAnnonceState extends Equatable {
  const TermsAnnonceState();

  @override
  List<Object> get props => [];
}

class TermsAnnonceInitial extends TermsAnnonceState {}

class TermsAnnonceLoadingState extends TermsAnnonceState {}

class TermsAnnonceErrorState extends TermsAnnonceState {
  final String message;

  const TermsAnnonceErrorState({required this.message});
}

class TermsAnnonceSuccessState extends TermsAnnonceState {
  final TermsAnnonceResponse response;

  const TermsAnnonceSuccessState({required this.response});
}
