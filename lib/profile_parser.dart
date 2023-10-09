import 'package:flutter_chrome_app/linkedin_user_model.dart';
import 'package:flutter_chrome_app/utils/mock_profile.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

String getProfileUrl(String url) {
  int i = url.indexOf('?');
  url = url.substring(0, i + 1);
  url = url.replaceAll('?', '/');
  return url;
}

class ProfileParser {
  static Document bem(String htmlString) {
    var html = parse(htmlString);
    return html;
  }
}
