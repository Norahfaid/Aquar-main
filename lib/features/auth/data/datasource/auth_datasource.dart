import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import '../../../../core/error/exceptions.dart';
import '../../../../core/usecases/usecases.dart';
import '../../../../core/util/api_basehelper.dart';
import '../../domain/models/change_phone.dart';
import '../../domain/models/check_code.dart';
import '../../domain/models/cities_entity.dart';
import '../../domain/models/forget_pass.dart';
import '../../domain/models/get_profile.dart';
import '../../domain/models/login.dart';
import '../../domain/models/logout_response.dart';
import '../../domain/models/real_state_types.dart';
import '../../domain/models/regines_entity.dart';
import '../../domain/models/register_response.dart';
import '../../domain/models/reset_pass.dart';
import '../../domain/models/send_verification_code_register.dart';
import '../../domain/models/submit_register.dart';
import '../../domain/models/user_types.dart';
import '../../domain/models/verify_change_phone.dart';
import '../../domain/usecase/change_phone.dart';
import '../../domain/usecase/check_code_usecase.dart';
import '../../domain/usecase/delete_account.dart';
import '../../domain/usecase/edit_profile.dart';
import '../../domain/usecase/forget_pass.dart';
import '../../domain/usecase/get_user_types.dart';
import '../../domain/usecase/login_usecase.dart';
import '../../domain/usecase/logout_usecase.dart';
import '../../domain/usecase/regins_usecase.dart';
import '../../domain/usecase/register_usecase.dart';
import '../../domain/usecase/resend_reset_code.dart';
import '../../domain/usecase/reset_pass_usecase.dart';
import '../../domain/usecase/verify_change_phone.dart';
import '../../domain/usecase/verify_register.dart';

const getCitiesApi = '/cities/';
const getUserTypeApi = '/user-types';
const getRegionApi = '/regions/';
const registerApi = '/register';
const forgetPassApi = '/password/forget';
const verifyRegisterApi = '/verification/verify';
const loginApi = '/login';
const checkCodeForgetPassApi = '/password/code';
const cresendCodeApi = '/verification/send';
const resetPassApi = '/password/reset';
const deleteApi = '/user/delete';
const logoutApi = '/logout';
const getProfileApi = '/profile';
const getRealStatesApi = '/building_types';
const editProfileApi = '/profile';
const changePhoneApi = '/update/phone';
const verifyChangePhoneApi = '/verify/phone';

abstract class AuthRemoteDataSource {
  Future<CitiesResponse> getCities();
  Future<UserTypesResponse> getUserType({required GetUserTypeParams params});
  Future<LoginResponse> login({required LoginParams params});

  Future<void> deleteAccount(
      {required String token, required DeleteAccountParams params});
  Future<LogoutResponse> logout(
      {required LogoutParams logoutParams, required String token});
  Future<VerifyRegisterResponse> verifyRegister(
      {required VerifyRegisterParams params});
  Future<RegisterResponse> register({required RegisterParams params});
  Future<ChangePhoneResponse> changePhone(
      {required ChangePhoneParams params, required String token});
  Future<VerifyChangePhoneResponse> verifyChangePhone(
      {required VerifyChangePhoneParams params, required String token});
  Future<RegiensResponse> getRegins({required ReginsParams params});
  Future<ForgetPassResponse> forgetPass({required ForgetPassParams params});

  Future<ResetPassResponse> resetCode({required ResetPassParams params});
  Future<SensVerificationCodeRegisterResponse> resendResetCode(
      {required ResendverificationRegisterCodeParams params});
  Future<CheckCodeForgetPassResponse> checkCode(
      {required CheckCodeParams params});
  Future<GetProfileResponse> getProfile(
      {required NoParams noParams, required String token});
  Future<GetProfileResponse> editProfile(
      {required EditProfileParams editProfileParams, required String token});

  Future<RealStateTypesResponse> getRealStates();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiBaseHelper helper;

  AuthRemoteDataSourceImpl({
    required this.helper,
  });

