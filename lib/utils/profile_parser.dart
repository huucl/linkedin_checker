import 'package:flutter_chrome_app/utils/mock_profile.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

ProfileResult parseExperiences({required String experienceHTML,required String skillHTML}) {
  var document = parse(experienceHTML);
  var skills = getSkills(skillHTML: skillHTML);
// Get all experience elements
  List<Element> experiences = document.querySelectorAll('.pvs-list__item--line-separated');
  List<String> roles = [];
// Loop through each experience
  for (var experience in experiences) {
    roles.addAll(getRoles(experience).map((e) => e.name).toList());
  }

  Set<String> setRoles = Set<String>.from(roles);

  return (ProfileResult(skills, setRoles.toList()));
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

List<Role> getRoles(Element element) {
  List<Element> roleElements = element.querySelectorAll('.t-bold');

  List<Role> roles = [];

  String getDates(Element element) =>
      element.querySelector('.t-black--light > span[aria-hidden="true"]')?.text ?? 'NULL';

  for (var role in roleElements) {
    Role roleDetails = Role(role.querySelector('span[aria-hidden="true"]')?.text ?? 'NULL', getDates(element));

    roles.add(roleDetails);
  }

  int index = 0;

  while (index < roles.length - 1) {
    int temp;
    temp = roles.lastIndexWhere((element) => element.dates == roles[index].dates);
    if (temp != index) {
      roles.removeAt(index);
      index = temp;
    } else {
      index++;
    }
  }

  return roles;
}

class Role {
  String name;
  String dates;

  Role(this.name, this.dates);

  @override
  String toString() {
    return 'Role{name: $name, dates: $dates}';
  }
}

class ProfileResult {
  List<String> skills;
  List<String> roles;

  ProfileResult(this.skills, this.roles);

  @override
  String toString() {
    return 'SKILLS:\n ・ ${skills.join('\n ・ ')}\n ROLES:\n ・ ${roles.join('\n ・ ')}';
  }
}