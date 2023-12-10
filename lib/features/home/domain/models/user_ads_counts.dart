// To parse this JSON data, do
//
//     final userAdsCountsResponse = userAdsCountsResponseFromJson(jsonString);

import 'dart:convert';

UserAdsCountsResponse userAdsCountsResponseFromJson(String str) =>
    UserAdsCountsResponse.fromJson(json.decode(str));

String userAdsCountsResponseToJson(UserAdsCountsResponse data) =>
    json.encode(data.toJson());

class UserAdsCountsResponse {
  bool success;
  Data data;
  String message;

  UserAdsCountsResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory UserAdsCountsResponse.fromJson(Map<String, dynamic> json) =>
      UserAdsCountsResponse(
        success: json["success"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
      };
}

class Data {
  int pending;
  int published;
  int rejected;
  int sold;

  Data({
    required this.pending,
    required this.published,
    required this.rejected,
    required this.sold,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        pending: json["pending"],
        published: json["published"],
        rejected: json["rejected"],
        sold: json["sold"],
      );

  Map<String, dynamic> toJson() => {
        "pending": pending,
        "published": published,
        "rejected": rejected,
        "sold": sold,
      };
}
