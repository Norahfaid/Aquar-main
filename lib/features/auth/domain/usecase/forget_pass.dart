import 'package:dartz/dartz.dart';

import '../../../../../core/usecases/usecases.dart';
import '../../../../core/error/failures.dart';
import '../models/forget_pass.dart';
import '../repository/auth_repo.dart';

class ForgetPassUseCase extends UseCase<ForgetPassResponse, ForgetPassParams> {
  final AuthRepository repository;
  ForgetPassUseCase({required this.repository});
  @override
  Future<Either<Failure, ForgetPassResponse>> call(
      ForgetPassParams params) async {
    return await repository.forgetPass(params: params);
  }
}

class ForgetPassParams {
  final String phone;

  ForgetPassParams({
    required this.phone,
  });
}
