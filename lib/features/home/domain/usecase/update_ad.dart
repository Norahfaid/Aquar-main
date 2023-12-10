import 'dart:convert';
import 'dart:io';

import 'package:aquar/features/home/domain/models/filter.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../models/update_ad_response.dart';
import '../repo/filter_repo.dart';

class UpdateAnnoncementUsecase extends UseCase<UpdateAnnoncementResponse, UpdateAnnouncementParams> {
  final FilterRepository repository;
  UpdateAnnoncementUsecase({required this.repository});
  @override
  Future<Either<Failure, UpdateAnnoncementResponse>> call(UpdateAnnouncementParams params) async {
    return await repository.updateAnnoncement(params: params);
  }
}

class UpdateAnnouncementParams {
  int? adId;
  // int? networkTypeId;
  int? buildingTypeId;
  String? descrption;
  String? phone;
  String? minPrice;
  String? maxPrice;
  String? minDistance;
  String? maxDistance;
  String? appartCount;
  String? bedRoomsCount;
  String? bathRoomsCount;
  String? additionalRoomsCount;
  String? shopsCount;
  String? streetWidth;
  String? age;
  String? interface;
  String? advLicenseNumber;
  String? purpose;
  String? address;
  // String cordinates;
  final String? lat;
  final String? long;
  String? videoLink;
  String? driverRoom;
  String? maidRoom;
  String? pool;
  String? carInterface;
  String? externalStaircase;
  String? supplement;
  String? elevator;
  String? kitchen;
  String? roof;
  String? duplex;
  String? separated;
  List<Either<File, ImageFilter>>? images;
  String? basement;
  String? monsters;
  String? airConditioner;
  List<int>? selectedNetworkIds;
  int? fromDashboard;

  ///image1 is the icon
  Either<File, String>? icon;
  // File? image2;
  Either<File, String>? video;
  // File? image3;
  UpdateAnnouncementParams({
    // this.networkTypeId,
    this.icon,
    this.selectedNetworkIds,
    this.images,
    this.buildingTypeId,
    this.monsters,
    this.descrption,
    // this.cordinates,
    this.phone,
    this.video,
    this.minPrice,
    this.maxPrice,
    this.minDistance,
    this.maxDistance,
    this.appartCount,
    this.adId,
    this.bedRoomsCount,
    this.bathRoomsCount,
    this.additionalRoomsCount,
    this.shopsCount,
    this.streetWidth,
    this.age,
    this.interface,
    this.advLicenseNumber,
    this.purpose,
    this.address,
    this.lat,
    this.long,
    this.videoLink,
    this.driverRoom,
    this.maidRoom,
    this.pool,
    this.carInterface,
    this.externalStaircase,
    this.supplement,
    this.elevator,
    this.kitchen,
    this.roof,
    this.duplex,
    this.separated,
    this.basement,
    this.airConditioner,
    this.fromDashboard,
  });


  Map<String, dynamic> get updateAnnouncementJson{
    Map<String, dynamic> map = {
      'building_type_id': buildingTypeId,
      // 'network_type_id': networkTypeId,
      "network_types[]": selectedNetworkIds,
      'desc': descrption,
      'license_number': '1200017549',
      'phone': phone,
      'advertiser_phone': phone,
      'min_price': minPrice,
      'max_price': maxPrice,
      'min_distance': minDistance,
      "status": 'pending',
      'max_distance': maxDistance,
      'apartments_count': appartCount,
      "bedrooms_count": bedRoomsCount,
      'bathrooms_count': bathRoomsCount,
      'additional_rooms_count': additionalRoomsCount,
      'shops_count': shopsCount,
      'street_width': streetWidth,
      'age': age,
      'interface': interface,
      'purpose': purpose,
      'address': address,
      'lat': lat,
      'long': long,
      'video_link': videoLink,
      'driver_room': driverRoom,
      'maid_room': maidRoom,
      'pool': pool,
      'car_entrance': carInterface,
      'external_staircase': externalStaircase,
      'supplement': supplement,
      'elevator': elevator,
      'kitchen': kitchen,
      'roof': roof,
      'courtyard': monsters,
      'duplex': duplex,
      'separated': separated,
      'basement': basement,
      'air_conditioner': airConditioner,
      'from_dashboard': fromDashboard,
    };
    return map;
  }

  Map<String, dynamic> addIconToUpdateAnnouncementJson(Map<String, dynamic> map){
    if(icon != null && icon!.isLeft()){
      final bytes = icon!.swap().getOrElse(() => File("")).readAsBytesSync();
      String iconStr = base64Encode(bytes);
      map.putIfAbsent('icon', () => iconStr);
    }
    return map;
  }

  Map<String, dynamic> addImagesToUpdateAnnouncementJson(Map<String, dynamic> map){
    final List<String> imagesStr = [];
    for (var image in images!) {
      if (image.isLeft()) {
        final file = image.swap().getOrElse(() => File(""));
        final imageBytes = file.readAsBytesSync();
        String base64Image = base64Encode(imageBytes);
        imagesStr.add(base64Image);
      }
    }
    if (imagesStr.isNotEmpty) {
      map.addAll({'images[]': imagesStr});
    }
    return map;
  }

  Future<Map<String, dynamic>> addVideosToUpdateAnnouncementJson(Map<String, dynamic> map) async{
    MultipartFile? videoUrl;
    if (video != null && video!.isLeft()) {
      videoUrl = await MultipartFile.fromFile(
          video!.swap().getOrElse(() => File("")).path,
          filename: video!.swap().getOrElse(() => File("")).path);

      map.addAll({'video': videoUrl});
    }
    return map;
  }

  Map<String, dynamic> addAdvLicenseNumberToUpdateAnnouncementJson(Map<String, dynamic> map){
    if (advLicenseNumber != null && advLicenseNumber!.isNotEmpty) {
      map.addAll({
        'adv_license_number': advLicenseNumber,
      });
    }
    return map;
  }

  Map<String, dynamic> addStreetWidthToUpdateAnnouncementJson(Map<String, dynamic> map){
    if (streetWidth != null && streetWidth!.isNotEmpty) {
      map.addAll({
        'street_width': streetWidth,
      });
    }
    return map;
  }

}
