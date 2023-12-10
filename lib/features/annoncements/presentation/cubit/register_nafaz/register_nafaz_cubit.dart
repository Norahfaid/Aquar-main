import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../injection_container/injection_container.dart';
import '../../../../auth/domain/models/login.dart';
import '../../../../auth/presentation/cubit/login_cubit/cubit/login_cubit_cubit.dart';
import '../../../domain/entities/register_nafaz_response.dart';
import '../../../domain/usecase/nafaz_usecase.dart';

part 'register_nafaz_state.dart';

class RegisterNafazCubit extends Cubit<RegisterNafazState> {
  RegisterNafazCubit(this.useCase) : super(RegisterNafazInitialState());

  final NafazUseCase useCase;

  Future<void> registerNafaz({required String? nationalId}) async {
    emit(RegisterNafazLoadingState());
    final failOrSuccess =
        await useCase(RegisterNafazParams(nationalId: nationalId));
    failOrSuccess.fold((fail) {
      if (fail is ServerFailure) {
        emit(RegisterNafazErrorState(message: fail.message));
      }
    }, (RegisterNafazResponse response) {
      if (response.user != null) {
        sl<LoginCubit>().updateUser = response.user!;
      }
      emit(RegisterNafazLoadedState(
        registerNafazUser: response.user,
      ));
    });
  }
}
