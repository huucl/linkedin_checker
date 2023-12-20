import 'package:flutter_chrome_app/model/duration_model.dart';

class EducationModel {
  String? schoolName;
  String? degree;
  DurationModel? dateRange;

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
      "institution": schoolName,
      "degree": degree,
      "fromMonth": dateRange?.fromMonth,
      "fromYear": dateRange?.fromYear,
    };
  }

  factory EducationModel.fromMap(Map<String, dynamic> map) {
    return EducationModel(
      schoolName: map['schoolName'],
      degree: map['degree'],
      dateRange: map['dateRange'] == null ? null : DurationModel.fromMap(map['dateRange']),
    );
  }

  String getTextDisplay() {
    return '$schoolName, $degree, Graduate - ${dateRange?.toMonth}/${dateRange?.toYear}';
  }
}
