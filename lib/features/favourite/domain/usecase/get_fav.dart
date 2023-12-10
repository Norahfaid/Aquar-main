import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../models/get_favourities.dart';
import '../repo/fav_repo.dart';

class GetFavouritiesUsecase
    extends UseCase<GetFavouritiesResponse, GetFavParams> {
  final FavRepository repository;
  GetFavouritiesUsecase({required this.repository});
  @override
  Future<Either<Failure, GetFavouritiesResponse>> call(
      GetFavParams params) async {
    return await repository.getFavourities(params: params);
  }
}

class GetFavParams {}
