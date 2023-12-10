import 'package:aquar/features/auth/presentation/cubit/change_phone/cubit/change_phone_cubit.dart';
import 'package:aquar/features/auth/presentation/cubit/verify_change_phone/cubit/verify_change_phone_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../core/local/auth_local_datasource.dart';
import '../../injection_container/injection_container.dart';
import 'data/datasource/auth_datasource.dart';
import 'data/repo_impl/auth_repo_impl.dart';
import 'domain/repository/auth_repo.dart';
import 'domain/usecase/auto_login.dart';
import 'domain/usecase/change_phone.dart';
import 'domain/usecase/check_code_usecase.dart';
import 'domain/usecase/cities_usecase.dart';
import 'domain/usecase/delete_account.dart';
import 'domain/usecase/edit_profile.dart';
import 'domain/usecase/forget_pass.dart';
import 'domain/usecase/get_profile.dart';
import 'domain/usecase/get_user_types.dart';
import 'domain/usecase/login_usecase.dart';
import 'domain/usecase/logout_usecase.dart';
import 'domain/usecase/real_states_usecase.dart';
import 'domain/usecase/regins_usecase.dart';
import 'domain/usecase/register_usecase.dart';
import 'domain/usecase/resend_reset_code.dart';
import 'domain/usecase/reset_pass_usecase.dart';
import 'domain/usecase/verify_change_phone.dart';
import 'domain/usecase/verify_register.dart';
import 'presentation/cubit/auto_login/auto_login_cubit.dart';
import 'presentation/cubit/check_code/cubit/check_code_cubit.dart';
import 'presentation/cubit/delete_account/cubit/delete_cubit.dart';
import 'presentation/cubit/edit_profile/edit_profile_cubit.dart';
import 'presentation/cubit/forget_pass.dart/cubit/forget_pass_cubit.dart';
import 'presentation/cubit/get_cities_cubit/cubit/get_cities_cubit.dart';
import 'presentation/cubit/get_profile/get_profile_cubit.dart';
import 'presentation/cubit/get_real_states/cubit/get_real_states_cubit.dart';
import 'presentation/cubit/get_regions/cubit/get_regions_cubit.dart';
import 'presentation/cubit/get_user_type/cubit/get_user_type_cubit.dart';
import 'presentation/cubit/login_cubit/cubit/login_cubit_cubit.dart';
import 'presentation/cubit/logout/cubit/logot_cubit.dart';
import 'presentation/cubit/register/cubit/register_cubit.dart';
import 'presentation/cubit/resend_code/cubit/resend_code_cubit.dart';
import 'presentation/cubit/reset_pass/cubit/reset_pass_cubit.dart';
import 'presentation/cubit/submit_register/cubit/submit_register_cubit.dart';

