// To parse this JSON data, do
//
//     final location = locationFromMap(jsonString);

import 'dart:convert';

List<LocationModel> locationFromMap(String str) =>
    List<LocationModel>.from(json.decode(str).map((x) => LocationModel.fromMap(x)));

String locationToMap(List<LocationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class LocationModel {
  String? id;
  String? label;
  String? countryCode;

  LocationModel({
    this.id,
    this.label,
    this.countryCode,
  });

  factory LocationModel.fromMap(Map<String, dynamic> json) => LocationModel(
        id: json["id"],
        label: json["label"],
        countryCode: json["countryCode"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "label": label,
        "countryCode": countryCode,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          label == other.label &&
          countryCode == other.countryCode;

  @override
  int get hashCode => id.hashCode ^ label.hashCode ^ countryCode.hashCode;
}
