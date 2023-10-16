import 'package:flutter/cupertino.dart';
import 'package:flutter_chrome_app/linkedin_user_detail_model.dart';
import 'package:flutter_chrome_app/ui/screen/home/home_controller.dart';
import 'package:flutter_chrome_app/utils/profile_parser.dart';
import 'package:get/get.dart';

class AddCandidateController extends GetxController {
  Rx<LinkedinUserDetailModel> user = LinkedinUserDetailModel().obs;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController linkedinUrl = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController workExperience = TextEditingController();
  final TextEditingController yearExperience = TextEditingController();
  final TextEditingController skill = TextEditingController();

  RxList<String> skills = <String>[].obs;
  RxList<Role> roles = <Role>[].obs;

  bool isEdit = false;

  @override
  void onInit() {
    super.onInit();
    user.value = Get.arguments;
    initData();
  }

  void initData() {
    firstNameController.text = user.value.name!.split(' ')[0];
    lastNameController.text = user.value.name!.split(' ')[1];
    linkedinUrl.text = user.value.url!;
    skills.value = user.value.skills ?? [];
    roles.value = user.value.roles ?? [];
  }

  void addCandidate() {
    var homeController = Get.find<HomeController>();
    homeController.users.where((p0) => p0.url == user.value.url).first.isFetch = true;
    homeController.users.refresh();
    Get.back();
  }
}

