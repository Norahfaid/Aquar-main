// To parse this JSON data, do
//
//     final registerResponse = registerResponseFromJson(jsonString);

import 'dart:convert';

import 'package:aquar/features/auth/domain/models/user_types.dart';

import 'login.dart';

RegisterResponse registerResponseFromJson(String str) =>
    RegisterResponse.fromJson(json.decode(str));

String registerResponseToJson(RegisterResponse data) =>
    json.encode(data.toJson());

class RegisterResponse {
  bool success;
  User data;
  String message;

  RegisterResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
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
  String nationalId;

  Data({
    required this.id,
    required this.name,
    this.email,
    required this.phone,
    required this.licenseNumber,
    required this.userType,
    required this.city,
    required this.region,
    required this.code,
    required this.avatar,
    this.deviceToken,
    required this.token,
    required this.resetToken,
    required this.verified,
    required this.verifiedAt,
    required this.createdAt,
    required this.createdAtFormatted,
    required this.nationalId,
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
        nationalId: json["national_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "license_number": licenseNumber,
        "user_type": userType,
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
        "national_id": nationalId,
      };
}
