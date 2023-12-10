// import 'package:dartz/dartz.dart';
//
// import '../../../../../core/usecases/usecases.dart';
// import '../../../../core/error/failures.dart';
// import '../models/network_types.dart';
// import '../repo/filter_repo.dart';
//
// class UpdatePhoneUseCase extends UseCase<UpdatePhoneResponse, UpdatePhoneParams> {
//   final FilterRepository repository;
//   UpdatePhoneUseCase({required this.repository});
//   @override
//   Future<Either<Failure, UpdatePhoneResponse>> call(UpdatePhoneParams params) async {
//     return await repository.updatePhone(params: params);
//   }
// }
// class UpdatePhoneParams{
//   String ?id;
//
//   UpdatePhoneParams({this.id});
//
// }