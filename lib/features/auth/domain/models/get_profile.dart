// To parse this JSON data, do
//
//     final getProfileResponse = getProfileResponseFromJson(jsonString);

import 'dart:convert';

import 'login.dart';

GetProfileResponse getProfileResponseFromJson(String str) =>
    GetProfileResponse.fromJson(json.decode(str));

String getProfileResponseToJson(GetProfileResponse data) =>
    json.encode(data.toJson());

class GetProfileResponse {
  final bool success;
  final User data;
  final String message;

  GetProfileResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory GetProfileResponse.fromJson(Map<String, dynamic> json) =>
      GetProfileResponse(
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

// class UserProfile {
//   final int id;
//   final String name;
//   final dynamic email;
//   final String phone;
//   final String licenseNumber;
//   final String userType;
//   final String city;
//   final String region;
//   final String code;
//   final String avatar;
//   final dynamic deviceToken;
//   final String token;
//   final String resetToken;
//   final bool verified;
//   final String verifiedAt;
//   final String createdAt;
//   final String createdAtFormatted;

//   UserProfile({
//     required this.id,
//     required this.name,
//     this.email,
//     required this.phone,
//     required this.licenseNumber,
//     required this.userType,
//     required this.city,
//     required this.region,
//     required this.code,
//     required this.avatar,
//     this.deviceToken,
//     required this.token,
//     required this.resetToken,
//     required this.verified,
//     required this.verifiedAt,
//     required this.createdAt,
//     required this.createdAtFormatted,
//   });

//   factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
//     id: json["id"],
//     name: json["name"],
//     email: json["email"],
//     phone: json["phone"],
//     licenseNumber: json["license_number"],
//     userType: json["user_type"],
//     city: json["city"],
//     region: json["region"],
//     code: json["code"],
//     avatar: json["avatar"],
//     deviceToken: json["device_token"],
//     token: json["token"],
//     resetToken: json["reset_token"],
//     verified: json["verified"],
//     verifiedAt: json["verified_at"],
//     createdAt: json["created_at"],
//     createdAtFormatted: json["created_at_formatted"],
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "email": email,
//     "phone": phone,
//     "license_number": licenseNumber,
//     "user_type": userType,
//     "city": city,
//     "region": region,
//     "code": code,
//     "avatar": avatar,
//     "device_token": deviceToken,
//     "token": token,
//     "reset_token": resetToken,
//     "verified": verified,
//     "verified_at": verifiedAt,
//     "created_at": createdAt,
//     "created_at_formatted": createdAtFormatted,
//   };
// }
