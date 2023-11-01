import 'package:html/dom.dart';
import 'package:html/parser.dart';

class GoogleSearchParser {
  static List<GoogleResultItem> getLinkedinUrls(String doc) {
    final document = parse(doc);

    final blocks = document.querySelectorAll('.MjjYud');

    List<Element> links = [];

    for (var element in blocks) {
      var items = element.querySelectorAll('a').toList();
      links.addAll(items);
    }

    final linkedinUrls = <GoogleResultItem>[];
    for (final link in links) {
      final href = link.attributes['href'];
      if (href != null && href.contains('linkedin.com/in/')) {
        var temp = href.replaceFirst("https://vn.", "https://www.");
        temp.contains('?trk=public_profile')
            ? temp = temp.substring(0, temp.indexOf('?trk=public_profile'))
            : temp = temp;
        linkedinUrls.add(GoogleResultItem(title: link.text.getName(), url: temp));
      }
    }
    return linkedinUrls;
  }
}

class GoogleResultItem {
  final String title;
  final String url;

  GoogleResultItem({
    required this.title,
    required this.url,
  });
}

extension on String {
  String getName() {
    try {
      var index1 = indexOf('-');
      var index2 = toLowerCase().indexOf('linkedin');
      var name = index1 > index2 ? substring(0, index2) : substring(0, index1);
      return name;
    } catch (e) {
      return this;
    }
  }
}
