import 'package:aquar/features/annoncements/nafaz_inj.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/util/api_basehelper.dart';
import '../core/util/app_navigator.dart';
import '../core/widgets/timer_cubit/timer_cubit.dart';
import '../features/auth/auth_inj.dart';
import '../features/favourite/fav_inj.dart';
import '../features/home/filter_inj.dart';
import '../features/settings/settings_inj.dart';

final sl = GetIt.instance;
final ApiBaseHelper helper = ApiBaseHelper();
Future<void> init() async {
  await initAuthInjection(sl);
  await initFavInjection(sl);
  await initFilterInjection(sl);
  await initSettingsjection(sl);
  await initNafazInjection(sl);
  sl.registerFactory<TimerCubit>(() => TimerCubit());
  sl.registerLazySingleton(() => AppNavigator());
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  sl.registerLazySingleton<FirebaseMessaging>(() => firebaseMessaging);
  helper.dioInit();
  sl.registerLazySingleton(() => helper);
}
