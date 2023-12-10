import 'package:dartz/dartz.dart';

import '../../../../../core/usecases/usecases.dart';
import '../../../../core/error/failures.dart';
import '../models/network_types.dart';
import '../repo/filter_repo.dart';

class NetWorkTypesUseCase extends UseCase<NetWorkTypesResponse, NetWorkTypesParams> {
  final FilterRepository repository;
  NetWorkTypesUseCase({required this.repository});
  @override
  Future<Either<Failure, NetWorkTypesResponse>> call(NetWorkTypesParams params) async {
    return await repository.getNetWorkTypes(params: params);
  }
}
class NetWorkTypesParams{
  String ?id;

  NetWorkTypesParams({this.id});

}