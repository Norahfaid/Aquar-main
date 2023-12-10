// To parse this JSON data, do
//
//     final userTypesResponse = userTypesResponseFromJson(jsonString);

import 'dart:convert';

UserTypesResponse userTypesResponseFromJson(String str) =>
    UserTypesResponse.fromJson(json.decode(str));

String userTypesResponseToJson(UserTypesResponse data) =>
    json.encode(data.toJson());

class UserTypesResponse {
  bool success;
  Data data;
  String message;

  UserTypesResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory UserTypesResponse.fromJson(Map<String, dynamic> json) =>
      UserTypesResponse(
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
  List<UserType> data;
  Links links;
  Meta meta;

  Data({
    required this.data,
    required this.links,
    required this.meta,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data:
            List<UserType>.from(json["data"].map((x) => UserType.fromJson(x))),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "links": links.toJson(),
        "meta": meta.toJson(),
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
        kind: json["kind"] ?? "",
        kindTrans: json["kind_trans"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "kind": kind,
        "kind_trans": kindTrans,
      };
}

class Links {
  String first;
  String last;
  dynamic prev;
  dynamic next;

  Links({
    required this.first,
    required this.last,
    this.prev,
    this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };
}

class Meta {
  int currentPage;
  int from;
  int lastPage;
  List<Link> links;
  String path;
  int perPage;
  int to;
  int total;

  Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
      };
}

class Link {
  String? url;
  String label;
  bool active;

  Link({
    this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
