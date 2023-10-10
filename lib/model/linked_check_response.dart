// To parse this JSON data, do
//
//     final linkedCheckResponse = linkedCheckResponseFromMap(jsonString);

import 'dart:convert';

List<LinkedCheckResponse> linkedCheckResponseFromMap(String str) => List<LinkedCheckResponse>.from(json.decode(str).map((x) => LinkedCheckResponse.fromMap(x)));

String linkedCheckResponseToMap(List<LinkedCheckResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

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
