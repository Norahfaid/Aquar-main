import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../models/toggle_fav.dart';
import '../repo/fav_repo.dart';

class ToggleFavouritiesUsecase
    extends UseCase<ToggleFavouritiesResponse, ToggleFavParams> {
  final FavRepository repository;
  ToggleFavouritiesUsecase({required this.repository});
  @override
  Future<Either<Failure, ToggleFavouritiesResponse>> call(
      ToggleFavParams params) async {
    return await repository.toggleFavourities(params: params);
  }
}

class ToggleFavParams {
  final int id;

  ToggleFavParams({required this.id});
}
