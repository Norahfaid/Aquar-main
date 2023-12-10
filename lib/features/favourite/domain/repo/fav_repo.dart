import 'package:aquar/features/favourite/domain/models/get_favourities.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../models/toggle_fav.dart';
import '../usecase/get_fav.dart';
import '../usecase/toggle_fav.dart';

abstract class FavRepository {
  Future<Either<Failure, GetFavouritiesResponse>> getFavourities(
      {required GetFavParams params});
  Future<Either<Failure, ToggleFavouritiesResponse>> toggleFavourities(
      {required ToggleFavParams params});
}
