// To parse this JSON data, do
//
//     final verifyRegisterResponse = verifyRegisterResponseFromJson(jsonString);

import 'dart:convert';

import 'package:aquar/features/auth/domain/models/login.dart';

VerifyRegisterResponse verifyRegisterResponseFromJson(String str) =>
    VerifyRegisterResponse.fromJson(json.decode(str));

String verifyRegisterResponseToJson(VerifyRegisterResponse data) =>
    json.encode(data.toJson());

class VerifyRegisterResponse {
  bool success;
  User data;
  String message;

  VerifyRegisterResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory VerifyRegisterResponse.fromJson(Map<String, dynamic> json) =>
      VerifyRegisterResponse(
        success: json["success"],
        data: User.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
      };
}
