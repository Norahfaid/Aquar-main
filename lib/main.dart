import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

import 'core/constant/colors/colors.dart';
import 'core/constant/size_config.dart';
import 'core/util/app_navigator.dart';
import 'core/widgets/timer_cubit/timer_cubit.dart';
import 'core/widgets/toast.dart';
import 'features/annoncements/nafaz_inj.dart';
import 'features/auth/auth_inj.dart';
import 'features/auth/presentation/cubit/auto_login/auto_login_cubit.dart';
import 'features/auth/presentation/pages/login_screen.dart';
import 'features/auth/presentation/pages/splash_screen.dart';
import 'features/favourite/fav_inj.dart';
import 'features/home/filter_inj.dart';
import 'features/home/presentation/cubit/network_types/get_network_types_cubit.dart';
import 'features/home/presentation/pages/home_screen.dart';
import 'features/settings/presentation/cubit/terms_annonce/cubit/terms_annonce_cubit.dart';
import 'features/settings/settings_inj.dart';
import 'injection_container/injection_container.dart' as di;
import 'injection_container/injection_container.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  var initialzationSettingsAndroid =
      const AndroidInitializationSettings('logo');
  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings();
  var initializationSettings = InitializationSettings(
      android: initialzationSettingsAndroid, iOS: initializationSettingsIOS);
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: android.smallIcon,
            priority: Priority.max,
            enableLights: true,
            playSound: true,
          ),
        ));
  }
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.high,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = false;
  }

  Bloc.observer = MyBlocObserver();
  // HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // initDynamicLinks();
  // DynamicLink().initDynamicLick();
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await di.init();
  await EasyLocalization.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: mainColor,
    statusBarIconBrightness: Brightness.dark,
  ));
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar'), Locale('en')],
      path: "assets/translate",
      saveLocale: true,
      startLocale: const Locale('ar'),
      useOnlyLangCode: true,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    return MultiBlocProvider(
      providers: [
        BlocProvider<TimerCubit>(
          create: (BuildContext context) => TimerCubit(),
        ),
        ...authBlocs(context: context),
        ...settingsBlocs(context),
        ...favBlocs(context: context),
        ...filterBlocs(context: context),
        ...nafazBlocs(context: context),
      ],
      child: MaterialApp(
        title: 'Aquar',
        navigatorKey: sl<AppNavigator>().navigatorKey,
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        theme: ThemeData(
          fontFamily: "Tajawal",
          canvasColor: mainColor,

          ///TextTheme
          textTheme: const TextTheme(),
        ),
        locale: context.locale,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        home: const NotificationsHandler(),
      ),
    );
  }
}

class NotificationsHandler extends StatefulWidget {
  const NotificationsHandler({super.key});

  @override
  State<NotificationsHandler> createState() => _NotificationsHandlerState();
}

class _NotificationsHandlerState extends State<NotificationsHandler> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      log("locale${context.locale}");
      log("deviceLocale${context.deviceLocale}");
      Locale locale = context.deviceLocale;
      if (context.locale != context.deviceLocale) {
        locale = context.locale;
      }
      context.setLocale(locale);
      di.helper.updateLocalInHeaders(locale.languageCode);
    });
    var initialzationSettingsAndroid =
        const AndroidInitializationSettings('logo');
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initialzationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) async {
        // context.read<NotificationsCubit>().fGetNewNotificationTrue();
        // final message = jsonDecode(payload.payload ?? "");
        // log(message.toString());
      },
    );
    FirebaseMessaging.onMessage.listen((event) async {
      // context.read<NotificationsCubit>().fGetNewNotificationTrue();
      log(event.data.toString());
      if (Platform.isAndroid) {
        await flutterLocalNotificationsPlugin.show(
            event.hashCode,
            event.notification?.title ?? "",
            event.notification?.body ?? "",
            NotificationDetails(
              iOS: const DarwinNotificationDetails(
                presentAlert: true,
                presentBadge: true,
                presentSound: true,
              ),
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                priority: Priority.max,
                enableLights: true,
                playSound: true,
              ),
            ));
      }
    });
    FirebaseMessaging.onMessageOpenedApp
        .listen((RemoteMessage message) async {});
  }

  @override
  Widget build(BuildContext context) {
    DateTime? currentBackPressTime;
    return WillPopScope(
        onWillPop: () async {
          DateTime now = DateTime.now();
          if (currentBackPressTime == null ||
              now.difference(currentBackPressTime!) >
                  const Duration(seconds: 2)) {
            currentBackPressTime = now;
            showToast(
              tr('click_again_to_exit'),
            );
            return Future.value(false);
          }
          return Future.value(true);
        },
        child: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus) {
                FocusScope.of(context).unfocus();
              }
            },
            child: const Aquar(
              isInit: true,
            )));
  }
}

class Aquar extends StatefulWidget {
  const Aquar({Key? key, this.isInit = false}) : super(key: key);
  final bool isInit;
  @override
  State<Aquar> createState() => _AquarState();
}

class _AquarState extends State<Aquar> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (widget.isInit) {
        context.read<AutoLoginCubit>().fAutoLogin();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(428, 926));
    SizeConfig().init(context);
    return BlocConsumer<AutoLoginCubit, AutoLoginState>(
      listener: (context, state) {
        if (state is AutoLoginHasUser) {
          context.read<GetNetWorkTypesCubit>().fGetNetWorkTypes();
          context.read<TermsAnnonceCubit>().fGetTermsAnnonce();
        }
      },
      builder: (context, state) {
        if (state is AutoLoginHasUser || state is AutoLoginGuest) {
          log("AutoLoginHasUser======");
          return const HomeScreen();
        } else if (state is AutoLoginNoUser) {
          log("AutoLoginNoUser======");
          return const LoginScreen();
        } else {
          log("Splash=====");
          return const SplashScreen();
        }
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class Parms {
  final String? purpose;
  final String? params2;
  final String? params3;
  final String? params4;

  Parms(this.purpose, this.params2, this.params3, this.params4);
  String toQParams() {
    String q = "?";
    if (purpose != null) {
      q += "purpose=$purpose&";
    }

    if (q == "?") {
      q = "";
    }
    if (q.endsWith("&")) {
      q.substring(0, q.length - 1);
    }
    return q;
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log('onEvent -- ${bloc.runtimeType}, $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onTransition(Bloc bloc, dynamic transition) {
    super.onTransition(bloc, transition);
    log('onTransition -- ${bloc.runtimeType}, $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    log('onClose -- ${bloc.runtimeType}');
  }
}
