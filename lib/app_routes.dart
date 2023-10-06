import 'package:flutter_chrome_app/binding.dart';
import 'package:flutter_chrome_app/main.dart';
import 'package:flutter_chrome_app/ui/screen/login/login_binding.dart';
import 'package:flutter_chrome_app/ui/screen/login/login_screen.dart';
import 'package:flutter_chrome_app/ui/screen/splash/splash_binding.dart';
import 'package:flutter_chrome_app/ui/screen/splash/splash_screen.dart';
import 'package:get/get.dart';

final routes = [
  GetPage(
    name: AppRoutes.splash,
    page: () => const SplashScreen(),
    bindings: [MainBinding(), SplashBinding()],
  ),
  GetPage(
    name: AppRoutes.login,
    page: () => const LoginScreen(),
    bindings: [LoginBinding()],
  ),
  GetPage(
    name: AppRoutes.checkSearch,
    page: () {
      return const MyHomePage(
        title: '',
      );
    },
    bindings: [LoginBinding()],
  ),
];

class AppRoutes {
  static const splash = '/splash';
  static const login = '/login';
  static const checkSearch = '/checkSearch';
}

class AppNavigators {
  static gotoLogin() {
    Get.toNamed(AppRoutes.login);
  }

  static gotoCheckSearch() {
    Get.toNamed(AppRoutes.checkSearch);
  }
}
