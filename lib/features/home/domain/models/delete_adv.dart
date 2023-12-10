// To parse this JSON data, do
//
//     final deleteAdvResponse = deleteAdvResponseFromJson(jsonString);

import 'dart:convert';

import 'package:aquar/features/auth/domain/models/login.dart';
import 'package:aquar/features/home/domain/models/filter.dart';

DeleteAdvResponse deleteAdvResponseFromJson(String str) =>
    DeleteAdvResponse.fromJson(json.decode(str));

String deleteAdvResponseToJson(DeleteAdvResponse data) =>
    json.encode(data.toJson());

class DeleteAdvResponse {
  bool success;
  String message;
  User? user;
  DeleteAdvResponse({
    required this.success,
    required this.message,
  });

  factory DeleteAdvResponse.fromJson(Map<String, dynamic> json) =>
      DeleteAdvResponse(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}

class Data {
  int id;
  int userId;
  String user;
  String userAvatar;
  String phone;
  String userType;
  BuildingType buildingType;
  List<NetWorkTypes> networkType;
  String desc;
  String advertiserPhone;
  int minPrice;
  int maxPrice;
  int minDistance;
  int maxDistance;
  int apartmentsCount;
  int bedroomsCount;
  int bathroomsCount;
  int additionalRoomsCount;
  int shopsCount;
  int streetWidth;
  dynamic age;
  dynamic dataInterface;
  String licenseNumber;
  String advLicenseNumber;
  String purpose;
  String address;
  String lat;
  String long;
  int driverRoom;
  int maidRoom;
  int pool;
  int carEntrance;
  int externalStaircase;
  int courtyard;
  int supplement;
  int elevator;
  int kitchen;
  int roof;
  int duplex;
  int separated;
  int basement;
  int airConditioner;
  String? videoLink;
  String? video;
  String icon;
  List<ImageFilter> images;
  String status;
  bool isFavored;
  String creationTime;
  String lastUpdate;

  Data({
    required this.id,
    required this.userId,
    required this.user,
    required this.userAvatar,
    required this.phone,
    required this.userType,
    required this.buildingType,
    required this.networkType,
    required this.desc,
    required this.advertiserPhone,
    required this.minPrice,
    required this.maxPrice,
    required this.minDistance,
    required this.maxDistance,
    required this.apartmentsCount,
    required this.bedroomsCount,
    required this.bathroomsCount,
    required this.additionalRoomsCount,
    required this.shopsCount,
    required this.streetWidth,
    required this.age,
    required this.dataInterface,
    required this.licenseNumber,
    required this.advLicenseNumber,
    required this.purpose,
    required this.address,
    required this.lat,
    required this.long,
    required this.driverRoom,
    required this.maidRoom,
    required this.pool,
    required this.carEntrance,
    required this.externalStaircase,
    required this.courtyard,
    required this.supplement,
    required this.elevator,
    required this.kitchen,
    required this.roof,
    required this.duplex,
    required this.separated,
    required this.basement,
    required this.airConditioner,
    required this.videoLink,
    required this.video,
    required this.icon,
    required this.images,
    required this.status,
    required this.isFavored,
    required this.creationTime,
    required this.lastUpdate,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        user: json["user"],
        userAvatar: json["user_avatar"],
        phone: json["phone"],
        userType: json["user_type"],
        buildingType: BuildingType.fromJson(json["building_type"]),
        networkType: List<NetWorkTypes>.from(
            json["network_types"].map((x) => NetWorkTypes.fromJson(x))),
        desc: json["desc"],
        advertiserPhone: json["advertiser_phone"],
        minPrice: json["min_price"],
        maxPrice: json["max_price"],
        minDistance: json["min_distance"],
        maxDistance: json["max_distance"],
        apartmentsCount: json["apartments_count"],
        bedroomsCount: json["bedrooms_count"],
        bathroomsCount: json["bathrooms_count"],
        additionalRoomsCount: json["additional_rooms_count"],
        shopsCount: json["shops_count"],
        streetWidth: json["street_width"],
        age: json["age"],
        dataInterface: json["interface"],
        licenseNumber: json["license_number"].toString(),
        advLicenseNumber: json["adv_license_number"].toString(),
        purpose: json["purpose"],
        address: json["address"],
        lat: json["lat"],
        long: json["long"],
        driverRoom: json["driver_room"],
        maidRoom: json["maid_room"],
        pool: json["pool"],
        carEntrance: json["car_entrance"],
        externalStaircase: json["external_staircase"],
        courtyard: json["courtyard"],
        supplement: json["supplement"],
        elevator: json["elevator"],
        kitchen: json["kitchen"],
        roof: json["roof"],
        duplex: json["duplex"],
        separated: json["separated"],
        basement: json["basement"],
        airConditioner: json["air_conditioner"],
        videoLink: json["video_link"],
        video: json["video"],
        icon: json["icon"],
        images: List<ImageFilter>.from(
            json["images"].map((x) => ImageFilter.fromJson(x))),
        status: json["status"],
        isFavored: json["is_favored"],
        creationTime: json["creation_time"],
        lastUpdate: json["last_update"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user": user,
        "user_avatar": userAvatar,
        "phone": phone,
        "user_type": userType,
        "building_type": buildingType.toJson(),
        "network_type": networkType,
        "desc": desc,
        "advertiser_phone": advertiserPhone,
        "min_price": minPrice,
        "max_price": maxPrice,
        "min_distance": minDistance,
        "max_distance": maxDistance,
        "apartments_count": apartmentsCount,
        "bedrooms_count": bedroomsCount,
        "bathrooms_count": bathroomsCount,
        "additional_rooms_count": additionalRoomsCount,
        "shops_count": shopsCount,
        "street_width": streetWidth,
        "age": age,
        "interface": dataInterface,
        "license_number": licenseNumber,
        "adv_license_number": advLicenseNumber,
        "purpose": purpose,
        "address": address,
        "lat": lat,
        "long": long,
        "driver_room": driverRoom,
        "maid_room": maidRoom,
        "pool": pool,
        "car_entrance": carEntrance,
        "external_staircase": externalStaircase,
        "courtyard": courtyard,
        "supplement": supplement,
        "elevator": elevator,
        "kitchen": kitchen,
        "roof": roof,
        "duplex": duplex,
        "separated": separated,
        "basement": basement,
        "air_conditioner": airConditioner,
        "video_link": videoLink,
        "video": video,
        "icon": icon,
        "images": List<dynamic>.from(images.map((x) => x)),
        "status": status,
        "is_favored": isFavored,
        "creation_time": creationTime,
        "last_update": lastUpdate,
      };
}

class BuildingType {
  int id;
  String name;

  BuildingType({
    required this.id,
    required this.name,
  });

  factory BuildingType.fromJson(Map<String, dynamic> json) => BuildingType(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
