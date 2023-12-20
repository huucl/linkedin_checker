import 'package:flutter_chrome_app/model/candidate_input.dart';
import 'package:flutter_chrome_app/model/duration_model.dart';
import 'package:flutter_chrome_app/model/role.dart';
import 'package:flutter_chrome_app/model/search_item.dart';
import 'package:flutter_chrome_app/utils/parser/role_parser.dart';
import 'package:flutter_chrome_app/utils/parser/skill_parser.dart';
import 'package:get/get.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

ProfileResult parseExperiences({required String experienceHTML, required String skillHTML}) {
  var document = parse(experienceHTML);
  var skills = SkillParser.getSkills(skillHTML: skillHTML);
// Get all experience elements
  List<Element> experienceBlocks = document.querySelectorAll('.pvs-list__item--line-separated');
  List<Role> roles = [];
// Loop through each experience
  for (var experience in experienceBlocks) {
    var role = RoleParser.getRoles(experience);

    if (role.length == 1) {
      var companyName = experience.querySelector('.t-14.t-normal  > span[aria-hidden="true"]')?.text.trim().split(' · ').firstOrNull;
      role[0].companyName = companyName ?? '';
    } else {
      var companyName =
          experience.querySelector('.t-bold  > span[aria-hidden="true"]')?.text.trim().split(' · ').firstOrNull;
      for (var element in role) {
        element.companyName = companyName ?? '';
      }
    }

    roles.addAll(role);
  }

  // Set<String> setRoles = Set<String>.from(roles);

  return (ProfileResult(skills, roles));
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
