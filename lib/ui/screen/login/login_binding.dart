import 'package:flutter_chrome_app/data/repository/auth_repository_impl.dart';
import 'package:flutter_chrome_app/domain/repository/auth_repository.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl());
    Get.lazyPut(() => LoginController(Get.find()));
  }
}
