import 'package:dartz/dartz.dart';

import '../../../../../core/usecases/usecases.dart';
import '../../../../core/error/failures.dart';
import '../models/regines_entity.dart';
import '../repository/auth_repo.dart';

class GetReginsUseCase extends UseCase<RegiensResponse, ReginsParams> {
  final AuthRepository repository;
  GetReginsUseCase({required this.repository});
  @override
  Future<Either<Failure, RegiensResponse>> call(ReginsParams params) async {
    return await repository.getRegins(params: params);
  }
}

class ReginsParams {
  final int cityId;

  ReginsParams({
    required this.cityId,
  });
}
