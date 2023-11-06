import 'package:flutter_chrome_app/utils/google_search_parser.dart';
import 'package:flutter_chrome_app/utils/mock_data.dart';
import 'package:html/parser.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

void main() {
  var jwt = JwtDecoder.decode(accessToken);
  print(jwt['id']);
}

