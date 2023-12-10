import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../models/terms_annonce.dart';
import '../repo/settings_repo.dart';

class TermsAnnonceUsecase extends UseCase<TermsAnnonceResponse, NoParams> {
  final SettingsRepository repository;
  TermsAnnonceUsecase({required this.repository});
  @override
  Future<Either<Failure, TermsAnnonceResponse>> call(NoParams params) async {
    return await repository.termsAnnonce(params: params);
  }
}
