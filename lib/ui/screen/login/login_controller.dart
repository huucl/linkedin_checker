import 'package:flutter/cupertino.dart';
import 'package:flutter_chrome_app/domain/repository/auth_repository.dart';
import 'package:flutter_chrome_app/model/login_response.dart';
import 'package:flutter_chrome_app/utils/pref_util/pref_util.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final AuthRepository _authRepository;

  LoginController(this._authRepository);

  final TextEditingController emailController = TextEditingController(text: 'admin@gmail.com');
  final TextEditingController passwordController = TextEditingController(text: 'Password12#');

  void login() async {
    try {
      var loginResponse = await _authRepository.login(
        email: emailController.text,
        password: passwordController.text,
      );
      if (loginResponse != LoginResponse()){
        PrefUtils().accessToken = loginResponse.accessToken ?? '';
      }
      print(PrefUtils().accessToken);
    } catch (e) {
      print(e);
    }
  }
}
