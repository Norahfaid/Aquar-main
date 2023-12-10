// To parse this JSON data, do
//
//     final aquarDetailsResponse = aquarDetailsResponseFromJson(jsonString);

import 'dart:convert';

import 'filter.dart';

AquarDetailsResponse aquarDetailsResponseFromJson(String str) =>
    AquarDetailsResponse.fromJson(json.decode(str));

class AquarDetailsResponse {
  bool success;
  AnnounceData data;
  String message;

  AquarDetailsResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory AquarDetailsResponse.fromJson(Map<String, dynamic> json) =>
      AquarDetailsResponse(
        success: json["success"],
        data: AnnounceData.fromJson(json["data"]),
        message: json["message"],
      );
}

// class Data {
//   int id;
//   int userId;
//   String user;
//   String userAvatar;
//   String phone;
//   String userType;
//   BuildingType buildingType;
//   List<NetworkType> networkTypes;
//   String desc;
//   String advertiserPhone;
//   int minPrice;
//   int maxPrice;
//   int minDistance;
//   int maxDistance;
//   int apartmentsCount;
//   int bedroomsCount;
//   int bathroomsCount;
//   int additionalRoomsCount;
//   int allRooms;
//   int shopsCount;
//   int streetWidth;
//   String age;
//   String dataInterface;
//   String licenseNumber;
//   String advLicenseNumber;
//   String purpose;
//   String address;
//   String lat;
//   String long;
//   int driverRoom;
//   int maidRoom;
//   int pool;
//   int carEntrance;
//   int externalStaircase;
//   int courtyard;
//   int supplement;
//   int elevator;
//   int kitchen;
//   int roof;
//   int duplex;
//   int separated;
//   int basement;
//   int airConditioner;
//   String videoLink;
//   String video;
//   String icon;
//   List<Image> images;
//   int views;
//   String status;
//   String currentStatus;
//   bool isFavored;
//   String creationTime;
//   String lastUpdate;

