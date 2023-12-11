import 'package:flutter_chrome_app/utils/experience_parser.dart';
import 'package:flutter_chrome_app/utils/profile_parser.dart';
import 'mock_data.dart';

void main() {
  try {
    var experiences = SkillParser.getSkills(skillHTML: mockSkills);
    print(experiences);
    // print(user);
  } catch (e) {
    print(e);
  }
}
