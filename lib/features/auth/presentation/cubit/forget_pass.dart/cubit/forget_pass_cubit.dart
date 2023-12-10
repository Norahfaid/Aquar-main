import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../domain/models/forget_pass.dart';
import '../../../../domain/usecase/forget_pass.dart';

part 'forget_pass_state.dart';

class ForgetPassCubit extends Cubit<ForgetPassState> {
  ForgetPassCubit(this.usecase) : super(ForgetPassInitial());

  final ForgetPassUseCase usecase;
  Future<void> fForgetPass({
    required String phone,
  }) async {
    {
      emit(ForgetPassLoadingState());
      final failOrUser = await usecase(ForgetPassParams(phone: phone));
      failOrUser.fold((fail) {
        if (fail is ServerFailure) {
          emit(ForgetPassErrorState(message: fail.message));
        }
      }, (response) {
        emit(ForgetPassSuccessState(response: response));
      });
    }
  }
}
