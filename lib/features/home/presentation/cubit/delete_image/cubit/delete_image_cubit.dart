import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../domain/usecase/delete_image.dart';

part 'delete_image_state.dart';

class DeleteImageCubit extends Cubit<DeleteImageState> {
  DeleteImageCubit(this.useCase) : super(DeleteImageInitial());
  final DeleteImageUseCase useCase;

  Future<void> fDeleteImage({required int imageId}) async {
    emit(DeleteImageLoadingState());
    final failOrUser = await useCase(DeleteImageParams(imageId: imageId));
    failOrUser.fold((fail) {
      if (fail is ServerFailure) {
        emit(DeleteImageErrorState(message: fail.message));
      }
    }, (deleteImage) {
      emit(DeleteImageSuccessState());
    });
  }
}
