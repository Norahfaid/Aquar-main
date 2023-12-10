import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/domain/models/login.dart';
import '../../features/auth/domain/models/register_response.dart';
import '../../features/auth/domain/usecase/login_usecase.dart';
import '../error/exceptions.dart';

const userCacheConst = "user_cache";
const cacheTokenConst = "cache_token";
const loginInfoConst = "login_info";
const registerBodyConst = "register_body_const";

abstract class AuthLocalDataSource {
  Future<void> cacheUserData({required User user});
  Future<User> getCachedUserData();

  Future<void> clearCachedUser();

  Future<void> cacheUserAccessToken({required String token});
  String getCacheUserAccessToken();
  String? getCacheUserAccessTokenForFiltter();
  Future<String> checkAccessForGuest();
  Future<void> cacheUserLoginInfo({required LoginParams params});
  Future<void> cacheRegisterBody({required RegisterResponse response});
  Future<LoginParams> getCacheUserLoginInfo();

  Future<void> clearData();
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  final SharedPreferences sharedPreference;
  AuthLocalDataSourceImpl({required this.sharedPreference});
  @override
  Future<void> cacheUserData({required User user}) async {
    try {
      await sharedPreference.setString(
          userCacheConst, jsonEncode(user.toJson()));
    } catch (e) {
      log(e.toString());
      throw CacheException();
    }
  }

  @override
  Future<User> getCachedUserData() async {
    try {
      final userShared = sharedPreference.getString(userCacheConst);
      if (userShared != null) {
        return userFromJson(userShared);
      } else {
        throw CacheException();
      }
    } on CacheException {
      throw CacheException();
    }
  }

  @override
  Future<void> clearCachedUser() async {
    try {
      await sharedPreference.clear();
    } catch (e) {
      log(e.toString());
      throw CacheException();
    }
  }

  @override
  Future<void> cacheUserAccessToken({required String token}) async {
    try {
      await sharedPreference.setString(cacheTokenConst, token);
    } catch (e) {
      log(e.toString());
      throw CacheException();
    }
  }

  @override
  String getCacheUserAccessToken() {
    try {
      final token = sharedPreference.getString(cacheTokenConst);
      if (token != null) {
        return token;
      } else {
        throw CacheException();
      }
    } on CacheException {
      throw CacheException();
    }
  }

  @override
  String? getCacheUserAccessTokenForFiltter() {
    try {
      final token = sharedPreference.getString(cacheTokenConst);
      if (token != null) {
        return token;
      } else {
        return null;
      }
    } on CacheException {
      throw CacheException();
    }
  }

  @override
  Future<String> checkAccessForGuest() async {
    try {
      final token = sharedPreference.getString(cacheTokenConst);
      if (token != null) {
        return token;
      } else {
        return "";
      }
    } catch (e) {
      log(e.toString());
      throw CacheException();
    }
  }

  @override
  Future<void> cacheUserLoginInfo({required LoginParams params}) async {
    try {
      await sharedPreference.setString(
          loginInfoConst, json.encode(params.toMap()));
    } catch (e) {
      log(e.toString());
      throw CacheException();
    }
  }

  @override
  Future<LoginParams> getCacheUserLoginInfo() async {
    try {
      final loginInfo = sharedPreference.getString(loginInfoConst);
      if (loginInfo != null) {
        return LoginParams.fromMap(json.decode(loginInfo));
      } else {
        throw CacheException();
      }
    } catch (e) {
      log(e.toString());
      throw CacheException();
    }
  }

  @override
  Future<void> clearData() async {
    try {
      await sharedPreference.clear();
    } catch (e) {
      log(e.toString());
      throw CacheException();
    }
  }

  @override
  Future<void> cacheRegisterBody({required RegisterResponse response}) async {
    try {
      await sharedPreference.setString(
          'send_register_code_body', jsonEncode(response.toJson()));
    } catch (e) {
      throw CacheException();
    }
  }
}
