import 'package:get/get.dart';

import 'add_candidate_controller.dart';

class AddCandidateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddCandidateController());
  }
}
