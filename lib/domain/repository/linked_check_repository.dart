import 'package:flutter_chrome_app/model/candidate_input.dart';
import 'package:flutter_chrome_app/model/linked_check_response.dart';
import 'package:flutter_chrome_app/model/search_item.dart';

abstract class LinkedCheckRepository {
  Future<List<LinkedCheckResponse>> checkLinkedinExistence(List<String> urls);

  Future<void> addNewCandidate(List<Candidate> candidates);

  Future<List<SearchItem>> getSkills();

  Future<List<SearchItem>> getRoles();
}