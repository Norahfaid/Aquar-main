import 'package:aquar/features/annoncements/domain/entities/register_nafaz_response.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/local/auth_local_datasource.dart';
import '../../domain/repo/nafaz_repo.dart';
import '../../domain/usecase/nafaz_usecase.dart';
import '../datasource/nafaz_remote_datasource.dart';

class NafazRepositoryImp extends NafazRepository {
  final AuthLocalDataSource authLocal;
  final NafazRemoteDatasource remote;

  NafazRepositoryImp({required this.authLocal, required this.remote});

  @override
  Future<Either<Failure, RegisterNafazResponse>> registerNafaz({required RegisterNafazParams params}) async{
    try {
      final token = authLocal.getCacheUserAccessTokenForFiltter();
      final registerNafazResponse = await remote.registerNafaz(params: params, token: token,);
      return Right(registerNafazResponse);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
