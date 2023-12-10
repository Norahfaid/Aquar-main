// To parse this JSON data, do
//
//     final addAnnoncementResponse = addAnnoncementResponseFromJson(jsonString);

import 'dart:convert';

import 'package:aquar/features/home/domain/models/filter.dart';

AddAnnoncementResponse addAnnoncementResponseFromJson(String str) =>
    AddAnnoncementResponse.fromJson(json.decode(str));

String addAnnoncementResponseToJson(AddAnnoncementResponse data) =>
    json.encode(data.toJson());

class AddAnnoncementResponse {
  final bool success;
  final AnnonceData data;
  final String message;

  // User? user;
  AddAnnoncementResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  AddAnnoncementResponse copyWith({
    bool? success,
    AnnonceData? data,
    String? message,
  }) =>
      AddAnnoncementResponse(
        success: success ?? this.success,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory AddAnnoncementResponse.fromJson(Map<String, dynamic> json) =>
      AddAnnoncementResponse(
        success: json["success"],
        data: AnnonceData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
      };
}

class AnnonceData {
  final int id;
  final String user;
  final BuildingType buildingType;
  final List<NetWorkTypes> networkType;
  final String desc;
  final String phone;
  final String advertiserPhone;
  final String minPrice;
  final String maxPrice;
  final String minDistance;
  final String maxDistance;
  final String apartmentsCount;
  final String bedroomsCount;
  final String shopsCount;
  final String? streetWidth;
  final String age;
  final String dataInterface;
  final String licenseNumber;
  final String purpose;
  final String address;
  final String lat;
  final String long;
  final String driverRoom;
  final String maidRoom;
  final String pool;
  final String carEntrance;
  final String externalStaircase;
  final String? courtyard;
  final String supplement;
  final String elevator;
  final String kitchen;
  final String roof;
  final String duplex;
  final String separated;
  final String basement;
  final String airConditioner;
  final String? videoLink;
  final String? video;
  final String icon;
  final List<ImageFilter>? images;

  AnnonceData({
    required this.id,
    required this.user,
    required this.buildingType,
    required this.networkType,
    required this.desc,
    required this.phone,
    required this.advertiserPhone,
    required this.minPrice,
    required this.maxPrice,
    required this.minDistance,
    required this.maxDistance,
    required this.apartmentsCount,
    required this.bedroomsCount,
    required this.shopsCount,
    required this.streetWidth,
    required this.age,
    required this.dataInterface,
    required this.licenseNumber,
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
  });

  factory AnnonceData.fromJson(Map<String, dynamic> json) => AnnonceData(
        id: json["id"],
        user: json["user"],
        buildingType: BuildingType.fromJson(json["building_type"]),
        networkType: List<NetWorkTypes>.from(
            json["network_types"].map((x) => NetWorkTypes.fromJson(x))),
        desc: json["desc"],
        phone: json["phone"],
        advertiserPhone: json["advertiser_phone"],
        minPrice: json["min_price"],
        maxPrice: json["max_price"],
        minDistance: json["min_distance"],
        maxDistance: json["max_distance"],
        apartmentsCount: json["apartments_count"],
        bedroomsCount: json["bedrooms_count"],
        shopsCount: json["shops_count"],
        streetWidth: json["street_width"],
        age: json["age"],
        dataInterface: json["interface"],
        licenseNumber: json["license_number"],
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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "building_type": buildingType,
        "network_type": networkType,
        "desc": desc,
        "phone": phone,
        "advertiser_phone": advertiserPhone,
        "min_price": minPrice,
        "max_price": maxPrice,
        "min_distance": minDistance,
        "max_distance": maxDistance,
        "apartments_count": apartmentsCount,
        "bedrooms_count": bedroomsCount,
        "shops_count": shopsCount,
        "street_width": streetWidth,
        "age": age,
        "interface": dataInterface,
        "license_number": licenseNumber,
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
        "images": List<dynamic>.from(images!.map((x) => x)),
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
        name: json["name"]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
