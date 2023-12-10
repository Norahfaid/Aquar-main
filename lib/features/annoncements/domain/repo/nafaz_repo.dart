import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/register_nafaz_response.dart';
import '../usecase/nafaz_usecase.dart';

abstract class NafazRepository {
  Future<Either<Failure, RegisterNafazResponse>> registerNafaz({required RegisterNafazParams params});
}
