import 'package:aquar/features/settings/domain/usecase/send_image.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../models/about_us.dart';
import '../models/social_links.dart';
import '../models/terms.dart';
import '../models/terms_annonce.dart';

abstract class SettingsRepository {
  Future<Either<Failure, TermsResponse>> terms({required NoParams params});
  Future<Either<Failure, TermsResponse>> privacyPolicy(
      {required NoParams params});
  Future<Either<Failure, SocialLinksResponse>> socialLinks();
  Future<Either<Failure, AboutUsResponse>> aboutUs({required NoParams params});
  Future<Either<Failure, TermsAnnonceResponse>> termsAnnonce(
      {required NoParams params});

  Future<Either<Failure, Unit>> sendMessage(
      {required SendMessageParams params});
}
