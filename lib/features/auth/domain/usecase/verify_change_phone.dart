import 'package:dartz/dartz.dart';

import '../../../../../core/usecases/usecases.dart';
import '../../../../core/error/failures.dart';
import '../models/verify_change_phone.dart';
import '../repository/auth_repo.dart';

class VerifyChangePhoneUseCase
    extends UseCase<VerifyChangePhoneResponse, VerifyChangePhoneParams> {
  final AuthRepository repository;
  VerifyChangePhoneUseCase({required this.repository});
  @override
  Future<Either<Failure, VerifyChangePhoneResponse>> call(
      VerifyChangePhoneParams params) async {
    return await repository.verifyChangePhone(params: params);
  }
}

class VerifyChangePhoneParams {
  final String phone;
  final String code;

  VerifyChangePhoneParams({
    required this.phone,
    required this.code,
  });
}
