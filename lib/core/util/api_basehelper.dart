import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';

import '../../features/auth/presentation/cubit/auto_login/auto_login_cubit.dart';
import '../../injection_container/injection_container.dart';
import '../../main.dart';
import '../error/exceptions.dart';
import 'app_navigator.dart';

//TODO:chage this before release
const isDevEnv = false;

class ApiBaseHelper {
  final String _baseUrl = isDevEnv
      ? "http://akaar.moltaqadev.com/api"
      : "https://akar.alusaifer.com.sa/api";
  final Dio dio = Dio();
  void dioInit() {
    dio.options.baseUrl = _baseUrl;
    dio.options.headers = headers;
    dio.options.sendTimeout = 80000; // time in ms
    dio.options.connectTimeout = 800000; // time in ms
    dio.options.receiveTimeout = 800000; // time in ms
  }

  ApiBaseHelper();
  Map<String, String> headers = {
    "Accept": "application/json",
    "Content-Type": 'application/json'
  };
  void updateLocalInHeaders(String local) {
    headers["Accept-Language"] = local;
    dio.options.headers = headers;
  }

  Future<dynamic> get({required String url, String? token}) async {
    try {
      // headers["Content-language"] = local;
      log(headers.toString());
      if (token != null) {
        headers["Authorization"] = "Bearer $token";
        dio.options.headers = headers;
      } else {
        log(" headers.remove Authorization )");
        dio.options.headers.remove("Authorization");
      }
      log(url);
      final Response response = await dio.get(url);

      log(response.data.toString());
      final responseJson = _returnResponse(response);
      return responseJson;
    } on SocketException {
      throw ServerException(message: tr("error_no_internet"));
    } on DioError catch (e) {
      if (e.response?.statusCode == 500) {
        throw ServerException(message: tr("error_please_try_again"));
      }
      if ((e.response?.data.toString().contains('<!doctype html>') ?? false) ||
          e.response?.statusCode == 401) {
        //TODO:
        //Send response error to cubit
        //Handle error in cubit
        //Emit state error to screen
        //Screen listen to this state and call fun from cubit which execute navigator
        sl<AppNavigator>().popToFrist();
        sl<AutoLoginCubit>().emitNoUser();
        sl<AppNavigator>().pushReplacement(screen: const Aquar());
      }
      log(e.toString());
      log(e.response?.toString() ?? "no response");
      final String message = e.response?.statusCode == 500
          ? ""
          : e.response?.data["message"] ?? tr("error_please_try_again");
      throw ServerException(message: message);
    }
  }

  Future<dynamic> put({
    required String url,
    String? token,
    Map<String, dynamic>? body,
  }) async {
    try {
      // headers["Content-language"] = local;
      final Response response;
      if (token != null) {
        headers["Authorization"] = "Bearer $token";
        headers["Content-Type"] = "application/x-www-form-urlencoded";

        dio.options.headers = headers;
      } else {
        log(" headers.remove Authorization )");
        dio.options.headers.remove("Authorization");
      }
      log(url);
      if (body != null) {
        // FormData formData = FormData.fromMap(body);
        response = await dio.put(url, data: body);
      } else {
        response = await dio.put(url);
      }
      if (response.data.toString().contains('<!doctype html>') ||
          response.statusCode == 401) {
        sl<AutoLoginCubit>().emitNoUser();
        sl<AppNavigator>().popToFrist();
        sl<AppNavigator>().pushReplacement(screen: const Aquar());
      }
      log(response.data.toString());
      final responseJson = _returnResponse(response);
      return responseJson;
    } on SocketException {
      throw ServerException(message: tr("error_no_internet"));
    } on DioError catch (e) {
      if (e.response?.statusCode == 500) {
        throw ServerException(message: tr("error_please_try_again"));
      }
      log(e.response?.toString() ?? "no response");
      final String message = e.response?.statusCode == 500
          ? ""
          : e.response?.data["message"] ?? tr("error_please_try_again");
      throw ServerException(message: message);
    }
  }

  Future<dynamic> post(
      {required String url,
      required Map<String, dynamic> body,
      void Function(int, int)? onSendProgress,
      String? token}) async {
    try {
      // headers["Content-language"] = local;
      if (token != null) {
        log(token);
        headers["Authorization"] = "Bearer $token";
        dio.options.headers = headers;
      } else {
        log(" headers.remove Authorization )");
        dio.options.headers.remove("Authorization");
      }
      FormData formData = FormData.fromMap(body);
      log(url);
      log(body.toString());
      final Response response =
          await dio.post(url, data: formData, onSendProgress: onSendProgress);

      log(response.data.toString());
      if (!(response.data["success"] ?? true)) {
        throw DioError(
          requestOptions: response.requestOptions,
          response: response,
          error: response,
        );
      }
      final responseJson = _returnResponse(response);
      return responseJson;
    } on SocketException {
      throw ServerException(message: tr("error_no_internet"));
    } on DioError catch (e) {
      log(e.toString());
      if (e.response?.statusCode == 500) {
        throw ServerException(message: tr("error_please_try_again"));
      }
      if (e.response?.data.toString().contains('<!doctype html>') ??
          false || e.response?.statusCode == 401) {
        sl<AutoLoginCubit>().emitNoUser();
        sl<AppNavigator>().popToFrist();
        sl<AppNavigator>().pushReplacement(screen: const Aquar());
      }
      String message = e.response?.statusCode == 500
          ? ""
          : e.response?.data["message"] ?? tr("error_please_try_again");
      String responseErrorMessage = "";
      log(e.response?.toString() ?? "no response");
      if (e.response != null && e.response!.data["data"] != null) {
        (e.response!.data["data"] as Map<String, dynamic>).values.map((val) {
          if (val is String) {
            responseErrorMessage += "$e\n";
          }
          if (val is List) {
            for (var element in val) {
              responseErrorMessage += "$element\n";
            }
          }
        }).toList();
      }
      if (responseErrorMessage.isNotEmpty) {
        message = responseErrorMessage;
      }
      throw ServerException(message: message);
    }
  }

