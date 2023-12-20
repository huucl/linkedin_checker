// To parse this JSON data, do
//
//     final candidate = candidateFromMap(jsonString);

import 'dart:convert';

import 'package:flutter_chrome_app/model/education_model.dart';

Candidate candidateFromMap(String str) => Candidate.fromMap(json.decode(str));

String candidateToMap(Candidate data) => json.encode(data.toMap());

class Candidate {
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? avatar;
  final String? phoneCode;
  final String? phoneNumber;
  final String? locationId;
  final Skills? skills;
  final String? assigneeId;
  final String? linkedin;
  final List<WorkExperience>? workExperiences;
  final List<EducationModel>? educations;

  Candidate({
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
    this.phoneCode,
    this.phoneNumber,
    this.locationId,
    this.skills,
    this.linkedin,
    this.assigneeId,
    this.workExperiences,
    this.educations,
  });

  factory Candidate.fromMap(Map<String, dynamic> json) => Candidate(
    email: json["email"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    avatar: json["avatar"],
    phoneCode: json["phoneCode"],
    phoneNumber: json["phoneNumber"],
    locationId: json["locationId"],
    skills: json["skills"] == null ? null : Skills.fromMap(json["skills"]),
    assigneeId: json["assigneeId"],
    linkedin: json["linkedin"],
    workExperiences: json["workExperiences"] == null ? null : List<WorkExperience>.from(json["workExperiences"].map((x) => WorkExperience.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "email": email,
    "firstName": firstName,
    "lastName": lastName,
    "avatar": avatar,
    "phoneCode": phoneCode,
    "phoneNumber": phoneNumber,
    "locationId": locationId,
    "skills": skills?.toMap(),
    "assigneeId": assigneeId,
    "linkedin": linkedin,
    "workExperiences": workExperiences?.map((x) => x.toMap()).toList(),
    "educations": educations?.map((x) => x.toMap()).toList(),
  };
}

class Skills {
  final List<String>? newSkills;
  final List<String>? skillIds;

  Skills({
    this.newSkills,
    this.skillIds,
  });

  factory Skills.fromMap(Map<String, dynamic> json) => Skills(
    newSkills: json["newSkills"] == null ? [] : List<String>.from(json["newSkills"]!.map((x) => x)),
    skillIds: json["skillIds"] == null ? [] : List<String>.from(json["skillIds"]!.map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "newSkills": newSkills == null ? [] : List<dynamic>.from(newSkills!.map((x) => x)),
    "skillIds": skillIds == null ? [] : List<dynamic>.from(skillIds!.map((x) => x)),
  };
}



WorkExperience workExperienceFromMap(String str) => WorkExperience.fromMap(json.decode(str));

String workExperienceToMap(WorkExperience data) => json.encode(data.toMap());

class WorkExperience {
  final String? companyName;
  final String? position;
  final int? fromMonth;
  final int? fromYear;
  final int? toMonth;
  final int? toYear;

  WorkExperience({
    this.companyName,
    this.position,
    this.fromMonth,
    this.fromYear,
    this.toMonth,
    this.toYear,
  });

  factory WorkExperience.fromMap(Map<String, dynamic> json) => WorkExperience(
    companyName: json["companyName"],
    position: json["position"],
    fromMonth: json["fromMonth"],
    fromYear: json["fromYear"],
    toMonth: json["toMonth"],
    toYear: json["toYear"],
  );

  Map<String, dynamic> toMap() => {
    "companyName": companyName,
    "position": position,
    "fromMonth": fromMonth,
    "fromYear": fromYear,
    "toMonth": toMonth,
    "toYear": toYear,
  };
}


extension MapExtension on Map<String,dynamic>{
  Map<String,dynamic> removeNull(){
    return Map.fromEntries(entries.where((element) => (element.value != null && element.value != '')));
  }
}