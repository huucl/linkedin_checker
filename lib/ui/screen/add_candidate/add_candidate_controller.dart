import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chrome_app/app_routes.dart';
import 'package:flutter_chrome_app/domain/repository/linked_check_repository.dart';
import 'package:flutter_chrome_app/linkedin_user_detail_model.dart';
import 'package:flutter_chrome_app/model/candidate_input.dart';
import 'package:flutter_chrome_app/model/education_model.dart';
import 'package:flutter_chrome_app/model/location_model.dart';
import 'package:flutter_chrome_app/model/role.dart';
import 'package:flutter_chrome_app/model/search_item.dart';
import 'package:flutter_chrome_app/utils/pref_util/pref_util.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:searchfield/searchfield.dart';

class AddCandidateController extends GetxController {
  final LinkedCheckRepository _linkedCheckRepository;

  AddCandidateController(this._linkedCheckRepository);

  Rx<LinkedinUserDetailModel> user = LinkedinUserDetailModel().obs;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController linkedinUrl = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController phoneCodeController = TextEditingController(text: '+84');
  final TextEditingController locationController = TextEditingController();
  final TextEditingController jobTitle = TextEditingController();
  final TextEditingController companyName = TextEditingController();
  final TextEditingController institution = TextEditingController();
  final TextEditingController degree = TextEditingController();
  final TextEditingController fromYear = TextEditingController();
  final TextEditingController fromMonth = TextEditingController();
  final TextEditingController toYear = TextEditingController();
  final TextEditingController toMonth = TextEditingController();
  final TextEditingController skill = TextEditingController();

  final TextEditingController fromYearEdu = TextEditingController();
  final TextEditingController fromMonthEdu = TextEditingController();
  final TextEditingController toYearEdu = TextEditingController();
  final TextEditingController toMonthEdu = TextEditingController();

  RxList<String> skills = <String>[].obs;
  RxList<Role> roles = <Role>[].obs;
  RxList<EducationModel> educations = <EducationModel>[].obs;
  Candidate candidate = Candidate();

  List<SearchItem> searchSkills = [];
  List<SearchItem> searchRoles = [];

  RxList<SearchFieldListItem> searchFieldListSkills = <SearchFieldListItem>[].obs;
  RxList<SearchFieldListItem> searchFieldListRoles = <SearchFieldListItem>[].obs;

  List<LocationModel> locations = [];
  RxList<DropdownMenuItem<LocationModel>> locationItems = <DropdownMenuItem<LocationModel>>[].obs;

  bool isEdit = false;
  bool isEditEdu = false;
  Rxn<LocationModel> matchLocation = Rxn<LocationModel>();

  String? assigneeId;

  @override
  void onInit() {
    super.onInit();
    user.value = Get.arguments;
    initData();
    fetchItems();
    getAssigneeId();
  }

  void getAssigneeId() {
    try {
      assigneeId = JwtDecoder.decode(PrefUtils().accessToken)['id'];
    } catch (_) {}
  }

  void fetchItems() {
    _linkedCheckRepository.getSkills().then((value) {
      searchSkills = value;
      searchFieldListSkills.value = searchSkills
          .map(
            (e) => SearchFieldListItem(
              e.label ?? UniqueKey().toString(),
              child: Text(e.label ?? ''),
            ),
          )
          .toList();
      searchFieldListSkills.refresh();
    });
    _linkedCheckRepository.getRoles().then((value) {
      searchRoles = value;
      searchFieldListRoles.value = searchRoles
          .map(
            (e) => SearchFieldListItem(
              e.label ?? UniqueKey().toString(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(e.label ?? ''),
              ),
            ),
          )
          .toList();
      searchFieldListRoles.refresh();
    });
    _linkedCheckRepository.getLocations().then((value) {
      locations = value;
      locationItems.value = locations
          .map(
            (e) => DropdownMenuItem<LocationModel>(
              value: e,
              child: Text(e.label ?? ''),
            ),
          )
          .toList();
      locationItems.add(DropdownMenuItem<LocationModel>(value: LocationModel(), child: const Text('Other')));
      locationItems.refresh();
      matchLocation.value = locations.firstWhereOrNull((element) =>
              user.value.address?.toUpperCase().contains(element.label?.toUpperCase() ?? UniqueKey().toString()) ??
              false) ??
          LocationModel();
    });
  }

  void initData() {
    var index = user.value.name!.lastIndexOf(' ');
    firstNameController.text = user.value.name!.substring(0, index);
    lastNameController.text = user.value.name!.substring(index + 1);
    linkedinUrl.text = user.value.url!;
    emailController.text = user.value.email ?? '';
    phoneController.text = user.value.phoneNumber ?? '';
    phoneCodeController.text = user.value.phoneCode ?? '';
    locationController.text = user.value.address ?? '';
    skills.value = user.value.skills ?? [];
    roles.value = user.value.roles ?? [];
    educations.value = user.value.educations ?? [];
  }

  void mapCandidate() {
    candidate = Candidate(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      linkedin: linkedinUrl.text,
      email: emailController.text,
      phoneCode: phoneCodeController.text,
      phoneNumber: phoneController.text,
      locationId: matchLocation.value?.id,
      skills: skills.toSkills(searchSkills),
      assigneeId: assigneeId,
      avatar: user.value.avatar,
      workExperiences: roles.toWorkExperience(),
      educations: educations,
    );
  }

  void addCandidate() async {
    mapCandidate();
    PrefUtils().candidateObject = '';
    try {
      await _linkedCheckRepository.addNewCandidate([candidate]);
      Get.back();
    } catch (e) {
      AppNavigators.gotoLogInfo(e.toString());
    }
  }

  void saveToSharePref() {
    try {
      LinkedinUserDetailModel savedUser = LinkedinUserDetailModel(
        name: '${firstNameController.text} ${lastNameController.text}',
        avatar: user.value.avatar,
        isFetch: user.value.isFetch,
        url: linkedinUrl.text,
        skills: skills,
        email: emailController.text,
        address: matchLocation.value != LocationModel() ? matchLocation.value!.label : null,
        roles: roles,
        phoneNumber: phoneController.text,
        phoneCode: phoneCodeController.text,
        educations: educations,
      );

      String encryptData = jsonEncode(savedUser.toMap());
      PrefUtils().candidateObject = encryptData;
    } catch (e) {
      AppNavigators.gotoLogInfo(e.toString());
    }
  }
}

extension SkillsExtension on List<String> {
  Skills toSkills(List<SearchItem> havingSkills) {
    var newSkills = <String>[];
    var skillIds = <String>[];
    for (var skill in this) {
      var searchItem = havingSkills.firstWhereOrNull((element) => element.label?.toUpperCase() == skill.toUpperCase());
      if (searchItem != null) {
        skillIds.add(searchItem.id!);
      } else {
        newSkills.add(skill);
      }
    }
    return Skills(
      newSkills: newSkills,
      skillIds: skillIds,
    );
  }
}
