import 'package:dartz/dartz.dart';

import '../../../../../core/usecases/usecases.dart';
import '../../../../core/error/failures.dart';
import '../models/notifications.dart';
import '../repo/filter_repo.dart';

class NotificationsUseCase extends UseCase<NotificationsResponse, NoParams> {
  final FilterRepository repository;
  NotificationsUseCase({required this.repository});
  @override
  Future<Either<Failure, NotificationsResponse>> call(NoParams params) async {
    return await repository.getNotifications();
  }
}