  @override
  Future<CitiesResponse> getCities() async {
    try {
      final response = await helper.get(url: "$getCitiesApi${"1"}");
      if (response['success'] == true) {
        final data = CitiesResponse.fromJson(response);
        return data;
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<RegiensResponse> getRegins({required ReginsParams params}) async {
    try {
      final response = await helper.get(url: "$getRegionApi${params.cityId}");
      if (response['success'] == true) {
        final data = RegiensResponse.fromJson(response);
        return data;
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<UserTypesResponse> getUserType(
      {required GetUserTypeParams params}) async {
    try {
      final response = await helper.get(url: getUserTypeApi);
      if (response['success'] == true) {
        final data = UserTypesResponse.fromJson(response);
        return data;
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<RegisterResponse> register({required RegisterParams params}) async {
    try {
      final map = {
        "name": params.name,
        "phone": params.phone,
        "city_id": params.cityId,
        "region_id": params.regionId,
        // "national_id": params.nationalId,
        "user_type_id": params.userTypeId,
        "password": params.password,
        "password_confirmation": params.passConfirmation,
      };
      if (params.licenseNumber != null && params.licenseNumber!.isNotEmpty) {
        map.addAll({"license_number": params.licenseNumber});
      }
      final response = await helper.post(url: registerApi, body: map);
      if (response['success'] == true) {
        final data = RegisterResponse.fromJson(response);
        return data;
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<VerifyRegisterResponse> verifyRegister(
      {required VerifyRegisterParams params}) async {
    try {
      final response = await helper.post(url: verifyRegisterApi, body: {
        "phone": params.phone.trim(),
        "code": params.code.trim(),
      });
      if (response['success'] == true) {
        final data = VerifyRegisterResponse.fromJson(response);
        return data;
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<LoginResponse> login({required LoginParams params}) async {
    try {
      final response = await helper.post(url: loginApi, body: {
        "phone": params.phone,
        "password": params.password,
        "device_token": params.deviceToken,
      });
      if (response['success'] == true) {
        final data = LoginResponse.fromJson(response);
        return data;
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<ForgetPassResponse> forgetPass(
      {required ForgetPassParams params}) async {
    try {
      final response = await helper.post(url: forgetPassApi, body: {
        "phone": params.phone,
      });
      if (response['success'] == true) {
        final data = ForgetPassResponse.fromJson(response);
        return data;
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<CheckCodeForgetPassResponse> checkCode(
      {required CheckCodeParams params}) async {
    try {
      final response = await helper.post(url: checkCodeForgetPassApi, body: {
        "phone": params.phone,
        "code": params.code,
      });
      if (response['success'] == true) {
        final data = CheckCodeForgetPassResponse.fromJson(response);
        return data;
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<SensVerificationCodeRegisterResponse> resendResetCode(
      {required ResendverificationRegisterCodeParams params}) async {
    try {
      final response = await helper.post(url: cresendCodeApi, body: {
        "phone": params.phone,
      });

      final data = SensVerificationCodeRegisterResponse.fromJson(response);
      return data;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<ResetPassResponse> resetCode({required ResetPassParams params}) async {
    try {
      final response = await helper.post(url: resetPassApi, body: {
        "token": params.token,
        "password": params.pass,
        "password_confirmation": params.passConfirm,
      });
      if (response['success'] == true) {
        final data = ResetPassResponse.fromJson(response);
        return data;
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<void> deleteAccount(
      {required String token, required DeleteAccountParams params}) async {
    try {
      await helper.post(
          token: token,
          body: {"password": params.password},
          url: deleteApi) as Map<String, dynamic>;
      log("$deleteApi=======deleeeeeteee");
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<LogoutResponse> logout(
      {required LogoutParams logoutParams, required String token}) async {
    try {
      // SharedPreferences preferences = await SharedPreferences.getInstance();
      // final token = preferences.getString(cacheTokenConst);
      final response = await helper.post(
        token: token,
        body: {},
        url: logoutApi,
      ) as Map<String, dynamic>;
      if (response['success'] == true) {
        final res = LogoutResponse.fromJson(response);
        return res;
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<GetProfileResponse> getProfile(
      {required NoParams noParams, required String token}) async {
    try {
      final response = await helper.get(
        token: token,
        url: getProfileApi,
      ) as Map<String, dynamic>;

      if (response['success'] == true) {
        final res = GetProfileResponse.fromJson(response);

        return res;
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<GetProfileResponse> editProfile(
      {required EditProfileParams editProfileParams,
      required String token}) async {
    try {
      final map = {
        "name": editProfileParams.name,
        "phone": "${editProfileParams.phone}",
      };
      log('${editProfileParams.avatar}avtar ======================');
      if (editProfileParams.avatar != null) {
        final bytes = File(editProfileParams.avatar!.path).readAsBytesSync();
        String img64 = base64Encode(bytes);
        // final avatarAsUrl = await MultipartFile.fromFile(
        //     editProfileParams.avatar!.path,
        //     filename: editProfileParams.avatar!.path);
        map.addAll({
          "avatar": img64,
        });
      }
      if (editProfileParams.oldPass != '') {
        map.addAll({
          "old_password": editProfileParams.oldPass,
          "password": editProfileParams.pass,
          "password_confirmation": editProfileParams.passConfirm,
        });
      }
      final response = await helper.postWithImage(
        token: token,
        url: editProfileApi,
        body: map,
      );
      if (response['success'] == true) {
        final res = GetProfileResponse.fromJson(response);
        return res;
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<RealStateTypesResponse> getRealStates() async {
    try {
      final response = await helper.get(url: getRealStatesApi);
      if (response['success'] == true) {
        final data = RealStateTypesResponse.fromJson(response);
        return data;
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<ChangePhoneResponse> changePhone(
      {required ChangePhoneParams params, required String token}) async {
    try {
      final response = await helper.post(
        token: token,
        body: {"new": params.phone},
        url: changePhoneApi,
      ) as Map<String, dynamic>;

      if (response['success'] == true) {
        final res = ChangePhoneResponse.fromJson(response);

        return res;
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<VerifyChangePhoneResponse> verifyChangePhone(
      {required VerifyChangePhoneParams params, required String token}) async {
    try {
      final response = await helper.post(
        token: token,
        body: {"new": params.phone, "code": params.code},
        url: verifyChangePhoneApi,
      ) as Map<String, dynamic>;

      if (response['success'] == true) {
        final res = VerifyChangePhoneResponse.fromJson(response);

        return res;
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}
