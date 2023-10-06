import 'package:flutter_chrome_app/utils/pref_util/pref_key.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  static final SharedPreferences _sharedPrefs = Get.find<SharedPreferences>();

  Future<dynamic> init() async {
    await Get.putAsync<SharedPreferences>(() => SharedPreferences.getInstance(), permanent: true);
  }

  String get accessToken => _sharedPrefs.getString(PrefKey.accessToken) ?? '';

  set accessToken(String token) {
    _sharedPrefs.setString(PrefKey.accessToken, token);
  }
}