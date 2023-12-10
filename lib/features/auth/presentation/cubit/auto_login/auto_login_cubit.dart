import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecases.dart';
import '../../../../../injection_container/injection_container.dart';
import '../../../../home/presentation/widgets/guest_alert.dart';
import '../../../domain/models/login.dart';
import '../../../domain/usecase/auto_login.dart';
import '../login_cubit/cubit/login_cubit_cubit.dart';

part 'auto_login_state.dart';

class AutoLoginCubit extends Cubit<AutoLoginState> {
  AutoLoginCubit({required this.autoLogin}) : super(AutoLoginInitial());
  final AutoLoginUsecase autoLogin;

  Future<void> fAutoLogin() async {
    emit(AutoLoginLoading());
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.checkPermission();
    }
    final failOrUser = await autoLogin(NoParams());
    failOrUser.fold((fail) async {
      await Future.delayed(const Duration(seconds: 5));
      if (fail is AuthFailure) {
        emit(AutoAuthInternetError());
      } else if (fail is ServerFailure) {
        emit(AutoLoginInternetError());
      } else if (fail is CacheFailure) {
        emit(AutoLoginGuest());
      }
    }, (user) async {
      await Future.delayed(const Duration(seconds: 5));
      if (user.verified) {
        emit(AutoLoginHasUser(user: user));
        sl<LoginCubit>().updateUser = user;
      } else {
        emit(AutoLoginNoUser());
      }
    });
  }

  bool get isGuest => state is AutoLoginGuest;
  bool get isUser => state is AutoLoginHasUser;
  void loginOrFunction(
      {required BuildContext context, required Function function}) {
    if (isGuest) {
      showDialog(context: context, builder: (c) => const GuestDialoug());
    } else {
      function();
    }
  }

  void emitLoading() {
    emit(AutoLoginInitial());
    emit(AutoLoginLoading());
  }

  emitHasUser({required User user}) {
    emit(AutoLoginInitial());
    emit(AutoLoginHasUser(user: user));
  }

  void emitSeenIntro() {
    emit(AutoLoginInitial());
    emit(AutoLoginSeenIntro());
  }

  emitNoUser() {
    emit(AutoLoginInitial());
    emit(AutoLoginNoUser());
  }

  emitGuest() {
    emit(AutoLoginInitial());
    emit(AutoLoginGuest());
  }

  void emitChangeLang() async {
    final lastState = state;
    emit(AutoLoginLoading());
    await Future.delayed(const Duration(seconds: 5));
    emit(lastState);
  }
}
