import 'package:flutter_chrome_app/mock.dart';
import 'package:flutter_chrome_app/user_parser.dart';
import 'package:html/parser.dart';


void main() {
  //check user parser
  try {
    var document = parse(theHtmlString);
    var users = UserParser.bem(theHtmlString);
    print(users);

  } catch (e) {
    print(e);
  }
}






