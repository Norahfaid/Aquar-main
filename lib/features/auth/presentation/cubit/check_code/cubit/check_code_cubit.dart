import 'package:aquar/features/auth/domain/usecase/check_code_usecase.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../domain/models/check_code.dart';

part 'check_code_state.dart';

class CheckCodeCubit extends Cubit<CheckCodeState> {
  CheckCodeCubit(this.usecase) : super(CheckCodeInitial());

  final CheckCodeUseCase usecase;
  Future<void> fCheckCode({
    required String phone,
    required String code,
  }) async {
    {
      emit(CheckCodeLoadingState());
      final failOrUser =
          await usecase(CheckCodeParams(phone: phone, code: code));
      failOrUser.fold((fail) {
        if (fail is ServerFailure) {
          emit(CheckCodeErrorState(message: fail.message));
        }
      }, (response) {
        emit(CheckCodeSuccessState(response: response));
      });
    }
  }
}
