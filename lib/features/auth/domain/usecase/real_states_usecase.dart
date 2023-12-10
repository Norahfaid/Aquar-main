import 'package:dartz/dartz.dart';

import '../../../../../core/usecases/usecases.dart';
import '../../../../core/error/failures.dart';
import '../models/real_state_types.dart';
import '../repository/auth_repo.dart';

class GetRealStatesUseCase extends UseCase<RealStateTypesResponse, RealStatesParams> {
  final AuthRepository repository;
  GetRealStatesUseCase({required this.repository});
  @override
  Future<Either<Failure, RealStateTypesResponse>> call(RealStatesParams params) async {
    return await repository.getRealStates();
  }
}
class RealStatesParams{
   String ?id;

  RealStatesParams({this.id});

}