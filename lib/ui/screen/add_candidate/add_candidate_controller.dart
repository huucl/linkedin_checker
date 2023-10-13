import 'package:flutter/cupertino.dart';
import 'package:flutter_chrome_app/linkedin_user_detail_model.dart';
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
    roles.value = user.value.roles?.map((e) => Role(role: e, yoe: 1)).toList() ?? [];
  }

  void addCandidate() {}
}

class Role {
  String role;
  int yoe;

  Role({
    required this.role,
    required this.yoe,
  });

  String getTextDisplay(){
    if (yoe > 1 ) {
      return '$role - $yoe years';
    } else {
      return '$role - $yoe year';
    }
  }
}