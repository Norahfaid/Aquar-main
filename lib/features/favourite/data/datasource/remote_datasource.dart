import '../../../../core/error/exceptions.dart';
import '../../../../core/util/api_basehelper.dart';
import '../../domain/models/get_favourities.dart';
import '../../domain/models/toggle_fav.dart';
import '../../domain/usecase/get_fav.dart';
import '../../domain/usecase/toggle_fav.dart';

const String getFavApi = '/favorite';
const String toggleFavApi = '/toggleFavored/';

abstract class GetFavRemoteDatasource {
  Future<GetFavouritiesResponse> getFav(
      {required GetFavParams params, required String token});
  Future<ToggleFavouritiesResponse> toggleFav(
      {required ToggleFavParams params, required String token});
}

class GetFavRemoteDatasourceImpl extends GetFavRemoteDatasource {
  final ApiBaseHelper helper;
  GetFavRemoteDatasourceImpl({required this.helper});

  @override
  Future<GetFavouritiesResponse> getFav(
      {required GetFavParams params, required String token}) async {
    try {
      final response = await helper.get(url: getFavApi, token: token);
      if (response['success'] == true) {
        final getFav = GetFavouritiesResponse.fromJson(response);
        return getFav;
      } else {
        throw ServerException(message: response);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<ToggleFavouritiesResponse> toggleFav(
      {required ToggleFavParams params, required String token}) async {
    try {
      final response = await helper.post(
          url: toggleFavApi + params.id.toString(), body: {}, token: token);

      final toggleFav = ToggleFavouritiesResponse.fromJson(response);
      return toggleFav;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}
