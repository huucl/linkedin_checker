import 'package:flutter_chrome_app/app_routes.dart';
import 'package:flutter_chrome_app/domain/repository/auth_repository.dart';
import 'package:flutter_chrome_app/utils/pref_util/pref_util.dart';
import 'package:get/get.dart';


class SplashController extends GetxController {
  final AuthRepository _authRepository;

  SplashController(this._authRepository);

  @override
  void onInit() {
    super.onInit();
    if (PrefUtils().accessToken.isNotEmpty) {
      try {
        _authRepository.checkToken();
        AppNavigators.gotoHome();
      } catch (_) {
        AppNavigators.gotoLogin();
      }
    }

  }
}
