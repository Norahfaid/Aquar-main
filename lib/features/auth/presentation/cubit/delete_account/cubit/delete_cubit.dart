import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../../../core/widgets/toast.dart';
import '../../../../domain/usecase/delete_account.dart';

part 'delete_state.dart';

class DeleteCubit extends Cubit<DeleteState> {
  DeleteCubit(this.deleteAccount) : super(DeleteInitial());
  final DeleteAccountUseCase deleteAccount;
  Future<void> fDeleteAccount({required String password}) async {
    emit(DeleteAccountLoading());
    final failOrUnit =
        await deleteAccount(DeleteAccountParams(password: password));
    failOrUnit.fold((fail) {
      if (fail is ServerFailure) {
        emit(DeleteAccountError(message: fail.message));
      }
    }, (r) {
      showToast(tr("delete_acc_done"));
      emit(DeleteAccountSuccess());
    });
  }
}
