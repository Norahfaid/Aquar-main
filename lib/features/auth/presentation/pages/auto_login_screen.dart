// import 'dart:developer';

// import 'package:aquar/features/auth/presentation/pages/splash_screen.dart';
// import 'package:aquar/features/home/presentation/pages/home_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../cubit/auto_login/auto_login_cubit.dart';
// import 'login_screen.dart';

// class HasUserScreen extends StatefulWidget {
//   const HasUserScreen({super.key});

//   @override
//   State<HasUserScreen> createState() => _HasUserScreenState();
// }

// class _HasUserScreenState extends State<HasUserScreen> {
//   @override
//   void initState() {
//     Future.microtask(() {
//       context.read<AutoLoginCubit>().fAutoLogin(context: context);
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocConsumer<AutoLoginCubit, AutoLoginState>(
//         listener: (context, state) {
//           // if (state is AutoLoginHasUser) {
//           //   context.read<LoginCubit>().updateUser = state.user;
//           // }
//         },
//         builder: (context, state) {
//           if (state is AutoLoginHasUser) {
//             log("AutoLoginHasUser======");
//             return const HomeScreen();
//           } else if (state is AutoLoginNoUser) {
//             log("AutoLoginNoUser======");
//             return const LoginScreen();
//           } else {
//             log("Splash=====");
//             return const SplashScreen();
//           }
//         },
//       ),
//     );
//   }
// }
