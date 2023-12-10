import 'package:dartz/dartz.dart';

import '../../../../../core/usecases/usecases.dart';
import '../../../../core/error/failures.dart';
import '../models/aquar_details.dart';
import '../repo/filter_repo.dart';

class AquarDetailsUseCase
    extends UseCase<AquarDetailsResponse, AquarDetailsParams> {
  final FilterRepository repository;
  AquarDetailsUseCase({required this.repository});
  @override
  Future<Either<Failure, AquarDetailsResponse>> call(
      AquarDetailsParams params) async {
    return await repository.aquarDetails(params: params);
  }
}

class AquarDetailsParams {
  final int id;
  final bool fromDetails;

  AquarDetailsParams({required this.id, required this.fromDetails});
}
