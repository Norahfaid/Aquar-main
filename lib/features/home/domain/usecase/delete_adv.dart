import 'package:dartz/dartz.dart';

import '../../../../../core/usecases/usecases.dart';
import '../../../../core/error/failures.dart';
import '../models/delete_adv.dart';
import '../repo/filter_repo.dart';

class DeleteAdvUseCase extends UseCase<DeleteAdvResponse, DeleteAdvParams> {
  final FilterRepository repository;
  DeleteAdvUseCase({required this.repository});
  @override
  Future<Either<Failure, DeleteAdvResponse>> call(
      DeleteAdvParams params) async {
    return await repository.deleteAdv(params: params);
  }
}

class DeleteAdvParams {
  final int id;

  DeleteAdvParams({required this.id});
}
