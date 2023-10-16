// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter_chrome_app/app_routes.dart';
import 'package:flutter_chrome_app/domain/exception/base_exception.dart';
import 'package:flutter_chrome_app/utils/pref_util/pref_util.dart';

class HTTPProvider {
  final _dio = dio.Dio(
    BaseOptions(
        baseUrl: 'https://api-crm.heydevs.io/v1',
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Credentials": true,
          'Content-Type': 'application/json',
          'Accept': '*/*'
        },
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 5) // 30 seconds
        ),
  );

  Future<dynamic> makeGet(String path,
      {Map<String, dynamic>? query,
      dio.Options? options,
      dio.CancelToken? cancelToken,
      dio.ProgressCallback? onReceiveProgress}) async {
    try {
      var accessToken = PrefUtils().accessToken;
      var opt = Options(
        headers: {
          Headers.contentTypeHeader: 'application/json', // set content-length\
          'Authorization': 'Bearer $accessToken',
        },
      );
      var response = await _dio.get(path,
          queryParameters: query, options: opt, cancelToken: cancelToken, onReceiveProgress: onReceiveProgress);
      return response.data;
    } catch (e) {
      _handleException(e);
    }
  }

  Future<dynamic> makePost(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      dio.Options? options,
      dio.CancelToken? cancelToken,
      dio.ProgressCallback? onSendProgress,
      dio.ProgressCallback? onReceiveProgress}) async {
    var accessToken = PrefUtils().accessToken;
    var opt = Options(
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    try {
      var response = await _dio.post(path,
          options: opt,
          data: data,
          queryParameters: queryParameters,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress);
      return response.data;
    } catch (e) {
      _handleException(e);
    }
  }

  // make put
  Future<dynamic> makePut(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      dio.Options? options,
      dio.CancelToken? cancelToken,
      dio.ProgressCallback? onSendProgress,
      dio.ProgressCallback? onReceiveProgress}) async {
    var opt = Options(
      headers: {
        Headers.contentTypeHeader: 'application/json', // set content-length
      },
    );
    try {
      var response = await _dio.put(path,
          options: opt,
          data: data,
          queryParameters: queryParameters,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);
      return response.data;
    } catch (e) {
      _handleException(e);
    }
  }

  Future<dynamic> makeDelete(String path,
      {Map<String, dynamic>? query,
      data,
      dio.Options? options,
      dio.CancelToken? cancelToken,
      dio.ProgressCallback? onReceiveProgress}) async {
    try {
      var opt = Options(
        headers: {
          Headers.contentTypeHeader: 'application/json', // set content-length
        },
      );
      var response =
          await _dio.delete(path, queryParameters: query, options: opt, cancelToken: cancelToken, data: data);
      return response.data;
    } catch (e) {
      _handleException(e);
    }
  }

  void _handleException(Object e) {
    switch (e.runtimeType) {
      case dio.DioError:
        var dioError = e as dio.DioError;

        throw BaseException(
          errorMessage: _getDioMessage(e),
          errorCode: dioError.response?.statusCode,
        );
      default:
        throw BaseException(
          errorMessage: 'Unknown Error',
          errorCode: 111,
        );
    }
  }

  String _getDioMessage(dio.DioError e) {
    try {
      var data = e.response?.data;
      if (data != null && (data is Map) && data['message'] != null) {
        return data['message'];
      } else {
        if (e.response?.statusCode != null) {
          switch (e.response?.statusCode) {
            case 400:
              return 'Bad Request. Please try again later.';
            case 401:
              return 'Incorrect Email/Password combination.';
            case 403:
              return 'You do not have permission to access this.';
            case 404:
              return 'Service not found';
            case 500:
              return 'Internal Server Error.';
            case 503:
              return 'Unable to reach server.';
            default:
              return 'Error occurred while communicating with server. Status Code: ${e.message}';
          }
        } else {
          return e.message ?? 'Error occurred while communicating with server.';
        }
      }
    } catch (e) {
      return e.toString();
    }
  }
}
