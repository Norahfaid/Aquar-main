// To parse this JSON data, do
//
//     final ResendResetCodeResponse = ResendResetCodeResponseFromJson(jsonString);

import 'dart:convert';

ResendResetCodeResponse resendResetCodeResponseFromJson(String str) =>
    ResendResetCodeResponse.fromJson(json.decode(str));

String resendResetCodeResponseToJson(ResendResetCodeResponse data) =>
    json.encode(data.toJson());

class ResendResetCodeResponse {
  bool success;
  Data data;
  String message;

  ResendResetCodeResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory ResendResetCodeResponse.fromJson(Map<String, dynamic> json) =>
      ResendResetCodeResponse(
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
