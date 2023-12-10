import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../../../injection_container/injection_container.dart';
import '../../../../domain/usecase/verify_change_phone.dart';
import '../../login_cubit/cubit/login_cubit_cubit.dart';

part 'verify_change_phone_state.dart';

class VerifyChangePhoneCubit extends Cubit<VerifyChangePhoneState> {
  VerifyChangePhoneCubit(this.usecase) : super(VerifyChangePhoneInitial());
  final VerifyChangePhoneUseCase usecase;
  Future<void> fChangePhone({
    required String phone,
    required String code,
  }) async {
    emit(VerifyChangePhoneLoadingState());
    final failOrUser = await usecase(VerifyChangePhoneParams(
      phone: phone,
      code: code,
    ));
    failOrUser.fold((fail) {
      if (fail is ServerFailure) {
        emit(VerifyChangePhoneErrorState(message: fail.message));
      }
    }, (response) {
      sl<LoginCubit>().updateUser = response.user!;
      emit(VerifyChangePhoneSuccessState());
    });
  }
}
