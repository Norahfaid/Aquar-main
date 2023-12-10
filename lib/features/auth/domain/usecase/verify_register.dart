import 'package:dartz/dartz.dart';

import '../../../../../core/usecases/usecases.dart';
import '../../../../core/error/failures.dart';
import '../models/submit_register.dart';
import '../repository/auth_repo.dart';

class VerifyRegisterUseCase
    extends UseCase<VerifyRegisterResponse, VerifyRegisterParams> {
  final AuthRepository repository;
  VerifyRegisterUseCase({required this.repository});
  @override
  Future<Either<Failure, VerifyRegisterResponse>> call(
      VerifyRegisterParams params) async {
    return await repository.verifyRegister(params: params);
  }
}

class VerifyRegisterParams {
  final String code;
  final String phone;

  VerifyRegisterParams({required this.code, required this.phone});
}
