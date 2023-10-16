import 'package:flutter_chrome_app/linkedin_user_model.dart';
import 'package:flutter_chrome_app/utils/profile_parser.dart';

class LinkedinUserDetailModel {
  String? name;
  String? avatar;
  bool? isFetch;
  String? url;
  List<String>? skills;
  List<Role>? roles;

  LinkedinUserDetailModel({
    this.name,
    this.avatar,
    this.url,
    this.isFetch,
    this.skills,
    this.roles,
  });

  LinkedinUserDetailModel.fromObjects({
    required LinkedinUserModel user,
    required ProfileResult profileResult,
  })  : name = user.name,
        avatar = user.avatar,
        url = user.url,
        isFetch = user.isFetch,
        skills = profileResult.skills,
        roles = profileResult.roles;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'avatar': avatar,
      'isFetch': isFetch,
      'url': url,
      'skills': skills,
      'roles': roles,
    };
  }

  factory LinkedinUserDetailModel.fromMap(Map<String, dynamic> map) {
    return LinkedinUserDetailModel(
      name: map['name'] as String,
      avatar: map['avatar'] as String,
      isFetch: map['isFetch'] as bool,
      url: map['url'] as String,
      skills: map['skills'] as List<String>,
      roles: map['roles'],
    );
  }
}
