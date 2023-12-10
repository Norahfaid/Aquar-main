import '../../../../core/error/exceptions.dart';
import '../../../../core/util/api_basehelper.dart';
import '../../domain/entities/register_nafaz_response.dart';
import '../../domain/usecase/nafaz_usecase.dart';

const String registerNafazEndpoint = '/nafaz/register';

abstract class NafazRemoteDatasource {
  Future<RegisterNafazResponse> registerNafaz({required RegisterNafazParams params, required String? token});
}

class NafazRemoteDatasourceImpl extends NafazRemoteDatasource {
  final ApiBaseHelper helper;

  NafazRemoteDatasourceImpl({required this.helper});


  @override
  Future<RegisterNafazResponse> registerNafaz({required RegisterNafazParams params, required String? token}) async{
    try {
      final response = await helper.post(
        url: registerNafazEndpoint,
        body: {
          'national_id': params.nationalId,
        },
        token: token,
      );
      if (response['success'] == true) {
        return RegisterNafazResponse.fromJson(response);
      } else {
        throw ServerException(message: response);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

}
