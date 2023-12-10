import 'package:aquar/features/settings/presentation/cubit/terms_annonce/cubit/terms_annonce_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../../../core/usecases/usecases.dart';
import '../../../../domain/usecase/terms_annonce.dart';

class TermsAnnonceCubit extends Cubit<TermsAnnonceState> {
  TermsAnnonceCubit(this.usecase) : super(TermsAnnonceInitial());

  final TermsAnnonceUsecase usecase;

  Future<void> fGetTermsAnnonce() async {
    emit(TermsAnnonceLoadingState());
    final failOrUser = await usecase(NoParams());
    failOrUser.fold((fail) {
      if (fail is ServerFailure) {
        emit(TermsAnnonceErrorState(message: fail.message));
      }
    }, (termsAnnonce) {
      // user2 = getProfileResponse.data;
      emit(TermsAnnonceSuccessState(response: termsAnnonce));
    });
  }
}
