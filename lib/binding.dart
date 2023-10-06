import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_chrome_app/data/client/network_client.dart';
import 'package:get/get.dart';

import 'data/repository/auth_repository_impl.dart';
import 'domain/repository/auth_repository.dart';

class MainBinding extends Bindings {
  final baseUrl = 'https://dev.api-crm.heydevs.io/v1';

  @override
  Future<void> dependencies() async {
    Get.put<HTTPProvider>(HTTPProvider(), permanent: true);
    Get.put<AuthRepository>(AuthRepositoryImpl(), permanent: true);
  }
}
