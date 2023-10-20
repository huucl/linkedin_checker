import 'package:flutter_chrome_app/linkedin_user_model.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

String getProfileUrl(String url) {
  int i = url.indexOf('?');
  url = url.substring(0, i);
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

        var location = _getLocation(element);
        users.add(
          LinkedinUserModel(
            name: name ?? '',
            avatar: avatar ?? '',
            url: getProfileUrl(link ?? ''),
            location: location ?? '',
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

  static String? _getLocation(Element element) {
    String? result = '';

    try {
      result = element.getElementsByClassName("entity-result__secondary-subtitle")[0].text.trim();
    } on Exception catch (e) {
      result = "k co LOCATION";
    }
    return result;
  }
}

class UserProfileParser {
  static LinkedinUserModel userParser(String htmlString,String url) {

    var document = parse(htmlString);
    Element contentBlock = document.getElementsByClassName('artdeco-card ember-view pv-top-card').first;

    // Extract the avatar URL
    final Element? avatarImg = contentBlock.querySelector('.pv-top-card-profile-picture__image');
    final String? avatarUrl = avatarImg?.attributes['src'];

    // Extract the name
    final Element? nameElement = contentBlock.querySelector('.text-heading-xlarge');
    final String? name = nameElement?.text;

    // Extract the location
    final Element? locationElement = contentBlock.querySelector('.text-body-small.inline.t-black--light.break-words');
    final String? location = locationElement?.text.trim();

    return LinkedinUserModel(
      name: name ?? 'NULL',
      avatar: avatarUrl ?? '',
      url: url.substring(0,url.length-1),
      location: location ?? '',
    );
  }
}
