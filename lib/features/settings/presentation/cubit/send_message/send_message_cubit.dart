import 'package:aquar/features/settings/domain/usecase/send_image.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failures.dart';

part 'send_message_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  SendMessageCubit({
    required this.sendMessage,
  }) : super(SendMessageInitial());

  final SendMessage sendMessage;

  Future<void> fSendMessage({required SendMessageParams params}) async {
    emit(SendMessageLoading());
    final failOrRes = await sendMessage(params);
    failOrRes.fold((l) {
      if (l is ServerFailure) {
        emit(SendMessageError(message: l.message));
      }
    }, (r) {
      emit(SendMessageSuccess());
    });
  }
}
