import 'package:dartz/dartz.dart';

import '../../../../../core/usecases/usecases.dart';
import '../../../../core/error/failures.dart';
import '../models/register_response.dart';
import '../repository/auth_repo.dart';

class RegisterUseCase extends UseCase<RegisterResponse, RegisterParams> {
  final AuthRepository repository;
  RegisterUseCase({required this.repository});
  @override
  Future<Either<Failure, RegisterResponse>> call(RegisterParams params) async {
    return await repository.register(params: params);
  }
}

class RegisterParams {
  final String? name;
  final String? phone;
  final int? cityId;
  final int? regionId;
  final String? licenseNumber;
  String? userTypeId;
  final String? password;
  final String? passConfirmation;
  // final String? nationalId;

  RegisterParams({
    this.phone,
    this.cityId,
    this.regionId,
    this.licenseNumber,
    this.userTypeId,
    this.password,
    this.passConfirmation,
    this.name,
    // this.nationalId,
  });
}
