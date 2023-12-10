// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:aquar/features/auth/domain/models/user_types.dart';

String userToJson(User data) => json.encode(data.toJson());
LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

User userFromJson(String str) => User.fromJson(json.decode(str));

class LoginResponse {
  bool success;
  User data;
  String message;

  LoginResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
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

class User {
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
  String? nationalId;
  String? nafazRandom;
  int? nafazComplete;

  // Statistics? statistics;

  User({
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
    this.nationalId,
    this.nafazRandom,
    this.nafazComplete,
    // required this.statistics,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
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
        nafazRandom: json["nafaz_random"],
        nafazComplete: json["nafaz_complete"],
        // statistics: json["statistics"] == null
        // ? null
        // : Statistics.fromJson(json["statistics"]),
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
        "nafaz_random": nafazRandom,
        "nafaz_complete": nafazComplete,
        // "statistics": statistics?.toJson(),
      };
}

// class Statistics {
//   int pending;
//   int published;
//   int rejected;

//   Statistics({
//     required this.pending,
//     required this.published,
//     required this.rejected,
//   });

//   factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
//         pending: json["pending"],
//         published: json["published"],
//         rejected: json["rejected"],
//       );

//   Map<String, dynamic> toJson() => {
//         "pending": pending,
//         "published": published,
//         "rejected": rejected,
//       };
// }
