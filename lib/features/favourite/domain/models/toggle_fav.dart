// To parse this JSON data, do
//
//     final toggleFavouritiesResponse = toggleFavouritiesResponseFromJson(jsonString);

import 'dart:convert';

ToggleFavouritiesResponse toggleFavouritiesResponseFromJson(String str) =>
    ToggleFavouritiesResponse.fromJson(json.decode(str));

String toggleFavouritiesResponseToJson(ToggleFavouritiesResponse data) =>
    json.encode(data.toJson());

class ToggleFavouritiesResponse {
  bool success;
  bool message;

  ToggleFavouritiesResponse({
    required this.success,
    required this.message,
  });

  factory ToggleFavouritiesResponse.fromJson(Map<String, dynamic> json) =>
      ToggleFavouritiesResponse(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
