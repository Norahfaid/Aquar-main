import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../models/get_profile.dart';
import '../repository/auth_repo.dart';

class GetProfile extends UseCase<GetProfileResponse, NoParams> {
  final AuthRepository repository;
  GetProfile({required this.repository});
  @override
  Future<Either<Failure, GetProfileResponse>> call(NoParams params) async {
    return await repository.getProfile(noParams: params);
  }
}
