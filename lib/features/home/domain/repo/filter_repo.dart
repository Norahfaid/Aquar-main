import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../models/add_annoncement_response.dart';
import '../models/aquar_details.dart';
import '../models/delete_adv.dart';
import '../models/filter.dart';
import '../models/network_types.dart';
import '../models/notifications.dart';
import '../models/update_ad_response.dart';
import '../models/user_ads_counts.dart';
import '../usecase/add_annonce.dart';
import '../usecase/aquar_details.dart';
import '../usecase/delete_adv.dart';
import '../usecase/delete_image.dart';
import '../usecase/filter_usecase.dart';
import '../usecase/network_types.dart';
import '../usecase/update_ad.dart';

abstract class FilterRepository {
  Future<Either<Failure, FilterResponse>> getFilter(
      {required FilterParams params});
  Future<Either<Failure, FilterResponse>> getMineAdsFilter(
      {required FilterParams params});
  Future<Either<Failure, NotificationsResponse>> getNotifications();
  Future<Either<Failure, NetWorkTypesResponse>> getNetWorkTypes(
      {required NetWorkTypesParams params});
  Future<Either<Failure, AddAnnoncementResponse>> addAnnoncement(
      {required AddAnnoncementParams params});

  Future<Either<Failure, UpdateAnnoncementResponse>> updateAnnoncement(
      {required UpdateAnnouncementParams params});
  Future<Either<Failure, DeleteAdvResponse>> deleteAdv(
      {required DeleteAdvParams params});
  Future<Either<Failure, Unit>> deleteImage(
      {required DeleteImageParams params});
  Future<Either<Failure, AquarDetailsResponse>> aquarDetails(
      {required AquarDetailsParams params});
  Future<Either<Failure, UserAdsCountsResponse>> getUserAdsCounts();
}
