import 'package:flutter_chrome_app/linkedin_user_model.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

class UserParser {
  static List<LinkedinUserModel> bem(String htmlString) {
    var html = parse(htmlString);

    var items = html.getElementsByClassName("entity-result__item");

    List<LinkedinUserModel> users = [];
    for (int i = 0; i < items.length; i++) {
      try {
        var element = items[i];
        var avatar = _getAvvat(element);

        var name = _getName(element);

        var link = _getLink(element);
        users.add(LinkedinUserModel(
            name: name ?? '', avatar: avatar ?? '', url: link ?? ''));
      } catch (e) {
        continue;
      }
    }
    return users;
  }

  static String? _getLink(Element element) {
    String? result = '';

    try {
      result = element
          .getElementsByClassName("entity-result__universal-image")[0]
          .getElementsByClassName("app-aware-link")[0]
          .attributes['href'];
    } on Exception catch (e) {
      result = "k co LINK";
    }
    return result;
  }

  static String? _getName(Element element) {
    String? result = '';

    try {
      result =  element
          .getElementsByClassName("entity-result__universal-image")[0]
          .getElementsByClassName("app-aware-link")[0]
          .getElementsByTagName("img")[0]
          .attributes['alt'];
    } on Exception catch (e) {
      result=  "KO CO _getName";
    }
    return result;
  }

  static String? _getAvvat(Element element) {
    String? result = '';
    try {
      result =  element
          .getElementsByClassName("entity-result__universal-image")[0]
          .getElementsByClassName("app-aware-link")[0]
          .getElementsByTagName("img")[0]
          .attributes['src'];
      if (element.getElementsByClassName("entity-result__universal-image").isEmpty == true
      || element
              .getElementsByClassName("entity-result__universal-image")[0]
              .getElementsByClassName("app-aware-link").isEmpty == true
      || element
              .getElementsByClassName("entity-result__universal-image")[0]
              .getElementsByClassName("app-aware-link")[0]
              .getElementsByTagName("img").isEmpty == true
      || element
              .getElementsByClassName("entity-result__universal-image")[0]
              .getElementsByClassName("app-aware-link")[0]
              .getElementsByTagName("img")[0].attributes.isEmpty
      ){
        return "KO CO";
      }
    } catch (e) {
      result = "KO CO _getAvvat";
    }
    return result;
  }
}
