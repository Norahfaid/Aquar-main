// To parse this JSON data, do
//
//     final termsResponse = termsResponseFromJson(jsonString);

import 'dart:convert';

TermsResponse termsResponseFromJson(String str) =>
    TermsResponse.fromJson(json.decode(str));

String termsResponseToJson(TermsResponse data) => json.encode(data.toJson());

class TermsResponse {
  bool success;
  Data data;
  String message;

  TermsResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory TermsResponse.fromJson(Map<String, dynamic> json) => TermsResponse(
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
