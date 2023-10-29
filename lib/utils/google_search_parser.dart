import 'package:html/dom.dart';
import 'package:html/parser.dart';

class GoogleSearchParser {
  static List<String> getLinkedinUrls(String doc) {
    final document = parse(doc);

    final blocks = document.querySelectorAll('.MjjYud');

    List<Element> links = [];

    for (var element in blocks) {
      var items = element.querySelectorAll('a').toList();
      links.addAll(items);
    }
    final linkedinUrls = <String>[];
    for (final link in links) {
      final href = link.attributes['href'];
      if (href != null && href.contains('linkedin.com/in/')) {
        var temp = href.replaceFirst("https://vn.", "https://www.");
        temp.contains('?trk=public_profile')
            ? temp = temp.substring(0, temp.indexOf('?trk=public_profile'))
            : temp = temp;
        linkedinUrls.add(temp);
      }
    }
    return linkedinUrls;
  }
}
