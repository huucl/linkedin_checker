import 'package:flutter_chrome_app/data/client/network_client.dart';
import 'package:flutter_chrome_app/domain/repository/linked_check_repository.dart';
import 'package:flutter_chrome_app/model/linked_check_response.dart';
import 'package:get/get.dart';

class LinkedCheckRepositoryImpl implements LinkedCheckRepository {
  final _client = Get.find<HTTPProvider>();

  @override
  Future<List<LinkedCheckResponse>> checkLinkedinExistence(List<String> urls) async {
    var queryParam = urls.map((e) => 'urls=$e').join('&');
    try {
      var res = await _client.makeGet('/users/check-linkedin?$queryParam');
      return (res as List).map((e) => LinkedCheckResponse.fromMap(e)).toList();
    } catch (e) {
      return Future.error(e);
    }
  }

}