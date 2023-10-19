import 'dart:convert';

import 'package:flutter_chrome_app/app_routes.dart';
import 'package:flutter_chrome_app/domain/repository/auth_repository.dart';
import 'package:flutter_chrome_app/linkedin_user_detail_model.dart';
import 'package:flutter_chrome_app/utils/pref_util/pref_util.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final AuthRepository _authRepository;

  SplashController(this._authRepository);
  RxBool isLoading = false.obs;

  @override
  void onReady() async {
    super.onReady();
    isLoading.value = true;
    if (PrefUtils().accessToken.isNotEmpty) {
      try {
        await _authRepository.checkToken();
        // if (PrefUtils().candidateObject != '') {
        //   gotoAddCandidate();
        // } else {
        //   AppNavigators.gotoHome();
        // }
      } catch (_) {
        AppNavigators.gotoLogin();
      }
    } else {
      AppNavigators.gotoLogin();
    }
    isLoading.value = false;
  }

  void gotoAddCandidate() {
    var localData = PrefUtils().candidateObject;
    var user = LinkedinUserDetailModel.fromMap(jsonDecode(localData) as Map<String, dynamic>);
    AppNavigators.gotoAddCandidate(user: user);
  }
}
