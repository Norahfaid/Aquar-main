import 'package:dartz/dartz.dart';

import '../../../../../core/usecases/usecases.dart';
import '../../../../core/error/failures.dart';
import '../models/change_phone.dart';
import '../repository/auth_repo.dart';

class ChangePhoneUseCase
    extends UseCase<ChangePhoneResponse, ChangePhoneParams> {
  final AuthRepository repository;
  ChangePhoneUseCase({required this.repository});
  @override
  Future<Either<Failure, ChangePhoneResponse>> call(
      ChangePhoneParams params) async {
    return await repository.changePhone(params: params);
  }
}

class ChangePhoneParams {
  final String phone;

  ChangePhoneParams({
    required this.phone,
  });
}
