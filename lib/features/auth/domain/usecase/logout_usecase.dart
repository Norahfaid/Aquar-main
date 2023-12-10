import 'package:dartz/dartz.dart';

import '../../../../../core/usecases/usecases.dart';
import '../../../../core/error/failures.dart';
import '../models/logout_response.dart';
import '../repository/auth_repo.dart';

class LogoutUseCase extends UseCase<LogoutResponse, LogoutParams> {
  final AuthRepository repository;
  LogoutUseCase({required this.repository});
  @override
  Future<Either<Failure, LogoutResponse>> call(LogoutParams params) async {
    return await repository.logout(params: params);
  }
}

class LogoutParams {
  String? fcmToken;
  LogoutParams({this.fcmToken});
}
