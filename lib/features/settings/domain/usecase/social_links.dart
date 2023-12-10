import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../models/social_links.dart';
import '../repo/settings_repo.dart';

class SocialLinksUsecase extends UseCase<SocialLinksResponse, NoParams> {
  final SettingsRepository repository;
  SocialLinksUsecase({required this.repository});
  @override
  Future<Either<Failure, SocialLinksResponse>> call(NoParams params) async {
    return await repository.socialLinks();
  }
}
