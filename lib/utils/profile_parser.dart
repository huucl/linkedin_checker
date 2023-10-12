import 'package:html/dom.dart';
import 'package:html/parser.dart';

ProfileResult parseExperiences({required String experienceHTML}) {
  var document = parse(experienceHTML);
// Get all experience elements
  List<Element> experiences = document.querySelectorAll('.pvs-list__item--line-separated');

  List<String> skills = [];
  List<String> roles = [];
// Loop through each experience
  for (var experience in experiences) {
    roles.addAll(getRoles(experience).map((e) => e.name).toList());
    String skill;
    try {
      skill = experience.querySelectorAll('.pvs-list__item--one-column .t-black > span[aria-hidden="true"]').last.text;
      if (skill.startsWith('Skills: ')) {
        skill = skill.substring(8);
      } else {
        skill = '';
      }
    } catch (e) {
      skill = '';
    }

    if (skill != ''){
      List<String> tempSkill = skill.split(' · ');
      skills.addAll(tempSkill);
    }


  }

  Set<String> setSkills = Set<String>.from(skills);
  Set<String> setRoles = Set<String>.from(roles);

  return (ProfileResult(setSkills.toList(), setRoles.toList()));
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
    return 'ProfileResult{skills: $skills, roles: $roles}';
  }
}