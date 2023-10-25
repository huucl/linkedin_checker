import 'package:flutter_chrome_app/app_routes.dart';
import 'package:html/parser.dart';

class GoogleSearchParser {
  static List<String> getLinkedinUrls(String doc) {
    final document = parse(doc);

    final contentBlock = document.querySelector('.eqAnXb');
    final bottomBlock = document.querySelector('.sdjuGf');
    final links = contentBlock?.querySelectorAll('a') ?? [];
    final bottomLinks = bottomBlock?.querySelectorAll('a') ?? [];

    links.addAll(bottomLinks);
    final linkedinUrls = <String>[];
    for (final link in links) {
      final href = link.attributes['href'];
      if (href!.contains('linkedin.com/in/')) {
        var temp = href.replaceFirst("https://vn.", "https://");
        temp.replaceFirst('?trk=public_profile_browsemap', '');
        linkedinUrls.add(temp);
      }
    }
    return linkedinUrls;
  }
}
