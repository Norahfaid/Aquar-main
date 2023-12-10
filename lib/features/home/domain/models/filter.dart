// To parse this JSON data, do
//
//     final filterResponse = filterResponseFromJson(jsonString);

import 'dart:convert';

FilterResponse filterResponseFromJson(String str) =>
    FilterResponse.fromJson(json.decode(str));

// String filterResponseToJson(FilterResponse data) => json.encode(data.toJson());

class FilterResponse {
  final bool success;
  final FilterResponseData data;
  final String message;

  FilterResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory FilterResponse.fromJson(Map<String, dynamic> json) => FilterResponse(
        success: json["success"],
        data: FilterResponseData.fromJson(json["data"]),
        message: json["message"],
      );

  // Map<String, dynamic> toJson() => {
  //       "success": success,
  //       "data": data.toJson(),
  //       "message": message,
  //     };
}

class FilterResponseData {
  final List<AnnounceData> data;
  final Links? links;
  final Meta? meta;

  FilterResponseData({
    required this.data,
    required this.links,
    required this.meta,
  });

  factory FilterResponseData.fromJson(Map<String, dynamic> json) => FilterResponseData(
        data: List<AnnounceData>.from(
            json["data"].map((x) => AnnounceData.fromJson(x))),
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  // Map<String, dynamic> toJson() => {
  //       "data": List<dynamic>.from(data.map((x) => x.toJson())),
  //       "links": links.toJson(),
  //       "meta": meta.toJson(),
  //     };
}

class AnnounceData {
  final int id;
  final String? user;
  final String userAvatar;
  final String userType;
  final BuildingType buildingType;
  final List<NetWorkTypes> networkTypes;
  final String desc;
  final String phone;
  final String advertiserPhone;
  final int minPrice;
  final int maxPrice;
  final int minDistance;
  final int maxDistance;
  final int apartmentsCount;
  final int bedroomsCount;
  final int allRooms;
  final int bathroomsCount;
  final int additionalRoomsCount;
  final int shopsCount;
  final int? streetWidth;
  final dynamic age;
  final dynamic interface;
  final String currentStatus;
  final String licenseNumber;
  final String advLicenseNumber;
  final String purpose;
  final String address;
  final String? link;
  final String lat;
  final String long;
  final bool fromDashboard;
  final bool createdFromDashboard;
  final int driverRoom;
  final int maidRoom;
  final int pool;
  final int carEntrance;
  final int externalStaircase;
  final int courtyard;
  final int supplement;
  final int elevator;
  final int kitchen;
  final int roof;
  final int duplex;
  final int separated;
  final int basement;
  final int views;
  final int airConditioner;
  final String? videoLink;
  final String? video;
  final String icon;
  final List<ImageFilter> aqarImages;
  final String status;
  bool isFavorite;
  final String creationTime;
  final String lastUpdate;
  AnnounceData toggleFav() {
    isFavorite = !isFavorite;
    return this;
  }

  AnnounceData({
    required this.id,
    required this.user,
    required this.userAvatar,
    required this.views,
    required this.userType,
    required this.link,
    required this.buildingType,
    required this.networkTypes,
    required this.desc,
    required this.fromDashboard,
    required this.createdFromDashboard,
    required this.phone,
    required this.advertiserPhone,
    required this.minPrice,
    required this.maxPrice,
    required this.minDistance,
    required this.maxDistance,
    required this.apartmentsCount,
    required this.bedroomsCount,
    required this.allRooms,
    required this.currentStatus,
    required this.bathroomsCount,
    required this.additionalRoomsCount,
    required this.shopsCount,
    required this.streetWidth,
    required this.age,
    required this.interface,
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
    required this.aqarImages,
    required this.status,
    required this.isFavorite,
    required this.creationTime,
    required this.lastUpdate,
  });

