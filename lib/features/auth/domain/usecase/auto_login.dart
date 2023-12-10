import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../models/login.dart';
import '../repository/auth_repo.dart';

class AutoLoginUsecase extends UseCase<User, NoParams> {
  final AuthRepository repository;
  AutoLoginUsecase({required this.repository});
  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.autoLogin();
  }
}
