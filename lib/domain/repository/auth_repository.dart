import 'package:flutter_chrome_app/model/login_response.dart';

abstract class AuthRepository {
  Future<LoginResponse> login({required String email, required String password});

  Future requestResetPassword({required String email});

  Future logout();

  Future<void> checkToken();
}