  factory AnnounceData.fromJson(Map<String, dynamic> json) => AnnounceData(
        id: json["id"] ?? 0,
        user: json["user"] ?? '',
        link: json["link"] ?? 'link',
        userAvatar: json["user_avatar"] ?? '',
        views: json["views"] ?? '',
        userType: json["user_type"] ?? "",
        fromDashboard: (json["from_dashboard"] ?? 0) == 1,
        createdFromDashboard: (json["created_from_dashboard"] ?? 0) == 1,
        buildingType: BuildingType.fromJson(json["building_type"]),
        networkTypes: List<NetWorkTypes>.from(
            json["network_types"].map((x) => NetWorkTypes.fromJson(x))),
        desc: json["desc"] ?? '',
        phone: json["phone"] ?? "",
        advertiserPhone: json["advertiser_phone"] ?? "",
        minPrice: json["min_price"] ?? 0,
        maxPrice: json["max_price"] ?? 0,
        minDistance: json["min_distance"] ?? 0,
        maxDistance: json["max_distance"] ?? 0,
        apartmentsCount: json["apartments_count"] ?? 0,
        currentStatus: json["current_status"] ?? "",
        bedroomsCount: json["bedrooms_count"] ?? 0,
        allRooms: json["all_rooms"] ?? 0,
        bathroomsCount: json["bathrooms_count"] ?? 0,
        additionalRoomsCount: json["additional_rooms_count"] ?? 0,
        shopsCount: json["shops_count"] ?? 0,
        streetWidth: json["street_width"] ?? 0,
        age: json["age"] ?? '',
        interface: json["interface"] ?? '',
        licenseNumber: (json["license_number"] ?? "").toString(),
        advLicenseNumber: (json["adv_license_number"] ?? "").toString(),
        purpose: json["purpose"]! ?? "",
        address: json["address"] ?? "",
        lat: json["lat"] ?? "",
        long: json["long"] ?? "",
        driverRoom: json["driver_room"] ?? 0,
        maidRoom: json["maid_room"] ?? 0,
        pool: json["pool"] ?? 0,
        carEntrance: json["car_entrance"] ?? 0,
        externalStaircase: json["external_staircase"] ?? 0,
        courtyard: json["courtyard"] ?? 0,
        supplement: json["supplement"] ?? 0,
        elevator: json["elevator"] ?? 0,
        kitchen: json["kitchen"] ?? 0,
        roof: json["roof"] ?? 0,
        duplex: json["duplex"] ?? 0,
        separated: json["separated"] ?? 0,
        basement: json["basement"] ?? 0,
        airConditioner: json["air_conditioner"] ?? 0,
        videoLink: json["video_link"] ?? '',
        video: json["video"] ?? "",
        icon: json["icon"] ?? "",
        aqarImages: List<ImageFilter>.from(
            json["images"].map((x) => ImageFilter.fromJson(x))),
        status: json["status"]! ?? "",
        isFavorite: json["is_favored"] ?? false,
        creationTime: json["creation_time"]! ?? "",
        lastUpdate: json["last_update"]! ?? "",
      );
}

class ImageFilter {
  int id;
  String url;
  DeleteImageFilter delete;

  ImageFilter({
    required this.id,
    required this.url,
    required this.delete,
  });

  factory ImageFilter.fromJson(Map<String, dynamic> json) => ImageFilter(
        id: json["id"],
        url: json["url"],
        delete: DeleteImageFilter.fromJson(json["delete"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "delete": delete.toJson(),
      };
}

class DeleteImageFilter {
  String href;
  DeleteImageMethod method;

  DeleteImageFilter({
    required this.href,
    required this.method,
  });

  factory DeleteImageFilter.fromJson(Map<String, dynamic> json) =>
      DeleteImageFilter(
        href: json["href"],
        method: deleteImageMethodValues.map[json["method"]]!,
      );

  Map<String, dynamic> toJson() => {
        "href": href,
        "method": deleteImageMethodValues.reverse[method],
      };
}

enum DeleteImageMethod { delete }

final deleteImageMethodValues = EnumValues({"DELETE": DeleteImageMethod.delete});

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

class NetWorkTypes {
  int id;
  String name;
  String image;

  NetWorkTypes({
    required this.id,
    required this.name,
    required this.image,
  });

  factory NetWorkTypes.fromJson(Map<String, dynamic> json) => NetWorkTypes(
        id: json["id"],
        name: json["name"]!,
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {"id": id, "name": name, "image": image};
}

class Links {
  final String first;
  final String last;
  final dynamic prev;
  final dynamic next;

  Links({
    required this.first,
    required this.last,
    this.prev,
    this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };
}

class Meta {
  final int currentPage;
  final int from;
  final int lastPage;
  final List<Link> links;
  final String path;
  final int perPage;
  final int to;
  final int total;

  Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
      };
}

class Link {
  final String? url;
  final String label;
  final bool active;

  Link({
    this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
