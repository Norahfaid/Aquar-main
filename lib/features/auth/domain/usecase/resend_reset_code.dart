import 'package:dartz/dartz.dart';

import '../../../../../core/usecases/usecases.dart';
import '../../../../core/error/failures.dart';
import '../models/send_verification_code_register.dart';
import '../repository/auth_repo.dart';

class SensVerificationCodeRegisterUseCase extends UseCase<
    SensVerificationCodeRegisterResponse,
    ResendverificationRegisterCodeParams> {
  final AuthRepository repository;
  SensVerificationCodeRegisterUseCase({required this.repository});
  @override
  Future<Either<Failure, SensVerificationCodeRegisterResponse>> call(
      ResendverificationRegisterCodeParams params) async {
    return await repository.resendverificationRegisterCode(params: params);
  }
}

class ResendverificationRegisterCodeParams {
  final String phone;

  ResendverificationRegisterCodeParams({
    required this.phone,
  });
}
