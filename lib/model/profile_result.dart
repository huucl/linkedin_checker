import 'package:flutter_chrome_app/model/role.dart';

class ProfileResult {
  List<String> skills;
  List<Role> roles;

  ProfileResult(this.skills, this.roles);

  @override
  String toString() {
    return 'SKILLS:\n ・ ${skills.join('\n ・ ')}\n ROLES:\n ・ ${roles.join('\n ・ ')}';
  }
}