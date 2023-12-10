// To parse this JSON data, do
//
//     final ForgetPassResponse = ForgetPassResponseFromJson(jsonString);

import 'dart:convert';

ForgetPassResponse forgetPassResponseFromJson(String str) =>
    ForgetPassResponse.fromJson(json.decode(str));

String forgetPassResponseToJson(ForgetPassResponse data) =>
    json.encode(data.toJson());

class ForgetPassResponse {
  bool success;
  Data data;
  String message;

  ForgetPassResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory ForgetPassResponse.fromJson(Map<String, dynamic> json) =>
      ForgetPassResponse(
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
  int resetCode;

  Data({
    required this.resetCode,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        resetCode: json["reset_code"],
      );

  Map<String, dynamic> toJson() => {
        "reset_code": resetCode,
      };
}
