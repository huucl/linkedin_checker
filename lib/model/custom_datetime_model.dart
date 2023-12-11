// To parse this JSON data, do
//
//     final customDatetime = customDatetimeFromMap(jsonString);

import 'dart:convert';

CustomDatetime customDatetimeFromMap(String str) => CustomDatetime.fromMap(json.decode(str));

String customDatetimeToMap(CustomDatetime data) => json.encode(data.toMap());

class CustomDatetime {
  final int? fromMonth;
  final int? fromYear;
  final int? toMonth;
  final int? toYear;
  final bool? isPresent;

  CustomDatetime({
    this.fromMonth,
    this.fromYear,
    this.toMonth,
    this.toYear,
    this.isPresent,
  });

  factory CustomDatetime.fromMap(Map<String, dynamic> json) => CustomDatetime(
    fromMonth: json["fromMonth"],
    fromYear: json["fromYear"],
    toMonth: json["toMonth"],
    toYear: json["toYear"],
    isPresent: json["isPresent"],
  );

  Map<String, dynamic> toMap() => {
    "fromMonth": fromMonth,
    "fromYear": fromYear,
    "toMonth": toMonth,
    "toYear": toYear,
    "isPresent": isPresent,
  };

  @override
  String toString() {
    if (isPresent == true) {
      return 'from $fromMonth/$fromYear to present';
    }
    return 'from $fromMonth/$fromYear to $toMonth/$toYear';
  }
}
