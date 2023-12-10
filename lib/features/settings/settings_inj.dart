import 'package:aquar/features/settings/domain/usecase/privacy_policy.dart';
import 'package:aquar/features/settings/domain/usecase/send_image.dart';
import 'package:aquar/features/settings/presentation/cubit/about_us/cubit/about_us_cubit.dart';
import 'package:aquar/features/settings/presentation/cubit/privacy_policy/privacy_policy_cubit.dart';
import 'package:aquar/features/settings/presentation/cubit/send_message/send_message_cubit.dart';
import 'package:aquar/features/settings/presentation/cubit/social_links/cubit/social_links_cubit.dart';
import 'package:aquar/features/settings/presentation/cubit/terms/terms_cubit.dart';
import 'package:aquar/features/settings/presentation/cubit/terms_annonce/cubit/terms_annonce_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../injection_container/injection_container.dart';
import 'data/datasource/remote_datasource.dart';
import 'data/repository_impl/repository_impl.dart';
import 'domain/repo/settings_repo.dart';
import 'domain/usecase/about_us.dart';
import 'domain/usecase/social_links.dart';
import 'domain/usecase/terms.dart';
import 'domain/usecase/terms_annonce.dart';

Future<void> initSettingsjection(GetIt sl) async {
  //* providerrofile: sl(),

  sl.registerFactory(() => TermsCubit(sl()));
  sl.registerFactory(() => PrivacyPolicyCubit(sl()));
  sl.registerFactory(() => TermsAnnonceCubit(sl()));
  sl.registerFactory(() => AboutUsCubit(sl()));
  sl.registerLazySingleton(() => SocialLinksCubit(sl()));
  sl.registerLazySingleton(() => SendMessageCubit(sendMessage: sl()));
  //* Use cases
  sl.registerLazySingleton(() => TermsUsecase(repository: sl()));
  sl.registerLazySingleton(() => PrivacyPolicy(repository: sl()));
  sl.registerLazySingleton(() => SocialLinksUsecase(repository: sl()));
  sl.registerLazySingleton(() => AboutUsUsecase(repository: sl()));
  sl.registerLazySingleton(() => TermsAnnonceUsecase(repository: sl()));
  sl.registerLazySingleton(() => SendMessage(repository: sl()));

  //* Repository
  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImp(remote: sl(), authLocal: sl()),
  );

  //* Data sources
  sl.registerLazySingleton<SettingsRemoteDatasource>(
    () => SettingsRemoteDatasourceImpl(
      helper: sl(),
    ),
  );
}

List<BlocProvider> settingsBlocs(BuildContext context) => [
      BlocProvider<TermsCubit>(
          create: (BuildContext context) => sl<TermsCubit>()),
      BlocProvider<PrivacyPolicyCubit>(
          create: (BuildContext context) => sl<PrivacyPolicyCubit>()),
      BlocProvider<SocialLinksCubit>(
          create: (BuildContext context) => sl<SocialLinksCubit>()),
      BlocProvider<TermsAnnonceCubit>(
          create: (BuildContext context) => sl<TermsAnnonceCubit>()),
      BlocProvider<AboutUsCubit>(
          create: (BuildContext context) => sl<AboutUsCubit>()),
      BlocProvider<SendMessageCubit>(
          create: (BuildContext context) => sl<SendMessageCubit>()),
    ];
