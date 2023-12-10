import '../../../home/domain/models/filter.dart';

class Product {
  int id;
  String type;
  Advertisement? advertisement;
  DateTime createdAt;
  String createdAtFormatted;

  Product({
    required this.id,
    required this.type,
    required this.advertisement,
    required this.createdAt,
    required this.createdAtFormatted,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        type: json["type"] ?? "",
        advertisement: json["advertisement"] == null
            ? null
            : Advertisement.fromJson(json["advertisement"]),
        createdAt: DateTime.parse(json["created_at"]),
        createdAtFormatted: json["created_at_formatted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "advertisement": advertisement!.toJson(),
        "created_at": createdAt.toIso8601String(),
        "created_at_formatted": createdAtFormatted,
      };
}

class Advertisement {
  int id;
  String user;
  BuildingType buildingType;
  List<NetWorkTypes> networkType;
  String desc;
  String phone;
  String advertiserPhone;
  int views;
  int minPrice;
  int maxPrice;
  int minDistance;
  int maxDistance;
  int apartmentsCount;
  int bedroomsCount;
  int shopsCount;
  int streetWidth;
  dynamic age;
  String advertisementInterface;
  dynamic licenseNumber;
  String purpose;
  String address;
  String lat;
  String long;
  int driverRoom;
  int maidRoom;
  int pool;
  dynamic carEntrance;
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

  Advertisement({
    required this.id,
    required this.user,
    required this.buildingType,
    required this.views,
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
    required this.advertisementInterface,
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

  factory Advertisement.fromJson(Map<String, dynamic> json) => Advertisement(
        id: json["id"],
        user: json["user"],
        views: json["views"],
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
        streetWidth: json["street_width"] ?? 0,
        age: json["age"],
        advertisementInterface: json["interface"].toString(),
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
        "interface": advertisementInterface,
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
        "images": List<dynamic>.from(images.map((x) => x)),
      };
}
