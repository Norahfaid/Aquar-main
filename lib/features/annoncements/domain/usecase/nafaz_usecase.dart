import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/register_nafaz_response.dart';
import '../repo/nafaz_repo.dart';

class NafazUseCase extends UseCase<RegisterNafazResponse, RegisterNafazParams> {
  final NafazRepository repository;

  NafazUseCase({required this.repository});

  @override
  Future<Either<Failure, RegisterNafazResponse>> call(RegisterNafazParams params) async {
    return await repository.registerNafaz(params: params);
  }
}

class RegisterNafazParams extends Equatable {
  final String? nationalId;

  const RegisterNafazParams({required this.nationalId});

  @override
  List<Object?> get props => [nationalId];

}
