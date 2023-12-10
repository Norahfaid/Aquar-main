import 'package:dartz/dartz.dart';

import '../../../../../core/usecases/usecases.dart';
import '../../../../core/error/failures.dart';
import '../models/check_code.dart';
import '../repository/auth_repo.dart';

class CheckCodeUseCase
    extends UseCase<CheckCodeForgetPassResponse, CheckCodeParams> {
  final AuthRepository repository;
  CheckCodeUseCase({required this.repository});
  @override
  Future<Either<Failure, CheckCodeForgetPassResponse>> call(
      CheckCodeParams params) async {
    return await repository.checkCode(params: params);
  }
}

class CheckCodeParams {
  final String phone;
  final String code;

  CheckCodeParams({
    required this.code,
    required this.phone,
  });
}
