class StatusResponse {
  final String message;
  final int status;

  StatusResponse({required this.status, required this.message});
  factory StatusResponse.fromJson(Map<String, dynamic> json) =>
      StatusResponse(status: json["status"], message: json["message"]);
}
