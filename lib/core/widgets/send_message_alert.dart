// import 'package:aquar/core/util/app_navigator.dart';
// import 'package:aquar/core/widgets/toast.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:lottie/lottie.dart';

// import '../../../../../core/constant/colors/colors.dart';
// import '../../../../../core/constant/styles/styles.dart';
// import '../../../../../core/widgets/master_button.dart';
// import '../../../../../core/widgets/space.dart';
// import '../../features/auth/presentation/cubit/logout_cubit/logout_cubit.dart';
// import 'loading_widget.dart';

// class SendMessageDialog extends StatelessWidget {
//   final String text;
//   final String buttonText;
//   final double? buttonWidth;
//   final VoidCallback tap;
//   final String lottie;
//   const SendMessageDialog(
//       {Key? key,
//       required this.text,
//       required this.tap,
//       required this.lottie,
//       required this.buttonText,
//       this.buttonWidth})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: white,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
//       title: Column(
//         children: [
//           Lottie.asset(lottie, width: 100.w, height: 105.h),
//           const Space(boxHeight: 20),
//           Text(
//             text,
//             textAlign: TextAlign.center,
//             style: TextStyles.textViewMedium22.copyWith(color: textDarkColor),
//           ),
//           const Space(boxHeight: 30),
//           MasterButton(
//             buttonText: buttonText,
//             tag: "ok",
//             onPressed: tap,
//             buttonRadius: 50.r,
//             buttonWidth: buttonWidth ?? 140.w,
//             borderColor: mainColor,
//             buttonColor: mainColor,
//             buttonHeight: 53.h,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class LogoutDialog extends StatelessWidget {
//   const LogoutDialog({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: white,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
//       title: Column(
//         children: [
//           const Space(boxHeight: 20),
//           Text(
//             "تاكيد تسجيل الخروج",
//             textAlign: TextAlign.center,
//             style: TextStyles.textViewMedium22.copyWith(color: textDarkColor),
//           ),
//           const Space(boxHeight: 30),
//           Row(
//             children: [
//               BlocConsumer<LogoutCubit, LogoutState>(
//                 listener: (context, state) {
//                   if (state is LogoutSuccessState) {
//                     showToast(state.message);
//                     sl<AppNavigator>().pop();
//                     AppNavigator.popToFrist(context: context);
//                     // context
//                     //     .read<AutoLoginCubit>()
//                     //     .emitNoUser();
//                   }
//                 },
//                 builder: (context, state) {
//                   if (state is LogoutLoadingState) {
//                     return const Loading();
//                   }
//                   return MasterButton(
//                     buttonText: "تاكيد",
//                     tag: "d",
//                     onPressed: () async {
//                       Navigator.of(context).pop();
//                       await context.read<LogoutCubit>().fLogout();
//                     },
//                     buttonRadius: 50.r,
//                     buttonWidth: 140.w,
//                     borderColor: mainColor,
//                     buttonColor: mainColor,
//                     buttonHeight: 53.h,
//                   );
//                 },
//               ),
//               const Space(boxWidth: 10),
//               MasterButton(
//                 buttonText: "رجوع",
//                 tag: "ok",
//                 onPressed: () {
//                   sl<AppNavigator>().pop();
//                 },
//                 buttonRadius: 50.r,
//                 buttonWidth: 140.w,
//                 borderColor: mainColor,
//                 buttonColor: mainColor,
//                 buttonHeight: 53.h,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
