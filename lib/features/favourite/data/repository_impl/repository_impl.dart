import 'package:aquar/features/favourite/domain/models/get_favourities.dart';
import 'package:aquar/features/favourite/domain/models/toggle_fav.dart';
import 'package:aquar/features/favourite/domain/usecase/get_fav.dart';
import 'package:aquar/features/favourite/domain/usecase/toggle_fav.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/local/auth_local_datasource.dart';
import '../../domain/repo/fav_repo.dart';
import '../datasource/remote_datasource.dart';

class FavRepositoryImp extends FavRepository {
  final AuthLocalDataSource authLocal;
  final GetFavRemoteDatasource remote;
  FavRepositoryImp({required this.authLocal, required this.remote});

  @override
  Future<Either<Failure, GetFavouritiesResponse>> getFavourities(
      {required GetFavParams params}) async {
    try {
      final token = authLocal.getCacheUserAccessToken();
      final getFav = await remote.getFav(params: params, token: token);
      return Right(getFav);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, ToggleFavouritiesResponse>> toggleFavourities(
      {required ToggleFavParams params}) async {
    try {
      final token = authLocal.getCacheUserAccessToken();
      final toggleFav = await remote.toggleFav(params: params, token: token);
      return Right(toggleFav);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
