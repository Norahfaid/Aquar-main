// To parse this JSON data, do
//
//     final verifyChangePhoneResponse = verifyChangePhoneResponseFromJson(jsonString);

import 'dart:convert';

import 'package:aquar/features/auth/domain/models/login.dart';

VerifyChangePhoneResponse verifyChangePhoneResponseFromJson(String str) =>
    VerifyChangePhoneResponse.fromJson(json.decode(str));

String verifyChangePhoneResponseToJson(VerifyChangePhoneResponse data) =>
    json.encode(data.toJson());

class VerifyChangePhoneResponse {
  bool success;
  Data data;
  User? user;
  String message;

  VerifyChangePhoneResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory VerifyChangePhoneResponse.fromJson(Map<String, dynamic> json) =>
      VerifyChangePhoneResponse(
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
  int id;
  String name;
  dynamic email;
  String phone;
  String licenseNumber;
  UserType userType;
  String city;
  String region;
  String code;
  String avatar;
  dynamic deviceToken;
  String token;
  String resetToken;
  bool verified;
  String verifiedAt;
  String createdAt;
  String createdAtFormatted;

  Data({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.licenseNumber,
    required this.userType,
    required this.city,
    required this.region,
    required this.code,
    required this.avatar,
    required this.deviceToken,
    required this.token,
    required this.resetToken,
    required this.verified,
    required this.verifiedAt,
    required this.createdAt,
    required this.createdAtFormatted,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        licenseNumber: json["license_number"],
        userType: UserType.fromJson(json["user_type"]),
        city: json["city"],
        region: json["region"],
        code: json["code"],
        avatar: json["avatar"],
        deviceToken: json["device_token"],
        token: json["token"],
        resetToken: json["reset_token"],
        verified: json["verified"],
        verifiedAt: json["verified_at"],
        createdAt: json["created_at"],
        createdAtFormatted: json["created_at_formatted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "license_number": licenseNumber,
        "user_type": userType.toJson(),
        "city": city,
        "region": region,
        "code": code,
        "avatar": avatar,
        "device_token": deviceToken,
        "token": token,
        "reset_token": resetToken,
        "verified": verified,
        "verified_at": verifiedAt,
        "created_at": createdAt,
        "created_at_formatted": createdAtFormatted,
      };
}

class UserType {
  int id;
  String name;
  String kind;
  String kindTrans;

  UserType({
    required this.id,
    required this.name,
    required this.kind,
    required this.kindTrans,
  });

  factory UserType.fromJson(Map<String, dynamic> json) => UserType(
        id: json["id"],
        name: json["name"],
        kind: json["kind"],
        kindTrans: json["kind_trans"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "kind": kind,
        "kind_trans": kindTrans,
      };
}
