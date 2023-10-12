import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'log_info_controller.dart';

class LogInfoScreen extends GetWidget<LogInfoController> {
  const LogInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Info'),
        actions: [
          IconButton(
            onPressed: () {
              controller.copyToClipboard();
            },
            icon: const Icon(Icons.copy),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Obx(() {
            return SelectableText(controller.textDisplay.value);
          }),
        ),
      ),
    );
  }
}
