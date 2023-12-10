import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../models/change_phone.dart';
import '../models/check_code.dart';
import '../models/cities_entity.dart';
import '../models/forget_pass.dart';
import '../models/get_profile.dart';
import '../models/login.dart';
import '../models/logout_response.dart';
import '../models/real_state_types.dart';
import '../models/regines_entity.dart';
import '../models/register_response.dart';
import '../models/reset_pass.dart';
import '../models/send_verification_code_register.dart';
import '../models/submit_register.dart';
import '../models/user_types.dart';
import '../models/verify_change_phone.dart';
import '../usecase/change_phone.dart';
import '../usecase/check_code_usecase.dart';
import '../usecase/delete_account.dart';
import '../usecase/edit_profile.dart';
import '../usecase/forget_pass.dart';
import '../usecase/get_user_types.dart';
import '../usecase/login_usecase.dart';
import '../usecase/logout_usecase.dart';
import '../usecase/regins_usecase.dart';
import '../usecase/register_usecase.dart';
import '../usecase/resend_reset_code.dart';
import '../usecase/reset_pass_usecase.dart';
import '../usecase/verify_change_phone.dart';
import '../usecase/verify_register.dart';

abstract class AuthRepository {
  Future<Either<Failure, CitiesResponse>> getCities();
  Future<Either<Failure, UserTypesResponse>> getUseType(
      {required GetUserTypeParams params});
  Future<Either<Failure, ChangePhoneResponse>> changePhone(
      {required ChangePhoneParams params});
  Future<Either<Failure, VerifyChangePhoneResponse>> verifyChangePhone(
      {required VerifyChangePhoneParams params});
  Future<Either<Failure, LoginResponse>> login({required LoginParams params});
  Future<Either<Failure, VerifyRegisterResponse>> verifyRegister(
      {required VerifyRegisterParams params});
  Future<Either<Failure, RegisterResponse>> register(
      {required RegisterParams params});
  Future<Either<Failure, RegiensResponse>> getRegins(
      {required ReginsParams params});
  Future<Either<Failure, ForgetPassResponse>> forgetPass(
      {required ForgetPassParams params});
  Future<Either<Failure, GetProfileResponse>> getProfile({
    required NoParams noParams,
  });
  Future<Either<Failure, RealStateTypesResponse>> getRealStates();
  Future<Either<Failure, User>> autoLogin();
  Future<Either<Failure, GetProfileResponse>> editProfile(
      {required EditProfileParams editProfileParams});
  Future<Either<Failure, Unit>> deleteAccount(
      {required DeleteAccountParams params});

  Future<Either<Failure, LogoutResponse>> logout(
      {required LogoutParams params});
  Future<Either<Failure, SensVerificationCodeRegisterResponse>>
      resendverificationRegisterCode(
          {required ResendverificationRegisterCodeParams params});
  Future<Either<Failure, CheckCodeForgetPassResponse>> checkCode(
      {required CheckCodeParams params});
  Future<Either<Failure, ResetPassResponse>> resetPass(
      {required ResetPassParams params});
}
