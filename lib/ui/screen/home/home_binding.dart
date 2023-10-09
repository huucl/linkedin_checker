import 'package:flutter_chrome_app/data/repository/linked_check_repository_impl.dart';
import 'package:flutter_chrome_app/domain/repository/linked_check_repository.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LinkedCheckRepository>(() => LinkedCheckRepositoryImpl());
    Get.lazyPut(() => HomeController(Get.find()));
  }
}
