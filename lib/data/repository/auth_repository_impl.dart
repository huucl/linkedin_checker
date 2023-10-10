import 'package:flutter_chrome_app/data/client/network_client.dart';
import 'package:flutter_chrome_app/domain/repository/auth_repository.dart';
import 'package:flutter_chrome_app/model/login_response.dart';
import 'package:get/get.dart';

class AuthRepositoryImpl implements AuthRepository {
  final _client = Get.find<HTTPProvider>();

  @override
  Future requestResetPassword({required String email}) async {
    var data = {'email': email};
    return await _client.makePost('/auth/request-reset-password', data: data);
  }

  @override
  Future<LoginResponse> login({required String email, required String password}) async {
    var data = {'email': email, 'password': password};
    try {
      var res = await _client.makePost('/auth/login', data: data);
      return LoginResponse.fromMap(res);
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future checkToken() async {
    try {
      await _client.makeGet('/locations');
    } catch (e) {
      rethrow;
    }
  }

}