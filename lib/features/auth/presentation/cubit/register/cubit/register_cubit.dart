import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../domain/models/register_response.dart';
import '../../../../domain/usecase/register_usecase.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.usecase) : super(RegisterInitial());

  bool? agree = false;
  final RegisterUseCase usecase;

  RegisterResponse? _user;
  RegisterResponse get user => _user!;
  set updateUser(RegisterResponse newUser) {
    _user = newUser;
    emit(RegisterInitial());
    emit(RegisterSuccessState(response: user));
  }

  String? userType;
  RegisterParams registerParams = RegisterParams();
  Future<void> fRegister({
    required GlobalKey<FormState> formKey,
    required String name,
    required String licenseNumber,
    required String phone,
    required int regionId,
    required String userTypeId,
    required int cityId,
    required String password,
    required String passwordConfirm,
    // required String nationalId,
  }) async {
    if (!formKey.currentState!.validate()) {
      return;
    } else {
      emit(RegisterLoodingState());
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.checkPermission();
      }
      final failOrUser = await usecase(RegisterParams(
        cityId: cityId,
        licenseNumber: licenseNumber,
        name: name,
        password: password,
        passConfirmation: passwordConfirm,
        phone: phone,
        regionId: regionId,
        userTypeId: userTypeId,
        // nationalId: nationalId,
      ));
      failOrUser.fold((fail) {
        if (fail is ServerFailure) {
          emit(RegisterErrorState(message: fail.message));
        }
      }, (response) {
        _user = response;
        emit(RegisterSuccessState(response: response));
      });
    }
  }

  //Terms
  agreeTerms(state) {
    switch (state == true) {
      case true:
        agree = true;
        emit(AcceptTermsState());
        break;
      case false:
        agree = false;
        emit(RejectTermsState());
    }
  }
}
