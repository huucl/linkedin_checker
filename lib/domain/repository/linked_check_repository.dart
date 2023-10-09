import 'package:flutter_chrome_app/model/linked_check_response.dart';

abstract class LinkedCheckRepository {
  Future<List<LinkedCheckResponse>> checkLinkedinExistence(List<String> urls);
}