  Future<dynamic> postWithImage(
      {required String url,
      required Map<String, dynamic> body,
      void Function(int, int)? onSendProgress,
      String? token}) async {
    try {
      dio.options.sendTimeout = 900000; // time in ms
      dio.options.connectTimeout = 900000; // time in ms
      dio.options.receiveTimeout = 900000; // time in ms
      // headers["Content-language"] = local;
      if (token != null) {
        log(token);
        headers["Authorization"] = "Bearer $token";
        dio.options.headers = headers;
      } else {
        log(" headers.remove Authorization )");
        dio.options.headers.remove("Authorization");
      }
      FormData formData = FormData.fromMap(body);
      log(url);
      log(body.toString());
      final Response response =
          await dio.post(url, data: formData, onSendProgress: onSendProgress);
      if (response.data.toString().contains('<!doctype html>') ||
          response.statusCode == 401) {
        sl<AutoLoginCubit>().emitNoUser();
        sl<AppNavigator>().popToFrist();
        sl<AppNavigator>().pushReplacement(screen: const Aquar());
      }
      log(response.data.toString());
      if (!(response.data["success"] ?? true)) {
        throw DioError(
          requestOptions: response.requestOptions,
          response: response,
          error: response,
        );
      }
      final responseJson = _returnResponse(response);

      dio.options.sendTimeout = 90000; // time in ms
      dio.options.connectTimeout = 90000; // time in ms
      dio.options.receiveTimeout = 90000; // time in ms
      return responseJson;
    } on SocketException {
      throw ServerException(message: tr("error_no_internet"));
    } on DioError catch (e) {
      log(e.toString());
      log(e.response?.toString() ?? "");
      dio.options.sendTimeout = 90000; // time in ms
      dio.options.connectTimeout = 90000; // time in ms
      dio.options.receiveTimeout = 90000; // time in ms
      String message = e.response?.statusCode == 500
          ? ""
          : e.response?.data["message"] ?? tr("error_please_try_again");
      String responseErrorMessage = "";
      log(e.response?.toString() ?? "no response");
      if (e.response != null && e.response!.data["data"] != null) {
        (e.response!.data["data"] as Map<String, dynamic>).values.map((val) {
          if (val is String) {
            responseErrorMessage += "$e\n";
          }
          if (val is List) {
            for (var element in val) {
              responseErrorMessage += "$element\n";
            }
          }
        }).toList();
      }
      if (responseErrorMessage.isNotEmpty) {
        message = responseErrorMessage;
      }
      throw ServerException(message: message);
    }
  }

  Future<dynamic> delete(
      {required String url,
      required Map<String, dynamic> body,
      String? token}) async {
    try {
      // headers["Content-language"] = local;
      if (token != null) {
        headers["Authorization"] = "Bearer $token";
        dio.options.headers = headers;
      } else {
        log(" headers.remove Authorization )");
        dio.options.headers.remove("Authorization");
      }
      FormData formData = FormData.fromMap(body);
      log(url);
      final Response response = await dio.delete(url, data: formData);
      log(response.data.toString());
      final responseJson = _returnResponse(response);
      return responseJson;
    } on SocketException {
      throw ServerException(message: tr("error_no_internet"));
    } on DioError catch (e) {
      if (e.response?.statusCode == 500) {
        throw ServerException(message: tr("error_please_try_again"));
      }
      log(e.toString());
      log(e.response?.toString() ?? "no response");
      final String message = e.response?.statusCode == 500
          ? ""
          : e.response?.data["message"] ?? tr("error_please_try_again");
      throw ServerException(message: message);
    }
  }

  Future uploadImage({required String url, required File file}) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path, filename: fileName),
      });
      final Response response = await dio.post(url, data: formData);
      final responseJson = _returnResponse(response);
      return responseJson;
    } on SocketException {
      throw ServerException(message: tr("error_no_internet"));
    } on DioError catch (e) {
      if (e.response?.statusCode == 500) {
        throw ServerException(message: tr("error_please_try_again"));
      }
      log(e.toString());
      log(e.response?.toString() ?? "no response");
      final String message = e.response?.statusCode == 500
          ? ""
          : e.response?.data["message"] ?? tr("error_please_try_again");
      throw ServerException(message: message);
    }
  }

  dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;
      case 400:
        throw ServerException(message: response.data['message']);
      case 422:
        throw response.data.toString();
      case 401:
      case 403:
        throw UnauthorizedException(message: response.data);
      case 500:
      default:
        debugPrint(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode} ${response.data}');
        throw ServerException(
            message:
                'Error occurred while Communication with Server with StatusCode : ${response.statusCode} ${response.data}');
    }
  }
}

class AppException implements Exception {
  final String? _message;
  final String? _prefix;

  AppException([this._message, this._prefix]);
  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, "");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException([message]) : super(message, "Unauthorized: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}
