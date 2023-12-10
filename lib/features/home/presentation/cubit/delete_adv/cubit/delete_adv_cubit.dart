import 'package:aquar/features/home/domain/usecase/delete_adv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../domain/models/delete_adv.dart';

part 'delete_adv_state.dart';

class DeleteAdvCubit extends Cubit<DeleteAdvState> {
  DeleteAdvCubit(this.usecase) : super(DeleteAdvInitial());

  final DeleteAdvUseCase usecase;
  Future<void> fDeleteAdv({required int id}) async {
    emit(DeleteAdvLoadingState());
    final failOrUser = await usecase(DeleteAdvParams(id: id));
    failOrUser.fold((fail) {
      if (fail is ServerFailure) {
        emit(DeleteAdvErrorState(message: fail.message));
      }
    }, (deleteAdv) {
      // sl<LoginCubit>().updateUser = deleteAdv.user!;
      emit(DeleteAdvSuccessState(res: deleteAdv));
    });
  }
}
