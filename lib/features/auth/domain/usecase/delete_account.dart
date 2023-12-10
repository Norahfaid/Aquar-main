import 'package:dartz/dartz.dart';

import '../../../../../core/usecases/usecases.dart';
import '../../../../core/error/failures.dart';
import '../repository/auth_repo.dart';

class DeleteAccountUseCase extends UseCase<Unit, DeleteAccountParams> {
  final AuthRepository repository;
  DeleteAccountUseCase({required this.repository});
  @override
  Future<Either<Failure, Unit>> call(DeleteAccountParams params) async {
    return await repository.deleteAccount(params: params);
  }
}

class DeleteAccountParams {
  final String password;
  DeleteAccountParams({required this.password}
      );
}
