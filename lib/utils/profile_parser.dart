import 'package:flutter_chrome_app/utils/mock_profile.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

void main() {
  var document = parse(mockProfileHtml);
  document = parse(document.querySelector('.scaffold-finite-scroll__content')?.outerHtml);

  List<Element> experienceBlocks = document.querySelectorAll('.pvs-list__item--line-separated');
  List<Role> roles = [];

  for (var experience in experienceBlocks) {
    roles.addAll(getRoles(experience));
  }


  print(roles.combineRoles());
  // Set<String> setRoles = Set<String>.from(roles);
}

ProfileResult parseExperiences({required String experienceHTML, required String skillHTML}) {
  var document = parse(experienceHTML);
  document = parse(document.querySelector('.scaffold-finite-scroll__content')?.outerHtml);
  var skills = getSkills(skillHTML: skillHTML);
// Get all experience elements
  List<Element> experienceBlocks = document.querySelectorAll('.pvs-list__item--line-separated');
  List<Role> roles = [];
// Loop through each experience
  for (var experience in experienceBlocks) {
    roles.addAll(getRoles(experience));
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

List<Role> getRoles(Element element) {
  List<Element> roleElements = element.querySelectorAll('.t-bold');

  List<Element> durationElements = element.querySelectorAll('.t-14.t-normal.t-black--light > span[aria-hidden="true"]');

  List<Role> roles = [];

  List<String> durationString = durationElements.map((element) => element.text.trim()).toList();

  durationString.removeWhere((element) => element.isDuration() == false);

  for (int i = 0; i < durationString.length; i++) {
    int length = roleElements.length; // Role elements length
    int currentIndex = length - durationString.length + i; // Current index of role element
    Role roleDetails = Role(roleElements[currentIndex].querySelector('span[aria-hidden="true"]')?.text ?? 'NULL',
        DurationModel.fromString(durationString[i]));
    roles.add(roleDetails);
  }

  return roles;
}

class Role {
  String name;
  DurationModel duration;

  Role(this.name, this.duration);

  @override
  String toString() {
    return 'Role{name: $name, dates: ${duration.year} years ${duration.month} months}}';
  }

  String getTextDisplay() {
    if (duration.year > 1) {
      return '$name - ${duration.year} years ${duration.month} months ${duration.isNew == true ? 'Present' : ''}';
    }
    if (duration.year == 1) {
      return '$name - ${duration.year} year ${duration.isNew == true ? 'Present' : ''}';
    } else {
      return '$name - ${duration.month} months ${duration.isNew == true ? 'Present' : ''}';
    }
    return '${duration.year} years ${duration.month} months';
  }
}

class DurationModel {
  int year;
  int month;
  bool? isNew;

  DurationModel({
    required this.year,
    required this.month,
    this.isNew,
  });

  //parser
  DurationModel.fromString(String duration)
      : year = 0,
        month = 0,
        isNew = false {
    if (duration.contains('Present')) {
      isNew = true;
    } else {
      isNew = false;
    }
    duration = duration.split(' · ')[1];
    if (duration.contains('yr')) {
      year = int.parse(duration.split('yr')[0].trim());
      if (duration.contains('yrs')) {
        duration = duration.split('yrs')[1];
      } else {
        duration = duration.split('yr')[1];
      }
    }
    if (duration.contains('mos')) {
      month = int.parse(duration.split('mo')[0].trim());
    }
  }
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

extension StringExtension on String {
  bool isDuration() {
    return contains('mos') || contains('yr');
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

      return Role(name, DurationModel(year: totalYears,month:totalMonths , isNew: isNew));
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
}
