import 'package:flutter_chrome_app/model/role.dart';
import 'package:flutter_chrome_app/utils/parser/role_parser.dart';
import 'package:flutter_chrome_app/utils/string_extension.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

import 'mock_data.dart';

void main() {
  //check user parser
  try {
    var document = parse(mockRoles);
    List<Element> experienceBlocks = document.querySelectorAll('.pvs-list__item--line-separated');
    List<Role> roles = [];
// Loop through each experience
    for (var experience in experienceBlocks) {
      var role = RoleParser.getRoles(experience);
      roles.addAll(role);
    }
  } catch (e) {
    print(e);
  }
}






