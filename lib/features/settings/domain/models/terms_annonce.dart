// To parse this JSON data, do
//
//     final TermsAnnonceResponse = TermsAnnonceResponseFromJson(jsonString);

import 'dart:convert';

TermsAnnonceResponse termsAnnonceResponseFromJson(String str) =>
    TermsAnnonceResponse.fromJson(json.decode(str));

String termsAnnonceResponseToJson(TermsAnnonceResponse data) =>
    json.encode(data.toJson());

class TermsAnnonceResponse {
  bool success;
  Data data;
  String message;

  TermsAnnonceResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory TermsAnnonceResponse.fromJson(Map<String, dynamic> json) =>
      TermsAnnonceResponse(
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
