import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../domain/models/send_verification_code_register.dart';
import '../../../../domain/usecase/resend_reset_code.dart';

part 'resend_code_state.dart';

class SendVerifyCodeRegisterCubit extends Cubit<ResendCodeState> {
  SendVerifyCodeRegisterCubit(this.usecase) : super(ResendCodeInitial());
  final SensVerificationCodeRegisterUseCase usecase;
  Future<void> fResendCode({
    required String phone,
  }) async {
    {
      emit(ResendCodeLoadingState());
      final failOrUser = await usecase(ResendverificationRegisterCodeParams(
        phone: phone,
      ));
      failOrUser.fold((fail) {
        if (fail is ServerFailure) {
          emit(ResendCodeErrorState(message: fail.message));
        }
      }, (response) {
        emit(ResendCodeSuccessState(response: response));
      });
    }
  }
}
