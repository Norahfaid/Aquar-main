import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../../home/domain/models/notifications.dart';
import '../../../home/domain/usecase/notifications.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this.usecase) : super(NotificationsInitial());

  final NotificationsUseCase usecase;

  List<NotificationList> _data = [];
  List<NotificationList> get data {
    return _data;
  }

  Future<void> fGetNotifications() async {
    emit(GetNotificationsLoadingState());
    final failOrUser = await usecase(NoParams());
    failOrUser.fold((fail) {
      if (fail is ServerFailure) {
        emit(GetNotificationsErrorState(message: fail.message));
      }
    }, (networkTypes) {
      _data = networkTypes.data.data;
      emit(GetNotificationsSuccessState(data: networkTypes.data.data));
    });
  }
}