Future<void> initAuthInjection(GetIt sl) async {
  //* provider
  sl.registerFactory(() => GetCitiesCubit(sl()));
  sl.registerLazySingleton(() => AutoLoginCubit(autoLogin: sl()));
  sl.registerLazySingleton(() => LogoutCubit(sl()));
  sl.registerLazySingleton(() => LoginCubit(sl()));
  sl.registerLazySingleton(() => ChangePhoneCubit(sl()));
  sl.registerFactory(() => DeleteCubit(sl()));
  sl.registerFactory(() => GetRealStatesCubit(sl()));
  sl.registerFactory(() => VerifyChangePhoneCubit(sl()));
  sl.registerFactory(() => ForgetPassCubit(sl()));

  sl.registerFactory(() => ResetPassCubit(sl()));
  sl.registerFactory(() => SendVerifyCodeRegisterCubit(sl()));
  sl.registerFactory(() => EditProfileCubit(editProfile: sl()));
  sl.registerFactory(() => SubmitRegisterCubit(sl()));
  // Register
  sl.registerFactory(() => RegisterCubit(sl()));

  sl.registerFactory(() => CheckCodeCubit(sl()));
  sl.registerFactory(() => GetUserTypeCubit(sl()));
  sl.registerFactory(() => GetRegionsCubit(sl()));
  sl.registerFactory(() => GetProfileCubit(getProfile: sl()));
//* Use cases
  sl.registerLazySingleton(() => GetCitiesUseCase(repository: sl()));
  sl.registerLazySingleton(() => ChangePhoneUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetRealStatesUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetProfile(repository: sl()));
  sl.registerLazySingleton(() => AutoLoginUsecase(repository: sl()));
  sl.registerLazySingleton(() => VerifyChangePhoneUseCase(repository: sl()));
  sl.registerLazySingleton(
      () => SensVerificationCodeRegisterUseCase(repository: sl()));
  sl.registerLazySingleton(() => ResetCodeUseCase(repository: sl()));
  sl.registerLazySingleton(() => CheckCodeUseCase(repository: sl()));
  sl.registerLazySingleton(() => LoginUseCase(repository: sl()));
  sl.registerLazySingleton(() => RegisterUseCase(repository: sl()));
  sl.registerLazySingleton(() => VerifyRegisterUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetReginsUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetUserTypeUseCase(repository: sl()));
  sl.registerLazySingleton(() => ForgetPassUseCase(repository: sl()));
  sl.registerLazySingleton(() => EditProfile(repository: sl()));
  sl.registerLazySingleton(() => DeleteAccountUseCase(repository: sl()));
  sl.registerLazySingleton(() => LogoutUseCase(repository: sl()));
  //* Repository
  sl.registerLazySingleton<AuthRepository>(
    () =>
        AuthRepositoryImpl(remote: sl(), local: sl(), firebaseMessaging: sl()),
  );

  //* Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(helper: sl()));

  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sharedPreference: sl()),
  );
}

List<BlocProvider> authBlocs({required BuildContext context}) => [
      BlocProvider<GetCitiesCubit>(
          create: (BuildContext context) => sl<GetCitiesCubit>()),
      BlocProvider<GetRealStatesCubit>(
        create: (BuildContext context) =>
            sl<GetRealStatesCubit>()..fGetRealStates(),
      ),
      BlocProvider<GetRegionsCubit>(
        create: (BuildContext context) => sl<GetRegionsCubit>(),
      ),
      BlocProvider<VerifyChangePhoneCubit>(
        create: (BuildContext context) => sl<VerifyChangePhoneCubit>(),
      ),
      BlocProvider<RegisterCubit>(
        create: (BuildContext context) => sl<RegisterCubit>(),
      ),
      BlocProvider<ChangePhoneCubit>(
        create: (BuildContext context) => sl<ChangePhoneCubit>(),
      ),
      BlocProvider<GetProfileCubit>(
        create: (BuildContext context) => sl<GetProfileCubit>()..fGetProfile(),
      ),
      BlocProvider<LoginCubit>(
        create: (BuildContext context) => sl<LoginCubit>(),
      ),
      BlocProvider<ForgetPassCubit>(
        create: (BuildContext context) => sl<ForgetPassCubit>(),
      ),
      BlocProvider<SubmitRegisterCubit>(
        create: (BuildContext context) => sl<SubmitRegisterCubit>(),
      ),
      BlocProvider<GetUserTypeCubit>(
        create: (BuildContext context) =>
            sl<GetUserTypeCubit>()..fGetUserType(context: context),
      ),
      BlocProvider<CheckCodeCubit>(
        create: (BuildContext context) => sl<CheckCodeCubit>(),
      ),
      BlocProvider<SendVerifyCodeRegisterCubit>(
        create: (BuildContext context) => sl<SendVerifyCodeRegisterCubit>(),
      ),
      BlocProvider<ResetPassCubit>(
        create: (BuildContext context) => sl<ResetPassCubit>(),
      ),
      BlocProvider<AutoLoginCubit>(
        create: (BuildContext context) => sl<AutoLoginCubit>(),
      ),
      BlocProvider<LogoutCubit>(
        create: (BuildContext context) => sl<LogoutCubit>(),
      ),
      BlocProvider<DeleteCubit>(
        create: (BuildContext context) => sl<DeleteCubit>(),
      ),
      BlocProvider<EditProfileCubit>(
        create: (BuildContext context) => sl<EditProfileCubit>(),
      ),
    ];
