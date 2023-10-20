import 'package:flutter_chrome_app/linkedin_user_model.dart';
import 'package:flutter_chrome_app/model/candidate_input.dart';
import 'package:flutter_chrome_app/utils/profile_parser.dart';

class LinkedinUserDetailModel {
  String? name;
  String? avatar;
  bool? isFetch;
  String? url;
  String? address;
  List<String>? skills;
  List<Role>? roles;
  String? email;
  String? phoneCode;
  String? phoneNumber;

  LinkedinUserDetailModel({
    this.name,
    this.avatar,
    this.url,
    this.isFetch,
    this.address,
    this.skills,
    this.email,
    this.roles,
    this.phoneCode,
    this.phoneNumber,
  });

  LinkedinUserDetailModel.fromObjects({
    required LinkedinUserModel user,
    required ProfileResult profileResult,
  })  : name = user.name,
        avatar = user.avatar,
        url = user.url,
        address = user.location,
        isFetch = user.isFetch,
        skills = profileResult.skills,
        roles = profileResult.roles;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'avatar': avatar,
      'isFetch': isFetch,
      'url': url,
      'address': address,
      'email': email,
      'skills': skills,
      'roles': roles == null ? [] : List<dynamic>.from(roles!.map((x) => x.toMap())),
      'phoneCode': phoneCode,
      'phoneNumber': phoneNumber,
    };
  }

  factory LinkedinUserDetailModel.fromMap(Map<String, dynamic> json) => LinkedinUserDetailModel(
    name: json["name"],
    avatar: json["avatar"],
    isFetch: json["isFetch"],
    url: json["url"],
    address: json["address"],
    email: json["email"],
    skills: json["skills"] == null ? [] : List<String>.from(json["skills"]!.map((x) => x)),
    roles: json["roles"] == null ? [] : List<Role>.from(json["roles"]!.map((x) => Role.fromMap(x))),
    phoneCode: json["phoneCode"],
    phoneNumber: json["phoneNumber"],
  );
}
