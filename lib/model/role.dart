import 'package:flutter_chrome_app/model/duration_model.dart';

class Role {
  String name;
  DurationModel duration;

  Role(this.name, this.duration);

  @override
  String toString() {
    return 'Role{name: $name, dates: ${duration.year} years ${duration.month} months}} from ${duration.fromMonth} ${duration.fromYear} to ${duration.toMonth} ${duration.toYear}';
  }

  String getTextDisplay() {
    if (duration.year > 1) {
      return '$name - ${duration.year} years ${duration.month} months';
    }
    if (duration.year == 1) {
      return '$name - ${duration.year} year';
    } else {
      return '$name - ${duration.month} months';
    }
    return '${duration.year} years ${duration.month} months';
  }

  int getYOE() {
    if (duration.year >= 1) {
      return duration.year;
    } else {
      return 1;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'duration': duration.toMap(),
    };
  }

  factory Role.fromMap(Map<String, dynamic> map) {
    return Role(
      map['name'] as String,
      DurationModel.fromMap(map["duration"]),
    );
  }
}