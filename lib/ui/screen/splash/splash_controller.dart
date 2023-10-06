import 'package:flutter_chrome_app/app_routes.dart';
import 'package:get/get.dart';

import 'splash_binding.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    AppNavigators.gotoLogin();
  }
}
