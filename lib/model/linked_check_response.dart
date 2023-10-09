// To parse this JSON data, do
//
//     final linkedCheckResponse = linkedCheckResponseFromMap(jsonString);

import 'dart:convert';

LinkedCheckResponse linkedCheckResponseFromMap(String str) => LinkedCheckResponse.fromMap(json.decode(str));

String linkedCheckResponseToMap(LinkedCheckResponse data) => json.encode(data.toMap());

class LinkedCheckResponse {
  final String? url;
  final String? status;

  LinkedCheckResponse({
    this.url,
    this.status,
  });

  factory LinkedCheckResponse.fromMap(Map<String, dynamic> json) => LinkedCheckResponse(
    url: json["url"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "url": url,
    "status": status,
  };
}
