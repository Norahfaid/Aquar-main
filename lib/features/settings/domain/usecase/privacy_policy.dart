import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../models/terms.dart';
import '../repo/settings_repo.dart';

class PrivacyPolicy extends UseCase<TermsResponse, NoParams> {
  final SettingsRepository repository;
  PrivacyPolicy({required this.repository});
  @override
  Future<Either<Failure, TermsResponse>> call(NoParams params) async {
    return await repository.privacyPolicy(params: params);
  }
}
