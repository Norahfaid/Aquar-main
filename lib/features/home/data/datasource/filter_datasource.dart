import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/util/api_basehelper.dart';
import '../../domain/models/add_annoncement_response.dart';
import '../../domain/models/aquar_details.dart';
import '../../domain/models/delete_adv.dart';
import '../../domain/models/filter.dart';
import '../../domain/models/network_types.dart';
import '../../domain/models/notifications.dart';
import '../../domain/models/update_ad_response.dart';
import '../../domain/models/user_ads_counts.dart';
import '../../domain/usecase/add_annonce.dart';
import '../../domain/usecase/aquar_details.dart';
import '../../domain/usecase/delete_adv.dart';
import '../../domain/usecase/delete_image.dart';
import '../../domain/usecase/filter_usecase.dart';
import '../../domain/usecase/network_types.dart';
import '../../domain/usecase/update_ad.dart';

const String getFilterApi = '/advertisements/filter';
const String addAnnoncementApi = '/advertisements';
const String getNetworkApi = '/network-types';
const String getNotificationsApi = '/notifications';
const String deleteAdvApi = '/advertisements/';
const String getUserAdsCountsApi = '/statistics/data';
const String updateAdApi = '/advertisements/';
const String deleteImageApi = '/uploader/media/';
const String aquarDetailsApi = '/advertisements/';

abstract class FilterRemoteDatasource {
  Future<FilterResponse> getFilter(
      {required FilterParams params, required String? token});

  Future<FilterResponse> getMineFilter(
      {required FilterParams params, required String token});
  Future<NotificationsResponse> getNotifications({required String token});
  Future<UserAdsCountsResponse> getUserAdsCounts({required String token});
  Future<NetWorkTypesResponse> getNetWorkTypes(
      {required NetWorkTypesParams params, required String token});
  Future<AddAnnoncementResponse> addAnnoncement(
      {required AddAnnoncementParams params, required String token});
  Future<UpdateAnnoncementResponse> updateAnnoncement(
      {required UpdateAnnouncementParams params, required String token});

  Future<DeleteAdvResponse> deleteAdv({
    required DeleteAdvParams params,
    required String token,
  });
  Future<void> deleteImage({
    required DeleteImageParams params,
    required String token,
  });
  Future<AquarDetailsResponse> aquarDetails(
      {required AquarDetailsParams params, required String? token});
}

class FilterRemoteDatasourceImpl extends FilterRemoteDatasource {
  final ApiBaseHelper helper;
  FilterRemoteDatasourceImpl({required this.helper});

