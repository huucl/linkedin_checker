import 'package:flutter_chrome_app/model/custom_datetime_model.dart';
import 'package:flutter_chrome_app/model/duration_model.dart';

class Role {
  String? companyName;
  String? title;
  CustomDatetime? duration;

  Role({
    this.companyName,
    this.title,
    this.duration,
  });

  @override
  String toString() {
    return 'Role{name: $title, duration: $duration}';
  }

  Map<String, dynamic> toMap() {
    return {
      'companyName': companyName,
      'title': title,
      'duration': duration,
    };
  }

  factory Role.fromMap(Map<String, dynamic> map) {
    return Role(
      companyName: map['companyName'] as String,
      title: map['title'] as String,
      duration: map['duration'] as CustomDatetime,
    );
  }

  String getTextDisplay() {
    return '$title at $companyName (${duration!.toString()})';
  }
//
// int getYOE() {
//   if (duration.year >= 1) {
//     return duration.year;
//   } else {
//     return 1;
//   }
// }
//
// Map<String, dynamic> toMap() {
//   return {
//     'name': name,
//     'duration': duration.toMap(),
//   };
// }
//
// factory Role.fromMap(Map<String, dynamic> map) {
//   return Role(
//     map['name'] as String,
//     DurationModel.fromMap(map["duration"]),
//   );
// }
}
