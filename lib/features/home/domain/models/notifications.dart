// To parse this JSON data, do
//
//     final notificationsResponse = notificationsResponseFromJson(jsonString);

import 'dart:convert';

NotificationsResponse notificationsResponseFromJson(String str) => NotificationsResponse.fromJson(json.decode(str));

String notificationsResponseToJson(NotificationsResponse data) => json.encode(data.toJson());

class NotificationsResponse {
  final bool success;
  final Data data;
  final String message;

  NotificationsResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) => NotificationsResponse(
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
  final List<NotificationList> data;

  Data({
    required this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: List<NotificationList>.from(json["data"].map((x) => NotificationList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class NotificationList {
  final String id;
  final String title;
  final String message;
  final String createTime;
  final String timeFormatted;

  NotificationList( {
    required this.id,
    required this.title,
    required this.message,required this.createTime,required this.timeFormatted,
  });

  factory NotificationList.fromJson(Map<String, dynamic> json) => NotificationList(
    id: json["id"],
    title: json["title"],
    message: json["message"],
    createTime:json["creation_time"] ,
    timeFormatted:json["created_at_formatted"] ,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "message": message,

  };
}
