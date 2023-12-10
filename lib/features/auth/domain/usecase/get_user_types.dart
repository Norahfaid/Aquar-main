// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import '../../../../../core/usecases/usecases.dart';
import '../../../../core/error/failures.dart';
import '../models/user_types.dart';
import '../repository/auth_repo.dart';

class GetUserTypeUseCase extends UseCase<UserTypesResponse, GetUserTypeParams> {
  final AuthRepository repository;
  GetUserTypeUseCase({required this.repository});
  @override
  Future<Either<Failure, UserTypesResponse>> call(
      GetUserTypeParams params) async {
    return await repository.getUseType(params: params);
  }
}

class GetUserTypeParams {
  UserType? userType;
  GetUserTypeParams({
    this.userType,
  });
}
