import 'package:flutter_chrome_app/model/role.dart';
import 'package:flutter_chrome_app/utils/string_extension.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

class ExperienceParser {
  static List<Role> parseRoles({required String html}) {
    var document = parse(html);
    var scaffold = document.getElementsByClassName('scaffold-layout__main');

    List<Element> experienceBlocks = scaffold.first.querySelectorAll('.pvs-list__item--line-separated');
    List<Role> roles = [];

    for (var experience in experienceBlocks) {
      var role = getRole(experience);
      roles.add(role);
    }

    return roles;
  }

  static Role getRole(Element element) {
    var companyName =
        element.querySelector('.t-14.t-normal span[aria-hidden="true"]')?.text.trim().split(' · ').firstOrNull;

    var title = element.querySelector('span[aria-hidden="true"]')?.text;

    var dates = element.querySelector('.t-14.t-normal.t-black--light')?.text.trim();

    return Role(title: title ?? '', duration: dates?.parseDateRangeForDotted(), companyName: companyName);
  }
}
