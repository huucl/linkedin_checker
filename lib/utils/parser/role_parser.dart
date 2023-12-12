import 'package:flutter_chrome_app/model/duration_model.dart';
import 'package:flutter_chrome_app/model/role.dart';
import 'package:flutter_chrome_app/utils/string_extension.dart';
import 'package:html/dom.dart';

class RoleParser {
  static List<Role> getRoles(Element element) {
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
}