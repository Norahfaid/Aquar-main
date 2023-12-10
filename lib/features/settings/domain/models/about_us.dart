// To parse this JSON data, do
//
//     final aboutUsResponse = aboutUsResponseFromJson(jsonString);

import 'dart:convert';

AboutUsResponse aboutUsResponseFromJson(String str) =>
    AboutUsResponse.fromJson(json.decode(str));

String aboutUsResponseToJson(AboutUsResponse data) =>
    json.encode(data.toJson());

class AboutUsResponse {
  bool success;
  Data data;
  String message;

  AboutUsResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory AboutUsResponse.fromJson(Map<String, dynamic> json) =>
      AboutUsResponse(
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
  String? content;

  Data({
    required this.content,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "content": content,
      };
}
