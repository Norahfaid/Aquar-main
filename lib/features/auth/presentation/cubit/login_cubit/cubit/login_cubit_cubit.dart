import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../domain/models/login.dart';
import '../../../../domain/usecase/login_usecase.dart';

part 'login_cubit_state.dart';

class LoginCubit extends Cubit<LoginCubitState> {
  LoginCubit(this.login) : super(LoginCubitInitial());

//Use case
  final LoginUseCase login;
  User? user2;
  bool isUser = false;

  User get user {
    return user2!;
  }

// TextEditingController password =TextEditingController();

  set updateUser(User newUser) {
    user2 = newUser;
    emit(LoginCubitInitial());
    emit(LoginSuccessState(user: user));
  }

  Future<void> fUserLogin(
      {required GlobalKey<FormState> formKey,
      required String phone,
      required String password}) async {
    if (!formKey.currentState!.validate()) {
      return;
    } else {
      emit(LoginLoadingState());
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.checkPermission();
      }
      final failOrUser =
          await login(LoginParams(password: password, phone: phone));
      failOrUser.fold((fail) {
        if (fail is ServerFailure) {
          emit(LoginErrorState(message: fail.message));
        }
      }, (user) {
        user2 = user.data;

        emit(LoginSuccessState(user: user.data));
      });
    }
  }
}
