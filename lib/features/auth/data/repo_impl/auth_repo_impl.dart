// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:aquar/features/auth/domain/models/change_phone.dart';
import 'package:aquar/features/auth/domain/models/real_state_types.dart';
import 'package:aquar/features/auth/domain/models/verify_change_phone.dart';
import 'package:aquar/features/auth/domain/usecase/change_phone.dart';
import 'package:aquar/features/auth/domain/usecase/verify_change_phone.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/local/auth_local_datasource.dart';
import '../../../../core/usecases/usecases.dart';
import '../../domain/models/check_code.dart';
import '../../domain/models/cities_entity.dart';
import '../../domain/models/forget_pass.dart';
import '../../domain/models/get_profile.dart';
import '../../domain/models/login.dart';
import '../../domain/models/logout_response.dart';
import '../../domain/models/regines_entity.dart';
import '../../domain/models/register_response.dart';
import '../../domain/models/reset_pass.dart';
import '../../domain/models/send_verification_code_register.dart';
import '../../domain/models/submit_register.dart';
import '../../domain/models/user_types.dart';
import '../../domain/repository/auth_repo.dart';
import '../../domain/usecase/check_code_usecase.dart';
import '../../domain/usecase/delete_account.dart';
import '../../domain/usecase/edit_profile.dart';
import '../../domain/usecase/forget_pass.dart';
import '../../domain/usecase/get_user_types.dart';
import '../../domain/usecase/login_usecase.dart';
import '../../domain/usecase/logout_usecase.dart';
import '../../domain/usecase/regins_usecase.dart';
import '../../domain/usecase/register_usecase.dart';
import '../../domain/usecase/resend_reset_code.dart';
import '../../domain/usecase/reset_pass_usecase.dart';
import '../../domain/usecase/verify_register.dart';
import '../datasource/auth_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final AuthLocalDataSource local;
  final FirebaseMessaging firebaseMessaging;
  AuthRepositoryImpl({
    required this.remote,
    required this.local,
    required this.firebaseMessaging,
  });
  @override
  Future<Either<Failure, CitiesResponse>> getCities() async {
    try {
      final data = await remote.getCities();
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, RegiensResponse>> getRegins(
      {required ReginsParams params}) async {
    try {
      final data = await remote.getRegins(params: params);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, UserTypesResponse>> getUseType(
      {required GetUserTypeParams params}) async {
    try {
      final data = await remote.getUserType(params: params);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, RegisterResponse>> register(
      {required RegisterParams params}) async {
    try {
      final res = await remote.register(params: params);

      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, VerifyRegisterResponse>> verifyRegister(
      {required VerifyRegisterParams params}) async {
    try {
      final data = await remote.verifyRegister(params: params);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, LoginResponse>> login(
      {required LoginParams params}) async {
    try {
      final token = await getToken();
      params.deviceToken = token;
      final user = await remote.login(params: params);

      await local.cacheUserAccessToken(token: user.data.token.toString());

      await local.cacheUserLoginInfo(params: params);
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, ForgetPassResponse>> forgetPass(
      {required ForgetPassParams params}) async {
    try {
      final res = await remote.forgetPass(params: params);
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, CheckCodeForgetPassResponse>> checkCode(
      {required CheckCodeParams params}) async {
    try {
      final res = await remote.checkCode(params: params);
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, SensVerificationCodeRegisterResponse>>
      resendverificationRegisterCode(
          {required ResendverificationRegisterCodeParams params}) async {
    try {
      final res = await remote.resendResetCode(params: params);
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, ResetPassResponse>> resetPass(
      {required ResetPassParams params}) async {
    try {
      final res = await remote.resetCode(params: params);
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteAccount(
      {required DeleteAccountParams params}) async {
    try {
      final token = local.getCacheUserAccessToken();
      await remote.deleteAccount(token: token, params: params);

      await local.clearData();
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, LogoutResponse>> logout(
      {required LogoutParams params}) async {
    try {
      final token = local.getCacheUserAccessToken();

      final res = await remote.logout(logoutParams: params, token: token);

      await local.clearData();
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, GetProfileResponse>> getProfile(
      {required NoParams noParams}) async {
    try {
      final token = local.getCacheUserAccessToken();
      final response =
          await remote.getProfile(noParams: noParams, token: token);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  Future<String> getToken() async {
    try {
      return (await firebaseMessaging.getToken()) ?? "no_token";
    } catch (e) {
      log('getToken firebaseMessaging ERROR: ${e.toString()}');
      await Future.delayed(const Duration(seconds: 1));
      try {
        return (await firebaseMessaging.getToken()) ?? "no_token";
      } catch (e) {
        return "";
      }
    }
  }

  @override
  Future<Either<Failure, User>> autoLogin() async {
    try {
      // get old token
      final loginInfo = await local.getCacheUserLoginInfo();
      final token = await getToken();
      loginInfo.deviceToken = token;
      final userData = await remote.login(params: loginInfo);
      await local.cacheUserData(user: userData.data);
      await local.cacheUserAccessToken(token: userData.data.token);
      return Right(userData.data);
    } on ServerException catch (e) {
      log(e.toString());
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure(message: ""));
    } catch (e) {
      log(e.toString());
      return Left(AuthFailure(message: ""));
    }
  }

  @override
  Future<Either<Failure, GetProfileResponse>> editProfile(
      {required EditProfileParams editProfileParams}) async {
    try {
      final token = local.getCacheUserAccessToken();
      final response = await remote.editProfile(
          editProfileParams: editProfileParams, token: token);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, RealStateTypesResponse>> getRealStates() async {
    try {
      final response = await remote.getRealStates();
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, ChangePhoneResponse>> changePhone(
      {required ChangePhoneParams params}) async {
    try {
      final token = local.getCacheUserAccessToken();
      final response = await remote.changePhone(params: params, token: token);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, VerifyChangePhoneResponse>> verifyChangePhone(
      {required VerifyChangePhoneParams params}) async {
    try {
      final token = local.getCacheUserAccessToken();
      final response =
          await remote.verifyChangePhone(params: params, token: token);
      final loginInfo = await local.getCacheUserLoginInfo();
      loginInfo.deviceToken = await firebaseMessaging.getToken();
      loginInfo.phone = params.phone;
      final user = await remote.login(params: loginInfo);
      await local.cacheUserAccessToken(token: user.data.token);
      await local.cacheUserLoginInfo(params: loginInfo);
      response.user = user.data;
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
