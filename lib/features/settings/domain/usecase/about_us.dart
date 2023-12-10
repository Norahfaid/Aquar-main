import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../models/about_us.dart';
import '../repo/settings_repo.dart';

class AboutUsUsecase extends UseCase<AboutUsResponse, NoParams> {
  final SettingsRepository repository;
  AboutUsUsecase({required this.repository});
  @override
  Future<Either<Failure, AboutUsResponse>> call(NoParams params) async {
    return await repository.aboutUs(params: params);
  }
}
