import 'package:flutter_chrome_app/utils/mock_data.dart';
import 'package:html/parser.dart' show parse;

void main() {
  // HTML content

  // Parse HTML
  final document = parse(mockProfileHtml);
  final contentBlock = document.querySelector('.WtZO4e');
  final blocks = contentBlock?.getElementsByClassName('arc-srp_110');
  print(blocks);
  //
  // final block = contentBlock?.querySelector('.WtZO4e');
  // //get all links from block
  // final links = block?.getElementsByClassName('MjjYud');
  // print(links);

 // print(links);


  // final contentBlock = document.querySelector('.eqAnXb');
  // final bottomBlock = document.querySelector('.WtZO4e');
  // final links = contentBlock?.querySelectorAll('a') ?? [];
  // final bottomLinks = bottomBlock?.querySelectorAll('a') ?? [];

  //
  // print(bottomBlock?.innerHtml);
  // print(bottomLinks);

  // links.addAll(bottomLinks);
  // final linkedinUrls = <String>[];
  // for (final link in links) {
  //   final href = link.attributes['href'];
  //   if (href != null && href.contains('linkedin.com/in/')) {
  //     var temp = href.replaceFirst("https://vn.", "https://");
  //     temp.replaceFirst('?trk=public_profile_browsemap', '');
  //     linkedinUrls.add(temp);
  //   }
  // }

  // Print results
  // print(linkedinUrls);
}