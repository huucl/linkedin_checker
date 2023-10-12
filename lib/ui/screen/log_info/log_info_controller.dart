import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'log_info_binding.dart';

class LogInfoController extends GetxController {
  RxString textDisplay = ''.obs;

  @override
  void onInit() {
    super.onInit();
    textDisplay.value = Get.arguments;
  }

  void copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: textDisplay.value));
  }
}
