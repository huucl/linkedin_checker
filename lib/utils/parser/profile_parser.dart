import 'package:flutter_chrome_app/model/candidate_input.dart';
import 'package:flutter_chrome_app/model/duration_model.dart';
import 'package:flutter_chrome_app/model/role.dart';
import 'package:flutter_chrome_app/model/search_item.dart';
import 'package:flutter_chrome_app/utils/mock_profile.dart';
import 'package:flutter_chrome_app/utils/parser/role_parser.dart';
import 'package:get/get.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

ProfileResult parseExperiences({required String experienceHTML, required String skillHTML}) {
  var document = parse(experienceHTML);
  var skills = getSkills(skillHTML: skillHTML);
// Get all experience elements
  List<Element> experienceBlocks = document.querySelectorAll('.pvs-list__item--line-separated');
  List<Role> roles = [];
// Loop through each experience
  for (var experience in experienceBlocks) {
    roles.addAll(RoleParser.getRoles(experience));
  }

  // Set<String> setRoles = Set<String>.from(roles);

  return (ProfileResult(skills, roles.combineRoles()));
}

List<String> getSkills({required String skillHTML}) {
  var document = parse(skillHTML);

  var skills = document.querySelectorAll('.pvs-entity');

  List<String> skillNames = [];

  for (var skill in skills) {
    var name = skill.querySelector('.hoverable-link-text > span[aria-hidden="true"]')?.text;
    if (name != null) {
      name = name.trim();
      if (!skillNames.contains(name)) {
        skillNames.add(name);
      }
    }
  }

  return skillNames;
}





class ProfileResult {
  List<String> skills;
  List<Role> roles;

  ProfileResult(this.skills, this.roles);

  @override
  String toString() {
    return 'SKILLS:\n ・ ${skills.join('\n ・ ')}\n ROLES:\n ・ ${roles.join('\n ・ ')}';
  }
}


extension RoleExtension on Role {
  Role operator +(Role other) {
    if (name == other.name) {
      // Combine durations for roles with the same name
      int totalYears = duration.year + other.duration.year;
      int totalMonths = duration.month + other.duration.month;
      bool isNew = duration.isNew == true || other.duration.isNew == true;
      // Adjust months if they exceed 12
      if (totalMonths >= 12) {
        totalYears += totalMonths ~/ 12;
        totalMonths %= 12;
      }

      return Role(name, DurationModel(year: totalYears, month: totalMonths, isNew: isNew));
    } else {
      // If roles have different names, return the original role
      return this;
    }
  }
}

extension RoleListExtension on List<Role> {
  List<Role> combineRoles() {
    final Map<String, Role> roleMap = {};

    for (var role in this) {
      if (roleMap.containsKey(role.name)) {
        // Combine roles with the same name using the + operator
        roleMap[role.name] = (roleMap[role.name]!) + role;
      } else {
        roleMap[role.name] = role;
      }
    }

    // Convert the values in the roleMap back to a list
    final List<Role> combinedRoles = roleMap.values.toList();

    return combinedRoles;
  }

  WorkExperiences toWorkExperiences(List<SearchItem> havingRoles) {
    var existRoles = <ExistRoleExperience>[];
    var newRoles = <NewRoleExperience>[];

    for (var role in this) {
      var roleItem = havingRoles.firstWhereOrNull((element) => element.label?.toUpperCase() == role.name.toUpperCase());
      if (roleItem != null) {
        existRoles.add(ExistRoleExperience(roleExperienceId: roleItem.id, yearsOfExperience: role.getYOE()));
      } else {
        newRoles.add(NewRoleExperience(newRoleExperience: role.name, yearsOfExperience: role.getYOE()));
      }
    }

    return WorkExperiences(existRoleExperience: existRoles, newRoleExperience: newRoles);
  }
}