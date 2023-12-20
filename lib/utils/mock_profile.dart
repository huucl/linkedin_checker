import 'package:flutter_chrome_app/model/role.dart';
import 'package:flutter_chrome_app/utils/parser/education_parser.dart';
import 'package:flutter_chrome_app/utils/parser/role_parser.dart';
import 'package:flutter_chrome_app/utils/parser/skill_parser.dart';
import 'package:flutter_chrome_app/utils/string_extension.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

import 'mock_data.dart';

void main() {
  //check user parser
  try {
    var document = parse(mockData);
    var skills = EducationParser.parseEducations(educationHTML: mockData);
    // skills.forEach((element) {
    //   print(element);
    //   print('-------------------');
    // });

  } catch (e) {
    print(e);
  }
}






