import 'package:dartz/dartz.dart';

import '../../../../../core/usecases/usecases.dart';
import '../../../../core/error/failures.dart';
import '../models/user_ads_counts.dart';
import '../repo/filter_repo.dart';

class UserAdsCountsUseCase extends UseCase<UserAdsCountsResponse, NoParams> {
  final FilterRepository repository;
  UserAdsCountsUseCase({required this.repository});
  @override
  Future<Either<Failure, UserAdsCountsResponse>> call(NoParams params) async {
    return await repository.getUserAdsCounts();
  }
}
