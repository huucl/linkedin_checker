import 'package:html/parser.dart';

class SkillParser {
  static List<String> getSkills({required String skillHTML}) {
    var document = parse(skillHTML);

    var mainScaffold = document.getElementsByClassName('scaffold-layout__main')[0];

    var skills = mainScaffold.getElementsByClassName('display-flex flex-row justify-space-between');

    List<String> skillNames = [];

    for (var skill in skills) {
      var name = skill.querySelector('span[aria-hidden="true"]')?.text.trim() ?? '';
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
