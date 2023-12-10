import 'package:dartz/dartz.dart';

import '../../../../../core/usecases/usecases.dart';
import '../../../../core/error/failures.dart';
import '../models/reset_pass.dart';
import '../repository/auth_repo.dart';

class ResetCodeUseCase extends UseCase<ResetPassResponse, ResetPassParams> {
  final AuthRepository repository;
  ResetCodeUseCase({required this.repository});
  @override
  Future<Either<Failure, ResetPassResponse>> call(
      ResetPassParams params) async {
    return await repository.resetPass(params: params);
  }
}

class ResetPassParams {
  final String token;
  final String pass;
  final String passConfirm;

  ResetPassParams({
    required this.token,
    required this.pass,
    required this.passConfirm,
  });
}
