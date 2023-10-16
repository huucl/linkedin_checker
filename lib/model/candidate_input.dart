// To parse this JSON data, do
//
//     final candidate = candidateFromMap(jsonString);

import 'dart:convert';

Candidate candidateFromMap(String str) => Candidate.fromMap(json.decode(str));

String candidateToMap(Candidate data) => json.encode(data.toMap());

class Candidate {
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? avatar;
  final String? phoneCode;
  final String? phoneNumber;
  final String? address;
  final Skills? skills;
  final String? linkedin;
  final WorkExperiences? workExperiences;

  Candidate({
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
    this.phoneCode,
    this.phoneNumber,
    this.address,
    this.skills,
    this.linkedin,
    this.workExperiences,
  });

  factory Candidate.fromMap(Map<String, dynamic> json) => Candidate(
    email: json["email"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    avatar: json["avatar"],
    phoneCode: json["phoneCode"],
    phoneNumber: json["phoneNumber"],
    address: json["address"],
    skills: json["skills"] == null ? null : Skills.fromMap(json["skills"]),
    linkedin: json["linkedin"],
    workExperiences: json["workExperiences"] == null ? null : WorkExperiences.fromMap(json["workExperiences"]),
  );

  Map<String, dynamic> toMap() => {
    "email": email,
    "firstName": firstName,
    "lastName": lastName,
    "avatar": avatar,
    "phoneCode": phoneCode,
    "phoneNumber": phoneNumber,
    "address": address,
    "skills": skills?.toMap(),
    "linkedin": linkedin,
    "workExperiences": workExperiences?.toMap(),
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

class WorkExperiences {
  final List<ExistRoleExperience>? existRoleExperience;
  final List<NewRoleExperience>? newRoleExperience;

  WorkExperiences({
    this.existRoleExperience,
    this.newRoleExperience,
  });

  factory WorkExperiences.fromMap(Map<String, dynamic> json) => WorkExperiences(
    existRoleExperience: json["existRoleExperience"] == null ? [] : List<ExistRoleExperience>.from(json["existRoleExperience"]!.map((x) => ExistRoleExperience.fromMap(x))),
    newRoleExperience: json["newRoleExperience"] == null ? [] : List<NewRoleExperience>.from(json["newRoleExperience"]!.map((x) => NewRoleExperience.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "existRoleExperience": existRoleExperience == null ? [] : List<dynamic>.from(existRoleExperience!.map((x) => x.toMap())),
    "newRoleExperience": newRoleExperience == null ? [] : List<dynamic>.from(newRoleExperience!.map((x) => x.toMap())),
  };
}

class ExistRoleExperience {
  final String? roleExperienceId;
  final int? yearsOfExperience;

  ExistRoleExperience({
    this.roleExperienceId,
    this.yearsOfExperience,
  });

  factory ExistRoleExperience.fromMap(Map<String, dynamic> json) => ExistRoleExperience(
    roleExperienceId: json["roleExperienceId"],
    yearsOfExperience: json["yearsOfExperience"],
  );

  Map<String, dynamic> toMap() => {
    "roleExperienceId": roleExperienceId,
    "yearsOfExperience": yearsOfExperience,
  };
}

class NewRoleExperience {
  final String? newRoleExperience;
  final int? yearsOfExperience;

  NewRoleExperience({
    this.newRoleExperience,
    this.yearsOfExperience,
  });

  factory NewRoleExperience.fromMap(Map<String, dynamic> json) => NewRoleExperience(
    newRoleExperience: json["newRoleExperience"],
    yearsOfExperience: json["yearsOfExperience"],
  );

  Map<String, dynamic> toMap() => {
    "newRoleExperience": newRoleExperience,
    "yearsOfExperience": yearsOfExperience,
  };
}

extension MapExtension on Map<String,dynamic>{
  Map<String,dynamic> removeNull(){
    return Map.fromEntries(entries.where((element) => (element.value != null && element.value != '')));
  }
}