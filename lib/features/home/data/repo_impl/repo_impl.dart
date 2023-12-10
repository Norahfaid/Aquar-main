import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/local/auth_local_datasource.dart';
import '../../../auth/data/datasource/auth_datasource.dart';
import '../../domain/models/add_annoncement_response.dart';
import '../../domain/models/aquar_details.dart';
import '../../domain/models/delete_adv.dart';
import '../../domain/models/filter.dart';
import '../../domain/models/network_types.dart';
import '../../domain/models/notifications.dart';
import '../../domain/models/update_ad_response.dart';
import '../../domain/models/user_ads_counts.dart';
import '../../domain/repo/filter_repo.dart';
import '../../domain/usecase/add_annonce.dart';
import '../../domain/usecase/aquar_details.dart';
import '../../domain/usecase/delete_adv.dart';
import '../../domain/usecase/delete_image.dart';
import '../../domain/usecase/filter_usecase.dart';
import '../../domain/usecase/network_types.dart';
import '../../domain/usecase/update_ad.dart';
import '../datasource/filter_datasource.dart';

class FilterRepositoryImp extends FilterRepository {
  final AuthLocalDataSource authLocal;
  final AuthRemoteDataSource authRemote;
  final FilterRemoteDatasource remote;
  final FirebaseMessaging firebaseMessaging;
  FilterRepositoryImp(
      {required this.authRemote,
      required this.authLocal,
      required this.firebaseMessaging,
      required this.remote});

  @override
  Future<Either<Failure, FilterResponse>> getFilter(
      {required FilterParams params}) async {
    try {
      final token = authLocal.getCacheUserAccessTokenForFiltter();
      final getFilter = await remote.getFilter(params: params, token: token);
      return Right(getFilter);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, FilterResponse>> getMineAdsFilter(
      {required FilterParams params}) async {
    try {
      final token = authLocal.getCacheUserAccessToken();
      final getFilter =
          await remote.getMineFilter(params: params, token: token);
      return Right(getFilter);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, AddAnnoncementResponse>> addAnnoncement(
      {required AddAnnoncementParams params}) async {
    try {
      final token = authLocal.getCacheUserAccessToken();
      final addAnnonce =
          await remote.addAnnoncement(params: params, token: token);
      // final loginInfo = await authLocal.getCacheUserLoginInfo();
      // loginInfo.deviceToken = await firebaseMessaging.getToken();
      // final user = await authRemote.login(params: loginInfo);
      // await authLocal.cacheUserAccessToken(token: user.data.token);
      // await authLocal.cacheUserLoginInfo(params: loginInfo);
      // addAnnonce.user = user.data;
      return Right(addAnnonce);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, UpdateAnnoncementResponse>> updateAnnoncement(
      {required UpdateAnnouncementParams params}) async {
    try {
      final token = authLocal.getCacheUserAccessToken();
      final updateAnnonce =
          await remote.updateAnnoncement(params: params, token: token);
      // final loginInfo = await authLocal.getCacheUserLoginInfo();
      // loginInfo.deviceToken = await firebaseMessaging.getToken();
      // final user = await authRemote.login(params: loginInfo);
      // await authLocal.cacheUserAccessToken(token: user.data.token);
      // await authLocal.cacheUserLoginInfo(params: loginInfo);
      // addAnnonce.user = user.data;
      return Right(updateAnnonce);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, NetWorkTypesResponse>> getNetWorkTypes(
      {required NetWorkTypesParams params}) async {
    try {
      final token = authLocal.getCacheUserAccessToken();
      final getNetworkTypes =
          await remote.getNetWorkTypes(params: params, token: token);
      return Right(getNetworkTypes);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, NotificationsResponse>> getNotifications() async {
    try {
      final token = authLocal.getCacheUserAccessToken();
      final getNotifications = await remote.getNotifications(token: token);
      return Right(getNotifications);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, DeleteAdvResponse>> deleteAdv({
    required DeleteAdvParams params,
  }) async {
    try {
      final token = authLocal.getCacheUserAccessToken();
      final deleteAdv = await remote.deleteAdv(token: token, params: params);
      // final loginInfo = await authLocal.getCacheUserLoginInfo();
      // loginInfo.deviceToken = await firebaseMessaging.getToken();
      // final user = await authRemote.login(params: loginInfo);
      // await authLocal.cacheUserAccessToken(token: user.data.token);
      // await authLocal.cacheUserLoginInfo(params: loginInfo);
      // deleteAdv.user = user.data;
      return Right(deleteAdv);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteImage(
      {required DeleteImageParams params}) async {
    try {
      final token = authLocal.getCacheUserAccessToken();
      await remote.deleteImage(token: token, params: params);
      return const Right(unit);
      // final deleteImage =
      //     await remote.deleteImage(token: token, params: params);

      // return Right(deleteImage);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, UserAdsCountsResponse>> getUserAdsCounts() async {
    try {
      final token = authLocal.getCacheUserAccessToken();
      final getUserAdsCounts = await remote.getUserAdsCounts(
        token: token,
      );

      return Right(getUserAdsCounts);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, AquarDetailsResponse>> aquarDetails(
      {required AquarDetailsParams params}) async {
    try {
      final token = authLocal.getCacheUserAccessTokenForFiltter();
      final getUserAdsCounts =
          await remote.aquarDetails(params: params, token: token);

      return Right(getUserAdsCounts);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
