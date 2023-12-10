import 'package:dartz/dartz.dart';

import '../../../../../core/usecases/usecases.dart';
import '../../../../core/error/failures.dart';
import '../repo/filter_repo.dart';

class DeleteImageUseCase extends UseCase<Unit, DeleteImageParams> {
  final FilterRepository repository;
  DeleteImageUseCase({required this.repository});
  @override
  Future<Either<Failure, Unit>> call(DeleteImageParams params) async {
    return await repository.deleteImage(params: params);
  }
}

class DeleteImageParams {
  final int imageId;

  DeleteImageParams({required this.imageId});
}
