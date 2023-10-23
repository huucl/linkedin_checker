import 'dart:convert';
import 'package:flutter_chrome_app/data/client/network_client.dart';
import 'package:flutter_chrome_app/domain/repository/linked_check_repository.dart';
import 'package:flutter_chrome_app/model/candidate_input.dart';
import 'package:flutter_chrome_app/model/linked_check_response.dart';
import 'package:flutter_chrome_app/model/location_model.dart';
import 'package:flutter_chrome_app/model/search_item.dart';
import 'package:get/get.dart';

class LinkedCheckRepositoryImpl implements LinkedCheckRepository {
  final _client = Get.find<HTTPProvider>();

  @override
  Future<List<LinkedCheckResponse>> checkLinkedinExistence(List<String> urls) async {
    var queryParam = urls.map((e) => 'urls=$e').join('&');
    print('QUERY: $queryParam');
    try {
      var res = await _client.makeGet('/users/check-linkedin?$queryParam');
      return linkedCheckResponseFromMap(jsonEncode(res));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addNewCandidate(List<Candidate> candidates) async {
    var data = candidates.map((e) => e.toMap().removeNull()).toList();
    try {
      await _client.makePost('/candidates', data: data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<SearchItem>> getRoles() async {
    try {
      var res = await _client.makeGet('/role-experiences');
      return searchItemFromMap(jsonEncode(res));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<SearchItem>> getSkills() async {
    try {
      var res = await _client.makeGet('/skills');
      return searchItemFromMap(jsonEncode(res));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<LocationModel>> getLocations() async {
    try {
      var res = await _client.makeGet('/locations');
      return locationFromMap(jsonEncode(res));
    } catch (e) {
      rethrow;
    }
  }
}
