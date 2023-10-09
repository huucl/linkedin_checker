import 'package:get/get.dart';

import 'log_info_controller.dart';

class LogInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LogInfoController());
  }
}
