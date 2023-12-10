import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecases.dart';
import '../../../domain/models/terms.dart';
import '../../../domain/usecase/terms.dart';

part 'terms_state.dart';

class TermsCubit extends Cubit<TermsState> {
  TermsCubit(this.usecase) : super(GettermsInitial());

  final TermsUsecase usecase;
  Future<void> fGetTerms() async {
    emit(TermsLoadingState());
    final failOrUser = await usecase(NoParams());
    failOrUser.fold((fail) {
      if (fail is ServerFailure) {
        emit(TermsErrorState(message: fail.message));
      }
    }, (terms) {
      // user2 = getProfileResponse.data;
      emit(TermsSuccessState(response: terms));
    });
  }
}
