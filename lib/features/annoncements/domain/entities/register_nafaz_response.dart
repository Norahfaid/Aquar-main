import '../../../auth/domain/models/login.dart';

class RegisterNafazResponse {
  bool success;
  User? user;
  String message;

  RegisterNafazResponse({
    required this.success,
    this.user,
    required this.message,
  });

  factory RegisterNafazResponse.fromJson(Map<String, dynamic> json) => RegisterNafazResponse(
    success: json["success"],
    user: json["data"] != null? User.fromJson(json["data"]) : null,
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": user?.toJson(),
    "message": message,
  };
}
