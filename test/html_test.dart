import 'package:flutter_chrome_app/linkedin_user_model.dart';
import 'package:flutter_chrome_app/mock.dart';
import 'package:flutter_chrome_app/profile_parser.dart';
import 'package:flutter_chrome_app/utils/mock_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

main() {
  _testList();
  // _testProfile();
}

void _testProfile() {
  var html = ProfileParser.bem(mockProfileHtml);
  var name = html.getElementsByClassName("pv-text-details__title")[0].getElementsByTagName("h1")[0].text;
  print("✅ name: $name");

  var jobTitle = html
      .getElementsByClassName("artdeco-list__item pvs-list__item--line-separated pvs-list__item--one-column")[0]
      .getElementsByClassName("display-flex flex-row justify-space-between")[0]
      .getElementsByClassName("visually-hidden")[0]
      .text;

  print("✅ jobTitle: $jobTitle");

  var companyNameAndContractType = html
      .getElementsByClassName("artdeco-list__item pvs-list__item--line-separated pvs-list__item--one-column")[0]
      .getElementsByClassName("display-flex flex-row justify-space-between")[0]
      .getElementsByClassName("visually-hidden")[1]
      .text;
  print("✅ companyNameAndContractType: $companyNameAndContractType");

  var thoigianlamviec = html
      .getElementsByClassName("artdeco-list__item pvs-list__item--line-separated pvs-list__item--one-column")[0]
      .getElementsByClassName("display-flex flex-row justify-space-between")[0]
      .getElementsByClassName("visually-hidden")[2]
      .text;
  print("✅ thoigianlamviec: $thoigianlamviec");

  ///FIXME: remove break line tag
  var skills = html
      .getElementsByClassName("artdeco-list__item pvs-list__item--line-separated pvs-list__item--one-column")[0]
      .getElementsByClassName("inline-show-more-text")[0]
      .text;

  print("✅ skills: $skills");
}

void _testList() {
  var html = parse(theHtmlString);

  var items = html.getElementsByClassName("entity-result__item");
  String getProfileUrl(String url) {
    int i = url.indexOf('?');
    url = url.substring(0, i + 1);
    url = url.replaceAll('?', '/');
    return url;
  }

  List<LinkedinUserModel> users = [];
  for (int i = 0; i < items.length; i++) {
    try {
      var element = items[i];
      var avatar = _getAvvat(element);

      var name = _getName(element);

      var link = _getLink(element);

      var location = _getLocation(element);
      users.add(LinkedinUserModel(
        name: name ?? '',
        avatar: avatar ?? '',
        url: getProfileUrl(link ?? ''),
        location: location ?? '',
      ));
    } catch (e) {
      continue;
    }
  }
  // items.forEach((element) {
  // try{
  //  var avatar = _getAvvat(element);
  //
  //  var name = _getName(element);
  //
  //  var link = _getLink(element);
  //  print("name: $name");
  // }catch(e){
  //  print("LOI CMNR: ${e.toString()}");
  // }
  //
  //   // users.add(LinkedinUserModel(name: name ?? 'nullX', avatar: avatar ?? 'nullX', url: link ?? 'nullX'));
  // });

  print("users ${users.length}");
  users.map((e) => e.url).join(',');

  expect(users.length, 9);
}

String? _getLocation(Element element) {
  String? result = '';

  try {
    result = element.getElementsByClassName("entity-result__secondary-subtitle")[0].text;
  } on Exception catch (e) {
    result = "k co LOCATION";
  }
  return result;
}

String? _getLink(Element element) {
  try {
    return element
        .getElementsByClassName("entity-result__universal-image")[0]
        .getElementsByClassName("app-aware-link")[0]
        .attributes['href'];
  } on Exception catch (e) {
    return "KO CO _getLink";
  }
}

String? _getName(Element element) {
  try {
    return element
        .getElementsByClassName("entity-result__universal-image")[0]
        .getElementsByClassName("app-aware-link")[0]
        .getElementsByTagName("img")[0]
        ?.attributes['alt'];
  } on Exception catch (e) {
    return "KO CO _getName";
  }
}

String? _getAvvat(Element element) {
  try {
    return element
        .getElementsByClassName("entity-result__universal-image")[0]
        .getElementsByClassName("app-aware-link")[0]
        .getElementsByTagName("img")[0]
        ?.attributes['src'];
  } catch (e) {
    return "KO CO _getAvvat";
  }
}
