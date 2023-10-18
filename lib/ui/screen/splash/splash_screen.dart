import 'package:flutter/material.dart';
import 'package:flutter_chrome_app/app_routes.dart';
import 'package:get/get.dart';

import 'splash_controller.dart';

class SplashScreen extends GetWidget<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {
            AppNavigators.gotoHome();
          },
          child: const Text('START CHECKING',style: TextStyle(fontSize: 20),),
        ),
        TextButton(
          onPressed: () {
            controller.gotoAddCandidate();
          },
          child: const Text('GO TO SAVED PROFILE',style: TextStyle(fontSize: 20),),
        ),
      ],
    );
  }
}
