// To parse this JSON data, do
//
//     final updateAnnoncementResponse = updateAnnoncementResponseFromJson(jsonString);

import 'dart:convert';

import 'package:aquar/features/home/domain/models/filter.dart';

UpdateAnnoncementResponse updateAnnoncementResponseFromJson(String str) =>
    UpdateAnnoncementResponse.fromJson(json.decode(str));

String updateAnnoncementResponseToJson(UpdateAnnoncementResponse data) =>
    json.encode(data.toJson());

class UpdateAnnoncementResponse {
  bool success;
  UpdateAdData data;
  String message;

  UpdateAnnoncementResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory UpdateAnnoncementResponse.fromJson(Map<String, dynamic> json) =>
      UpdateAnnoncementResponse(
        success: json["success"],
        data: UpdateAdData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
      };
}

class UpdateAdData {
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
  String minPrice;
  String maxPrice;
  String minDistance;
  String maxDistance;
  String apartmentsCount;
  String bedroomsCount;
  String bathroomsCount;
  String additionalRoomsCount;
  String shopsCount;
  String streetWidth;
  String age;
  String dataInterface;
  String? licenseNumber;
  dynamic advLicenseNumber;
  String purpose;
  String address;
  String lat;
  String long;
  String driverRoom;
  String maidRoom;
  String pool;
  String carEntrance;
  String externalStaircase;
  dynamic courtyard;
  String supplement;
  String elevator;
  String kitchen;
  String roof;
  String duplex;
  String separated;
  String basement;
  String airConditioner;
  String? videoLink;
  String icon;
  List<ImageFilter>? images;
  String status;
  bool isFavored;
  String creationTime;
  String lastUpdate;
  int isFromDashboard;

  UpdateAdData({
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
    required this.icon,
    required this.images,
    required this.status,
    required this.isFavored,
    required this.creationTime,
    required this.lastUpdate,
    required this.isFromDashboard,
  });

  factory UpdateAdData.fromJson(Map<String, dynamic> json) => UpdateAdData(
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
        licenseNumber: json["license_number"],
        advLicenseNumber: json["adv_license_number"],
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
        icon: json["icon"],
        images: List<ImageFilter>.from(
            json["images"].map((x) => ImageFilter.fromJson(x))),
        status: json["status"],
        isFavored: json["is_favored"],
        creationTime: json["creation_time"],
        lastUpdate: json["last_update"],
        isFromDashboard: json["from_dashboard"]!=null? int.tryParse(json["from_dashboard"].toString())??0 : 0,
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
        "icon": icon,
        "images": List<dynamic>.from(images!.map((x) => x)),
        "status": status,
        "is_favored": isFavored,
        "creation_time": creationTime,
        "last_update": lastUpdate,
        "from_dashboard": isFromDashboard,
      };
}

// class BuildingType {
//   int id;
//   String name;

//   BuildingType({
//     required this.id,
//     required this.name,
//   });

//   factory BuildingType.fromJson(Map<String, dynamic> json) => BuildingType(
//         id: json["id"],
//         name: json["name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//       };
// }
