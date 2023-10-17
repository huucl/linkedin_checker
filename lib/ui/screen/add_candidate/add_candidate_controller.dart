import 'package:flutter/cupertino.dart';
import 'package:flutter_chrome_app/app_routes.dart';
import 'package:flutter_chrome_app/domain/repository/linked_check_repository.dart';
import 'package:flutter_chrome_app/linkedin_user_detail_model.dart';
import 'package:flutter_chrome_app/model/candidate_input.dart';
import 'package:flutter_chrome_app/model/search_item.dart';
import 'package:flutter_chrome_app/ui/screen/home/home_controller.dart';
import 'package:flutter_chrome_app/utils/profile_parser.dart';
import 'package:get/get.dart';

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
  final TextEditingController addressController = TextEditingController();
  final TextEditingController workExperience = TextEditingController();
  final TextEditingController yearExperience = TextEditingController();
  final TextEditingController skill = TextEditingController();

  RxList<String> skills = <String>[].obs;
  RxList<Role> roles = <Role>[].obs;
  Candidate candidate = Candidate();

  List<SearchItem> searchSkills = [];
  List<SearchItem> searchRoles = [];

  bool isEdit = false;

  @override
  void onInit() {
    super.onInit();
    user.value = Get.arguments;
    initData();
    fetchItems();
  }

  void fetchItems() {
    _linkedCheckRepository.getSkills().then((value) {
      searchSkills = value;
    });
    _linkedCheckRepository.getRoles().then((value) {
      searchRoles = value;
    });
  }

  void initData() {
    firstNameController.text = user.value.name!.split(' ')[0];
    lastNameController.text = user.value.name!.split(' ')[1];
    linkedinUrl.text = user.value.url!;
    addressController.text = user.value.address ?? '';
    skills.value = user.value.skills ?? [];
    roles.value = user.value.roles ?? [];
  }

  void mapCandidate() {
    candidate = Candidate(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      linkedin: linkedinUrl.text,
      email: emailController.text,
      phoneCode: phoneCodeController.text,
      phoneNumber: phoneController.text,
      address: addressController.text,
      skills: skills.toSkills(searchSkills),
      avatar: user.value.avatar,
      workExperiences: roles.toWorkExperiences(searchRoles),
    );
  }

  void addCandidate() async {
    mapCandidate();
    try {
      await _linkedCheckRepository.addNewCandidate([candidate]);
      var homeController = Get.find<HomeController>();
      homeController.users.where((p0) => p0.url == user.value.url).first.isFetch = true;
      homeController.users.refresh();
      Get.back();
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
