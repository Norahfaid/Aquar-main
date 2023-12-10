// To parse this JSON data, do
//
//     final getFavouritiesResponse = getFavouritiesResponseFromJson(jsonString);

import 'dart:convert';

import '../../../home/domain/models/filter.dart';

GetFavouritiesResponse getFavouritiesResponseFromJson(String str) =>
    GetFavouritiesResponse.fromJson(json.decode(str));

class GetFavouritiesResponse {
  bool success;
  List<AnnounceData> data;
  String message;

  GetFavouritiesResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory GetFavouritiesResponse.fromJson(Map<String, dynamic> json) =>
      GetFavouritiesResponse(
        success: json["success"],
        data: List<AnnounceData>.from(json["data"]
            .where((e) => e["advertisement"] != null)
            .map((x) => AnnounceData.fromJson(x['advertisement']))),
        message: json["message"],
      );
}