//   Data({
//     required this.id,
//     required this.userId,
//     required this.user,
//     required this.userAvatar,
//     required this.phone,
//     required this.userType,
//     required this.buildingType,
//     required this.networkTypes,
//     required this.desc,
//     required this.advertiserPhone,
//     required this.minPrice,
//     required this.maxPrice,
//     required this.minDistance,
//     required this.maxDistance,
//     required this.apartmentsCount,
//     required this.bedroomsCount,
//     required this.bathroomsCount,
//     required this.additionalRoomsCount,
//     required this.allRooms,
//     required this.shopsCount,
//     required this.streetWidth,
//     required this.age,
//     required this.dataInterface,
//     required this.licenseNumber,
//     required this.advLicenseNumber,
//     required this.purpose,
//     required this.address,
//     required this.lat,
//     required this.long,
//     required this.driverRoom,
//     required this.maidRoom,
//     required this.pool,
//     required this.carEntrance,
//     required this.externalStaircase,
//     required this.courtyard,
//     required this.supplement,
//     required this.elevator,
//     required this.kitchen,
//     required this.roof,
//     required this.duplex,
//     required this.separated,
//     required this.basement,
//     required this.airConditioner,
//     required this.videoLink,
//     required this.video,
//     required this.icon,
//     required this.images,
//     required this.views,
//     required this.status,
//     required this.currentStatus,
//     required this.isFavored,
//     required this.creationTime,
//     required this.lastUpdate,
//   });

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         id: json["id"],
//         userId: json["user_id"],
//         user: json["user"],
//         userAvatar: json["user_avatar"],
//         phone: json["phone"],
//         userType: json["user_type"],
//         buildingType: BuildingType.fromJson(json["building_type"]),
//         networkTypes: List<NetworkType>.from(
//             json["network_types"].map((x) => NetworkType.fromJson(x))),
//         desc: json["desc"],
//         advertiserPhone: json["advertiser_phone"],
//         minPrice: json["min_price"],
//         maxPrice: json["max_price"],
//         minDistance: json["min_distance"],
//         maxDistance: json["max_distance"],
//         apartmentsCount: json["apartments_count"],
//         bedroomsCount: json["bedrooms_count"],
//         bathroomsCount: json["bathrooms_count"],
//         additionalRoomsCount: json["additional_rooms_count"],
//         allRooms: json["all_rooms"],
//         shopsCount: json["shops_count"],
//         streetWidth: json["street_width"],
//         age: json["age"],
//         dataInterface: json["interface"],
//         licenseNumber: json["license_number"],
//         advLicenseNumber: json["adv_license_number"],
//         purpose: json["purpose"],
//         address: json["address"],
//         lat: json["lat"],
//         long: json["long"],
//         driverRoom: json["driver_room"],
//         maidRoom: json["maid_room"],
//         pool: json["pool"],
//         carEntrance: json["car_entrance"],
//         externalStaircase: json["external_staircase"],
//         courtyard: json["courtyard"],
//         supplement: json["supplement"],
//         elevator: json["elevator"],
//         kitchen: json["kitchen"],
//         roof: json["roof"],
//         duplex: json["duplex"],
//         separated: json["separated"],
//         basement: json["basement"],
//         airConditioner: json["air_conditioner"],
//         videoLink: json["video_link"],
//         video: json["video"],
//         icon: json["icon"],
//         images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
//         views: json["views"],
//         status: json["status"],
//         currentStatus: json["current_status"],
//         isFavored: json["is_favored"],
//         creationTime: json["creation_time"],
//         lastUpdate: json["last_update"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "user_id": userId,
//         "user": user,
//         "user_avatar": userAvatar,
//         "phone": phone,
//         "user_type": userType,
//         "building_type": buildingType.toJson(),
//         "network_types":
//             List<dynamic>.from(networkTypes.map((x) => x.toJson())),
//         "desc": desc,
//         "advertiser_phone": advertiserPhone,
//         "min_price": minPrice,
//         "max_price": maxPrice,
//         "min_distance": minDistance,
//         "max_distance": maxDistance,
//         "apartments_count": apartmentsCount,
//         "bedrooms_count": bedroomsCount,
//         "bathrooms_count": bathroomsCount,
//         "additional_rooms_count": additionalRoomsCount,
//         "all_rooms": allRooms,
//         "shops_count": shopsCount,
//         "street_width": streetWidth,
//         "age": age,
//         "interface": dataInterface,
//         "license_number": licenseNumber,
//         "adv_license_number": advLicenseNumber,
//         "purpose": purpose,
//         "address": address,
//         "lat": lat,
//         "long": long,
//         "driver_room": driverRoom,
//         "maid_room": maidRoom,
//         "pool": pool,
//         "car_entrance": carEntrance,
//         "external_staircase": externalStaircase,
//         "courtyard": courtyard,
//         "supplement": supplement,
//         "elevator": elevator,
//         "kitchen": kitchen,
//         "roof": roof,
//         "duplex": duplex,
//         "separated": separated,
//         "basement": basement,
//         "air_conditioner": airConditioner,
//         "video_link": videoLink,
//         "video": video,
//         "icon": icon,
//         "images": List<dynamic>.from(images.map((x) => x.toJson())),
//         "views": views,
//         "status": status,
//         "current_status": currentStatus,
//         "is_favored": isFavored,
//         "creation_time": creationTime,
//         "last_update": lastUpdate,
//       };
// }

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

// class Image {
//   int id;
//   String url;
//   Delete delete;

//   Image({
//     required this.id,
//     required this.url,
//     required this.delete,
//   });

//   factory Image.fromJson(Map<String, dynamic> json) => Image(
//         id: json["id"],
//         url: json["url"],
//         delete: Delete.fromJson(json["delete"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "url": url,
//         "delete": delete.toJson(),
//       };
// }

// class Delete {
//   String href;
//   Method method;

//   Delete({
//     required this.href,
//     required this.method,
//   });

//   factory Delete.fromJson(Map<String, dynamic> json) => Delete(
//         href: json["href"],
//         method: methodValues.map[json["method"]]!,
//       );

//   Map<String, dynamic> toJson() => {
//         "href": href,
//         "method": methodValues.reverse[method],
//       };
// }

// enum Method { delete }

// final methodValues = EnumValues({"DELETE": Method.delete});

// class NetworkType {
//   int id;
//   String name;
//   String image;

//   NetworkType({
//     required this.id,
//     required this.name,
//     required this.image,
//   });

//   factory NetworkType.fromJson(Map<String, dynamic> json) => NetworkType(
//         id: json["id"],
//         name: json["name"],
//         image: json["image"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "image": image,
//       };
// }

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
