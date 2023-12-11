import 'package:flutter_chrome_app/model/custom_datetime_model.dart';

class EducationModel {
  String? schoolName;
  String? degree;
  CustomDatetime? dateRange;

  EducationModel({
    this.schoolName,
    this.degree,
    this.dateRange,
  });

  @override
  String toString() {
    return 'School: $schoolName\nDegree: $degree\nDate Range: $dateRange\n';
  }

  Map<String, dynamic> toMap() {
    return {
      'schoolName': schoolName,
      'degree': degree,
      'dateRange': dateRange == null ? null : dateRange!.toMap(),
    };
  }

  factory EducationModel.fromMap(Map<String, dynamic> map) {
    return EducationModel(
      schoolName: map['schoolName'],
      degree: map['degree'],
      dateRange: map['dateRange'] == null ? null : CustomDatetime.fromMap(map['dateRange']),
    );
  }
}