// To parse this JSON data, do
//
//     final sensVerificationCodeRegisterResponse = sensVerificationCodeRegisterResponseFromJson(jsonString);

import 'dart:convert';

SensVerificationCodeRegisterResponse
    sensVerificationCodeRegisterResponseFromJson(String str) =>
        SensVerificationCodeRegisterResponse.fromJson(json.decode(str));

String sensVerificationCodeRegisterResponseToJson(
        SensVerificationCodeRegisterResponse data) =>
    json.encode(data.toJson());

class SensVerificationCodeRegisterResponse {
  int code;
  String message;

  SensVerificationCodeRegisterResponse({
    required this.code,
    required this.message,
  });

  factory SensVerificationCodeRegisterResponse.fromJson(
          Map<String, dynamic> json) =>
      SensVerificationCodeRegisterResponse(
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };
}
