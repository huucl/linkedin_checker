// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';

class BaseException implements Exception {
  BaseException({this.errorMessage, this.errorCode});

  final String? errorMessage;
  final int? errorCode;

  @override
  String toString() {
    return 'BaseException{errorMessage: $errorMessage, errorCode: $errorCode}';
  }
}

class ExceptionMessageMapper {
  static String getMessage(Object object) {
    switch (object.runtimeType) {
      case BaseException:
        return '${(object as BaseException).errorMessage}';
      case DioError:
        return _getDioMessage(object as DioError);
      case Exception:
        return '${object.runtimeType} exception';
      case String:
        return object.toString();
      default:
        return 'Unknown exception';
    }
  }

  static String _getDioMessage(DioError e) {
    try {
      var data = e.response?.data;
      if (data != null && data['message'] != null) {
        return data['message'];
      } else {
        return e.message.toString();
      }
    } catch (e) {
      return e.toString();
    }
  }
}
