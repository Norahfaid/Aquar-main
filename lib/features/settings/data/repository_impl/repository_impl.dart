import 'dart:developer';

import 'package:aquar/features/settings/domain/models/about_us.dart';
import 'package:aquar/features/settings/domain/models/social_links.dart';
import 'package:aquar/features/settings/domain/models/terms_annonce.dart';
import 'package:aquar/features/settings/domain/usecase/send_image.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/local/auth_local_datasource.dart';
import '../../../../core/usecases/usecases.dart';
import '../../domain/models/terms.dart';
import '../../domain/repo/settings_repo.dart';
import '../datasource/remote_datasource.dart';

class SettingsRepositoryImp extends SettingsRepository {
  final AuthLocalDataSource authLocal;
  final SettingsRemoteDatasource remote;
  SettingsRepositoryImp({required this.authLocal, required this.remote});

  @override
  Future<Either<Failure, TermsResponse>> terms(
      {required NoParams params}) async {
    try {
      final termsMessage = await remote.terms(params: params);
      return Right(termsMessage);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, TermsResponse>> privacyPolicy(
      {required NoParams params}) async {
    try {
      final termsMessage = await remote.privacyPolicy(params: params);
      return Right(termsMessage);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, AboutUsResponse>> aboutUs(
      {required NoParams params}) async {
    try {
      final termsMessage = await remote.aboutUs(params: params);
      return Right(termsMessage);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, TermsAnnonceResponse>> termsAnnonce(
      {required NoParams params}) async {
    try {
      final termsMessage = await remote.termsAnnonce(params: params);
      return Right(termsMessage);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, SocialLinksResponse>> socialLinks() async {
    try {
      final socialLinks = await remote.socialLinks();
      return Right(socialLinks);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> sendMessage(
      {required SendMessageParams params}) async {
    try {
      await remote.sendMessage(params: params);
      return const Right(unit);
    } on ServerException catch (e) {
      log(e.toString());
      return Left(ServerFailure(message: e.message));
    }
  }
}
