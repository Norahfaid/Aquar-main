import 'package:dartz/dartz.dart';

import '../../../../../core/usecases/usecases.dart';
import '../../../../core/error/failures.dart';
import '../models/cities_entity.dart';
import '../repository/auth_repo.dart';

class GetCitiesUseCase extends UseCase<CitiesResponse, NoParams> {
  final AuthRepository repository;
  GetCitiesUseCase({required this.repository});
  @override
  Future<Either<Failure, CitiesResponse>> call(NoParams params) async {
    return await repository.getCities();
  }
}
