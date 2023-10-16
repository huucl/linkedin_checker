import 'package:flutter_chrome_app/data/repository/auth_repository_impl.dart';
import 'package:flutter_chrome_app/domain/repository/auth_repository.dart';
import 'package:get/get.dart';

import 'splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl());
    Get.lazyPut(() => SplashController(Get.find()));
  }
}
