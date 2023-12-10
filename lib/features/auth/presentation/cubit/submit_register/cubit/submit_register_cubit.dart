import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../domain/models/submit_register.dart';
import '../../../../domain/usecase/verify_register.dart';

part 'submit_register_state.dart';

class SubmitRegisterCubit extends Cubit<SubmitRegisterState> {
  SubmitRegisterCubit(this.usecase) : super(SubmitRegisterInitial());

  final VerifyRegisterUseCase usecase;

  VerifyRegisterResponse? _user;
  VerifyRegisterResponse get user => _user!;
  set updateUser(VerifyRegisterResponse newUser) {
    _user = newUser;
    emit(SubmitRegisterInitial());
    emit(VerifyRegisterSuccessState(response: user));
  }

  String code = "";
  updateCode(String newCode) {
    emit(SubmitRegisterInitial());
    code = newCode;
    emit(SubmitRegisterNewCode());
  }

  Future<void> fVerifyRegister({
    required GlobalKey<FormState> formKey,
    required String code,
    required String phone,
  }) async {
    if (!formKey.currentState!.validate()) {
      return;
    } else {
      emit(VerifyRegisterLoodingState());
      final failOrUser = await usecase(VerifyRegisterParams(
        phone: phone,
        code: code,
      ));
      failOrUser.fold((fail) {
        if (fail is ServerFailure) {
          emit(VerifyRegisterErrorState(message: fail.message));
        }
      }, (response) {
        _user = response;
        emit(VerifyRegisterSuccessState(response: response));
      });
    }
  }
}
