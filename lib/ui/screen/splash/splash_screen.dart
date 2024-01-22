import 'package:flutter/material.dart';
import 'package:flutter_chrome_app/app_routes.dart';
import 'package:get/get.dart';

import 'splash_controller.dart';

class SplashScreen extends GetWidget<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) return const Center(child: CircularProgressIndicator());
      return Stack(
        children: [
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    AppNavigators.gotoHome();
                  },
                  child: const Text(
                    'START CHECKING',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    AppNavigators.gotoGoogleSearch();
                  },
                  child: const Text(
                    'FETCH GOOGLE SEARCH',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    controller.gotoAddCandidate();
                  },
                  child: const Text(
                    'GO TO SAVED PROFILE',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          //version 1.1.0
          const Positioned(
            bottom: 10,
            right: 10,
            child: Text(
              'Version 1.1.4',
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      );
    });
  }
}
