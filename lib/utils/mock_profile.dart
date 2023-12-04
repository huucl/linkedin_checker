import 'package:flutter_chrome_app/user_parser.dart';

import 'mock_data.dart';

void main(){
  //check user parser
  try {
    var user = UserProfileParser.userParser(mockData, 'https://www.linkedin.com/in/huu-hoang-63240a103/');
    print(user);
  } catch (e) {
    print(e);
  }
}