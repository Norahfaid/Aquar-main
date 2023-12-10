import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../domain/usecase/change_phone.dart';

part 'change_phone_state.dart';

class ChangePhoneCubit extends Cubit<ChangePhoneState> {
  ChangePhoneCubit(this.usecase) : super(ChangePhoneInitial());
  final ChangePhoneUseCase usecase;
  Future<void> fChangePhone({
    required String phone,
  }) async {
    emit(ChangePhoneLoadingState());
    final failOrUser = await usecase(ChangePhoneParams(
      phone: phone,
    ));
    failOrUser.fold((fail) {
      if (fail is ServerFailure) {
        emit(ChangePhoneErrorState(message: fail.message));
      }
    }, (response) {
      emit(ChangePhoneSuccessState());
    });
  }
}
