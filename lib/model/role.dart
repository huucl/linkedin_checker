import 'package:flutter_chrome_app/model/candidate_input.dart';
import 'package:flutter_chrome_app/model/duration_model.dart';

class Role {
  String title;
  String? companyName;
  DurationModel duration;

  Role(this.title, this.duration, {this.companyName});

  @override
  String toString() {
    return 'Role{name: $title, from ${duration.fromMonth} ${duration.fromYear} to ${duration.toMonth} ${duration.toYear}';
  }

  String getTextDisplay() {
    var to = duration.isNew == true ? 'Present' : '${duration.toMonth} ${duration.toYear}';
    return '$title at $companyName from ${duration.fromMonth}/${duration.fromYear} to $to';
  }


  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'duration': duration.toMap(),
    };
  }

  factory Role.fromMap(Map<String, dynamic> map) {
    return Role(
      map['title'] as String,
      DurationModel.fromMap(map["duration"]),
    );
  }
}

extension ListRolesExtension on List<Role> {
  List<WorkExperience> toWorkExperience() {
    return map((e) => WorkExperience(
      companyName: e.companyName,
      position: e.title,
      fromMonth: e.duration.fromMonth,
      fromYear: e.duration.fromYear,
      toMonth: e.duration.toMonth,
      toYear: e.duration.toYear,
    )).toList();
  }
}