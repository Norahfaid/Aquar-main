// To parse this JSON data, do
//
//     final changePhoneResponse = changePhoneResponseFromJson(jsonString);

import 'dart:convert';

ChangePhoneResponse changePhoneResponseFromJson(String str) =>
    ChangePhoneResponse.fromJson(json.decode(str));

String changePhoneResponseToJson(ChangePhoneResponse data) =>
    json.encode(data.toJson());

class ChangePhoneResponse {
  bool success;
  Data data;
  String message;

  ChangePhoneResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory ChangePhoneResponse.fromJson(Map<String, dynamic> json) =>
      ChangePhoneResponse(
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
  int code;

  Data({
    required this.code,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
      };
}