  @override
  Future<FilterResponse> getFilter(
      {required FilterParams params, required String? token}) async {
    try {
      final response = await helper.get(
          url: params.isNearst == true
              ? "/advertisements/nearest/${params.latLang}${params.toQParams()}"
              : "$getFilterApi${params.toQParams()}",
          token: token);
      if (response['success'] == true) {
        final getFilter = FilterResponse.fromJson(response);
        return getFilter;
      } else {
        throw ServerException(message: response["message"]);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<FilterResponse> getMineFilter(
      {required FilterParams params, required String token}) async {
    try {
      final response = await helper.get(
          url: "$getFilterApi${params.toQParams()}", token: token);
      if (response['success'] == true) {
        final getFilter = FilterResponse.fromJson(response);
        return getFilter;
      } else {
        throw ServerException(message: response["message"]);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<AddAnnoncementResponse> addAnnoncement(
      {required AddAnnoncementParams params, required String token}) async {
    try {
      final map = {
        'building_type_id': params.buildingTypeId,
        // 'network_type_id': params.networkTypeId,
        /// todo write right key for network list
        "network_types[]": params.networkTypes,
        'desc': params.descrption,
        'phone': params.phone,
        'advertiser_phone': params.phone,
        'min_price': params.minPrice,
        'max_price': params.maxPrice,
        'min_distance': params.minDistance,
        'max_distance': params.maxDistance,
        'apartments_count': params.appartCount,
        "bedrooms_count": params.bedRoomsCount,
        // "all_rooms": params.allRooms,
        'bathrooms_count': params.bathRoomsCount,
        'additional_rooms_count': params.additionalRoomsCount,
        'shops_count': params.shopsCount,
        'age': params.age,
        'interface': params.interface,
        'purpose': params.purpose,
        'address': params.address,
        'lat': params.lat,
        'long': params.long,
        'video_link': params.videoLink,
        'driver_room': params.driverRoom,
        'maid_room': params.maidRoom,
        'pool': params.pool,
        'car_entrance': params.carInterface,
        'external_staircase': params.externalStaircase,
        'supplement': params.supplement,
        'elevator': params.elevator,
        'kitchen': params.kitchen,
        'roof': params.roof,
        'courtyard': params.monsters,
        'duplex': params.duplex,
        'separated': params.separated,
        'basement': params.basement,
        'license_number': '1200017549',
        'air_conditioner': params.airConditioner,
        'from_dashboard': params.fromDashboard,
      };

      if (params.advLicenseNumber != '') {
        map.addAll({
          'adv_license_number': params.advLicenseNumber,
        });
      }
      if (params.icon != null) {
        final bytes = File(params.icon!.path).readAsBytesSync();
        String icon = base64Encode(bytes);
        map.addAll({
          'icon': icon,
        });
      }
      List<String> iamges = [];
      for (var image in params.images!) {
        final imageBytes = File(image.path).readAsBytesSync();
        String base64Image = base64Encode(imageBytes);
        iamges.add(base64Image);
      }
      if (iamges.isNotEmpty) {
        map.addAll({'images[]': iamges});
      }

      // List<File> files = [];
      // List<String> iamges = [];
      // for (var element in iamges) {
      //   final imagesBytes = File(params.images![element].path).readAsBytesSync();
      //   String imagesList = base64Encode(imagesBytes);
      //   // iamges.add(Base64Codec(element.path));
      // }

      // if (iamges.isNotEmpty) {
      //   map.addAll({'images[]': iamges});
      // }
      // if (params.image2 != null && params.image3 != null) {
      //   final bytes2 = File(params.image2!.path).readAsBytesSync();
      //   final image2 = base64Encode(bytes2);
      //   final bytes3 = File(params.image3!.path).readAsBytesSync();
      //   final image3 = base64Encode(bytes3);
      //   map.addAll({
      //     'images[]': [image2, image3]
      //   });
      // } else if (params.image2 != null) {
      //   final bytes2 = File(params.image2!.path).readAsBytesSync();
      //   final image2 = base64Encode(bytes2);
      //   map.addAll({
      //     'images[]': [image2]
      //   });
      // } else if (params.image3 != null) {
      //   final bytes3 = File(params.image3!.path).readAsBytesSync();
      //   final image3 = base64Encode(bytes3);
      //   map.addAll({
      //     'images[]': [image3]
      //   });
      // }

      MultipartFile? videoUrl;

      if (params.video != null)
      //  &&
      // (params.videoLink == null || params.videoLink!.isEmpty))
      {
        videoUrl = await MultipartFile.fromFile(params.video!.path,
            filename: params.video!.path);

        map.addAll({'video': videoUrl});
      }
      if (params.streetWidth != null && params.streetWidth != '') {
        map.addAll({
          'street_width': params.streetWidth,
        });
      }
      log('${params.icon}111111111 ======================');

      log('${params.video}vvvvvvvvvvvv ======================');
      final response = await helper.postWithImage(
          body: map, url: addAnnoncementApi, token: token);
      if (response['success'] == true) {
        final addAnnoncement = AddAnnoncementResponse.fromJson(response);
        return addAnnoncement;
      } else {
        throw ServerException(message: response["message"]);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<UpdateAnnoncementResponse> updateAnnoncement(
      {required UpdateAnnouncementParams params, required String token}) async {
    try {
//       final map = {
//         'building_type_id': params.buildingTypeId,
//         // 'network_type_id': params.networkTypeId,
//         "network_types[]": params.selectedNetworkIds,
//         'desc': params.descrption,
//         'license_number': '1200017549',
//         'phone': params.phone,
//         'advertiser_phone': params.phone,
//         'min_price': params.minPrice,
//         'max_price': params.maxPrice,
//         'min_distance': params.minDistance,
//         "status": 'pending',
//         'max_distance': params.maxDistance,
//         'apartments_count': params.appartCount,
//         "bedrooms_count": params.bedRoomsCount,
//         'bathrooms_count': params.bathRoomsCount,
//         'additional_rooms_count': params.additionalRoomsCount,
//         'shops_count': params.shopsCount,
//         // 'street_width': params.streetWidth,
//         'age': params.age,
//         'interface': params.interface,
//         'purpose': params.purpose,
//         'address': params.address,
//         'lat': params.lat,
//         'long': params.long,
//         'video_link': params.videoLink,
//         'driver_room': params.driverRoom,
//         'maid_room': params.maidRoom,
//         'pool': params.pool,
//         'car_entrance': params.carInterface,
//         'external_staircase': params.externalStaircase,
//         'supplement': params.supplement,
//         'elevator': params.elevator,
//         'kitchen': params.kitchen,
//         'roof': params.roof,
//         'courtyard': params.monsters,
//         'duplex': params.duplex,
//         'separated': params.separated,
//         'basement': params.basement,
//         'air_conditioner': params.airConditioner,
//       };
//
//       if (params.icon != null && params.icon!.isLeft()) {
//         final bytes =
//             params.icon!.swap().getOrElse(() => File("")).readAsBytesSync();
//         String icon = base64Encode(bytes);
//         map.addAll({
//           'icon': icon,
//         });
//       }
//       List<String> images = [];
//       for (var image in params.images!) {
//         if (image.isLeft()) {
//           final file = image.swap().getOrElse(() => File(""));
//           final imageBytes = file.readAsBytesSync();
//           String base64Image = base64Encode(imageBytes);
//           images.add(base64Image);
//         }
//       }
//       if (images.isNotEmpty) {
//         map.addAll({'images[]': images});
//       }
//
//       MultipartFile? videoUrl;
// // if (params.video != null && params.video!.path.isNotEmpty) {
// //         videoUrl = await MultipartFile.fromFile(params.video!.path,
// //             filename: params.video!.path);
//
// //         map.addAll({'video': videoUrl});
// //       }
//       if (params.video != null && params.video!.isLeft()) {
//         videoUrl = await MultipartFile.fromFile(
//             params.video!.swap().getOrElse(() => File("")).path,
//             filename: params.video!.swap().getOrElse(() => File("")).path);
//
//         map.addAll({'video': videoUrl});
//       }
//
//       log('${params.icon}111111111 ======================');
//
//       log('${params.video}vvvvvvvvvvvv ======================');
//       if (params.advLicenseNumber != null && params.advLicenseNumber != '') {
//         map.addAll({
//           'adv_license_number': "${params.advLicenseNumber}",
//         });
//       }
//       if (params.streetWidth != null && params.streetWidth != '') {
//         map.addAll({
//           'street_width': params.streetWidth,
//         });
//       }
      // log(map.toString());

      Map<String, dynamic> json = params.updateAnnouncementJson;

      ///Add Icon
      json = params.addIconToUpdateAnnouncementJson(json);

      ///Add Images
      json = params.addImagesToUpdateAnnouncementJson(json);

      ///Add Videos
      json = await params.addVideosToUpdateAnnouncementJson(json);

      ///Add AdvLicenseNumber
      json = params.addAdvLicenseNumberToUpdateAnnouncementJson(json);

      ///Add StreetWidth
      json = params.addAdvLicenseNumberToUpdateAnnouncementJson(json);

      final response = await helper.postWithImage(
        body: json,
        url: updateAdApi + params.adId.toString(),
        token: token,
      );
      if (response['success'] == true) {
        final updateAnnoncement = UpdateAnnoncementResponse.fromJson(response);
        return updateAnnoncement;
      } else {
        throw ServerException(message: response["message"]);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<NetWorkTypesResponse> getNetWorkTypes(
      {required NetWorkTypesParams params, required String token}) async {
    try {
      final response = await helper.get(url: getNetworkApi, token: token);
      if (response['success'] == true) {
        final getNetWorkTypes = NetWorkTypesResponse.fromJson(response);
        return getNetWorkTypes;
      } else {
        throw ServerException(message: response["message"]);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<NotificationsResponse> getNotifications(
      {required String token}) async {
    try {
      final response = await helper.get(url: getNotificationsApi, token: token);
      if (response['success'] == true) {
        final getNotifications = NotificationsResponse.fromJson(response);
        return getNotifications;
      } else {
        throw ServerException(message: response["message"]);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<DeleteAdvResponse> deleteAdv({
    required DeleteAdvParams params,
    required String token,
  }) async {
    try {
      final response = await helper.delete(
          url: deleteAdvApi + params.id.toString(), body: {}, token: token);
      if (response['success'] == true) {
        final deleteAdv = DeleteAdvResponse.fromJson(response);
        return deleteAdv;
      } else {
        throw ServerException(message: response["message"]);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<UserAdsCountsResponse> getUserAdsCounts(
      {required String token}) async {
    try {
      final response = await helper.get(url: getUserAdsCountsApi, token: token);
      if (response['success'] == true) {
        final getUserAdsCounts = UserAdsCountsResponse.fromJson(response);
        return getUserAdsCounts;
      } else {
        throw ServerException(message: response["message"]);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<void> deleteImage(
      {required DeleteImageParams params, required String token}) async {
    try {
      await helper.delete(
          url: deleteImageApi + params.imageId.toString(),
          body: {},
          token: token);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<AquarDetailsResponse> aquarDetails(
      {required AquarDetailsParams params, required String? token}) async {
    try {
      int fromDetails = 0;
      if (params.fromDetails) {
        fromDetails = 1;
      }
      final response = await helper.get(
          url: '$aquarDetailsApi${params.id}?fromDetails=$fromDetails',
          token: token);
      if (response['success'] == true) {
        final aquarDetails = AquarDetailsResponse.fromJson(response);
        return aquarDetails;
      } else {
        throw ServerException(message: response["message"]);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}
