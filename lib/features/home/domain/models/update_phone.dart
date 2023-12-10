// To parse this JSON data, do
//
//     final updatePhoneResponse = updatePhoneResponseFromJson(jsonString);

import 'dart:convert';

UpdatePhoneResponse updatePhoneResponseFromJson(String str) => UpdatePhoneResponse.fromJson(json.decode(str));

String updatePhoneResponseToJson(UpdatePhoneResponse data) => json.encode(data.toJson());

class UpdatePhoneResponse {
  final bool success;
  final Data data;
  final String message;

  UpdatePhoneResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory UpdatePhoneResponse.fromJson(Map<String, dynamic> json) => UpdatePhoneResponse(
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
  final int code;

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
