import 'package:flutter_chrome_app/model/profile_result.dart';
import 'package:flutter_chrome_app/utils/experience_parser.dart';
import 'package:html/parser.dart';

ProfileResult parseExperiences({required String experienceHTML, required String skillHTML}) {
  var skills = SkillParser.getSkills(skillHTML: skillHTML);
  var roles = ExperienceParser.parseRoles(html: experienceHTML);

  return (ProfileResult(skills, roles));
}

class SkillParser {
  static List<String> getSkills({required String skillHTML}) {
    var document = parse(skillHTML);

    var skills = document.getElementsByClassName('display-flex flex-row justify-space-between');

    List<String> skillNames = [];

    for (var skill in skills) {
      var name = skill.text.trim();
      name = name.trim();
      if (!skillNames.contains(name)) {
        skillNames.add(name);
      }
    }

    return skillNames;
  }
}

extension StringExtension on String {
  bool isDuration() {
    return contains('mos') || contains('yr');
  }
}
