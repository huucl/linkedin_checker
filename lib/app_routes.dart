import 'package:flutter_chrome_app/binding.dart';
import 'package:flutter_chrome_app/linkedin_user_detail_model.dart';
import 'package:flutter_chrome_app/main.dart';
import 'package:flutter_chrome_app/ui/screen/add_candidate/add_candidate_binding.dart';
import 'package:flutter_chrome_app/ui/screen/add_candidate/add_candidate_screen.dart';
import 'package:flutter_chrome_app/ui/screen/home/home_binding.dart';
import 'package:flutter_chrome_app/ui/screen/home/home_screen.dart';
import 'package:flutter_chrome_app/ui/screen/log_info/log_info_binding.dart';
import 'package:flutter_chrome_app/ui/screen/log_info/log_info_screen.dart';
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
  GetPage(
    name: AppRoutes.logInfo,
    page: () => const LogInfoScreen(),
    bindings: [LogInfoBinding()],
  ),
  GetPage(
    name: AppRoutes.home,
    page: () => const HomeScreen(),
    bindings: [HomeBinding()],
  ),
  GetPage(
    name: AppRoutes.addCandidate,
    page: () => const AddCandidateScreen(),
    bindings: [AddCandidateBinding()],
  ),

];

class AppRoutes {
  static const splash = '/splash';
  static const login = '/login';
  static const checkSearch = '/checkSearch';
  static const logInfo = '/logInfo';
  static const home = '/home';
  static const addCandidate = '/addCandidate';
}

class AppNavigators {
  static gotoLogin() {
    Get.toNamed(AppRoutes.login);
  }

  static gotoCheckSearch() {
    Get.toNamed(AppRoutes.checkSearch);
  }

  static gotoLogInfo(String text) {
    Get.toNamed(AppRoutes.logInfo, arguments: text);
  }

  static gotoHome() {
    Get.toNamed(AppRoutes.home);
  }

  static gotoAddCandidate({required LinkedinUserDetailModel user}) {
    Get.toNamed(AppRoutes.addCandidate, arguments: user);
  }
}
