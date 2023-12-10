// To parse this JSON data, do
//
//     final socialLinksResponse = socialLinksResponseFromJson(jsonString);

import 'dart:convert';

SocialLinksResponse socialLinksResponseFromJson(String str) =>
    SocialLinksResponse.fromJson(json.decode(str));

String socialLinksResponseToJson(SocialLinksResponse data) =>
    json.encode(data.toJson());

class SocialLinksResponse {
  bool success;
  Data data;
  String message;

  SocialLinksResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory SocialLinksResponse.fromJson(Map<String, dynamic> json) =>
      SocialLinksResponse(
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
  List<String>? phones;
  String? whatsApp;
  String? facebook;
  String? instagram;
  String? youtube;
  String? snapchat;
  String? twitter;
  App app;

  Data({
    required this.phones,
    required this.whatsApp,
    required this.facebook,
    required this.instagram,
    required this.youtube,
    required this.snapchat,
    required this.twitter,
    required this.app,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        phones: json["phones"] == null
            ? []
            : List<String>.from(json["phones"].map((x) => x)),
        whatsApp: json["whats_app"],
        facebook: json["facebook"],
        instagram: json["instagram"],
        youtube: json["youtube"],
        twitter: json["twitter"],
        snapchat: json["snapchat"],
        app: App.fromJson(json["app"]),
      );

  Map<String, dynamic> toJson() => {
        "phones": List<dynamic>.from(phones!.map((x) => x)),
        "whats_app": whatsApp,
        "facebook": facebook,
        "instagram": instagram,
        "youtube": youtube,
        "snapchat": snapchat,
        'twitter': twitter,
        "app": app.toJson(),
      };
}

class App {
  String? logo;
  String? phone;
  String description;

  App({
    required this.logo,
    required this.phone,
    required this.description,
  });

  factory App.fromJson(Map<String, dynamic> json) => App(
        logo: json["logo"],
        phone: json["phone"] ?? "",
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "logo": logo,
        "phone": phone,
        "description": description,
      };
}
