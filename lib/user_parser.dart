import 'package:flutter_chrome_app/linkedin_user_model.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

String getProfileUrl(String url) {
  int i = url.indexOf('?');
  url = url.substring(0, i + 1);
  url = url.replaceAll('?', '/');
  return url;
}

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
        users.add(
          LinkedinUserModel(
            name: name ?? '',
            avatar: avatar ?? '',
            url: getProfileUrl(link ?? ''),
          ),
        );
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
      if (element
              .getElementsByClassName("entity-result__universal-image")[0]
              .getElementsByClassName("app-aware-link")[0]
              .getElementsByTagName("img")
              .isEmpty ==
          true) {
        result = element
            .getElementsByClassName("entity-result__universal-image")[0]
            .getElementsByClassName("app-aware-link")[0]
            .getElementsByClassName("visually-hidden")[0]
            .text;
      } else {
        result = element
            .getElementsByClassName("entity-result__universal-image")[0]
            .getElementsByClassName("app-aware-link")[0]
            .getElementsByTagName("img")[0]
            .attributes['alt'];
      }
    } on Exception catch (e) {
      result = "KO CO _getName";
    }
    return result;
  }

  static String? _getAvvat(Element element) {
    String? result =
        'https://media.licdn.com/dms/image/D4D0BAQH4TwiyEOT6Vg/company-logo_200_200/0/1686631084785?e=1704326400&v=beta&t=zkc8S6unhad3pfO2b34ilM5OFQsOQsg0spZSC_7ibPQ';
    try {
      if (element.getElementsByClassName("entity-result__universal-image").isEmpty == true ||
          element
                  .getElementsByClassName("entity-result__universal-image")[0]
                  .getElementsByClassName("app-aware-link")
                  .isEmpty ==
              true ||
          element
                  .getElementsByClassName("entity-result__universal-image")[0]
                  .getElementsByClassName("app-aware-link")[0]
                  .getElementsByTagName("img")
                  .isEmpty ==
              true ||
          element
              .getElementsByClassName("entity-result__universal-image")[0]
              .getElementsByClassName("app-aware-link")[0]
              .getElementsByTagName("img")[0]
              .attributes
              .isEmpty) {
        return "https://media.licdn.com/dms/image/D4D0BAQH4TwiyEOT6Vg/company-logo_200_200/0/1686631084785?e=1704326400&v=beta&t=zkc8S6unhad3pfO2b34ilM5OFQsOQsg0spZSC_7ibPQ";
      } else {
        result = element
            .getElementsByClassName("entity-result__universal-image")[0]
            .getElementsByClassName("app-aware-link")[0]
            .getElementsByTagName("img")[0]
            .attributes['src'];
      }
    } catch (e) {
      result =
          "https://media.licdn.com/dms/image/D4D0BAQH4TwiyEOT6Vg/company-logo_200_200/0/1686631084785?e=1704326400&v=beta&t=zkc8S6unhad3pfO2b34ilM5OFQsOQsg0spZSC_7ibPQ";
    }
    return result;
  }
}
