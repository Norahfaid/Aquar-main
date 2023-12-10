import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../domain/models/reset_pass.dart';
import '../../../../domain/usecase/reset_pass_usecase.dart';

part 'reset_pass_state.dart';

class ResetPassCubit extends Cubit<ResetPassState> {
  ResetPassCubit(this.usecase) : super(ResetPassInitial());
  final ResetCodeUseCase usecase;
  Future<void> fResetPass({
    required GlobalKey<FormState> formKey,
    required String pass,
    required String passConfirm,
    required String token,
  }) async {
    if (!formKey.currentState!.validate()) {
      return;
    } else {
      emit(ResetPassLoadingState());
      final failOrUser = await usecase(ResetPassParams(
        pass: pass,
        passConfirm: passConfirm,
        token: token,
      ));
      failOrUser.fold((fail) {
        if (fail is ServerFailure) {
          emit(ResetPassErrorState(message: fail.message));
        }
      }, (response) {
        emit(ResetPassSuccessState(response: response));
      });
    }
  }
}
