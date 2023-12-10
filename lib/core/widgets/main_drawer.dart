// import 'package:elmokhtsr_fe_dgawel/features/holy_quarn/presentation/pages/home_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../../../core/constant/colors/colors.dart';
// import '../../../../core/constant/icons.dart';
// import '../../../../core/constant/styles/sized_box.dart';
// import '../../../../core/util/new_navigator/navigator.dart';
// import '../../../../core/util/new_navigator/page_transiation.dart';
// import 'darwer_widget.dart';
// import 'icon_button_card.dart';

// class MainDrawer extends StatelessWidget {
//   const MainDrawer({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))),
//       backgroundColor: mainColor.withOpacity(.7),
//       width: 160.w,
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(10),
//               child: InkWell(
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(15),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       IconButtonCard(icon: Icons.close),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             DrawerWidget(
//               onTap: () {
//                 Navigation.popAllAndPush(
//                   context,
//                   customPageTransition: PageTransition(
//                     child: const HomeScreen(),
//                     type: PageTransitionType.fromLeft,
//                   ),
//                 );
//               },
//               image: offer,
//               title: "التفسير ",
//             ),
//             DrawerWidget(
//               onTap: () {
//                 Navigation.popAllAndPush(
//                   context,
//                   customPageTransition: PageTransition(
//                     child: const SurahScreen(),
//                     type: PageTransitionType.fromLeft,
//                   ),
//                 );
//               },
//               image: offer,
//               title: "القرآن الكريم",
//             ),
//             DrawerWidget(
//               onTap: () {
//                 Navigation.pushReplacement(
//                   context,
//                   customPageTransition: PageTransition(
//                     child: const SurahQuizScreen(),
//                     type: PageTransitionType.fromLeft,
//                   ),
//                 );
//               },
//               image: commanQuestion,
//               title: "اختبارات",
//             ),

//             DrawerWidget(
//               onTap: () {
//                 Navigation.push(
//                   context,
//                   customPageTransition: PageTransition(
//                     child: const HasUserScreen(),
//                     type: PageTransitionType.fromLeft,
//                   ),
//                 );
//               },
//               image: planStudy,
//               title: "خطط دراسية",
//             ),

//             //
//             DrawerWidget(
//               onTap: () {
//                 Navigation.pushReplacement(
//                   context,
//                   customPageTransition: PageTransition(
//                     child: const LearnersQuestions(),
//                     type: PageTransitionType.fromLeft,
//                   ),
//                 );
//               },
//               image: learnersQuestion,
//               title: "أسئلة الدارسين",
//             ),

//             //
//             DrawerWidget(
//               onTap: () {
//                 Navigation.popAllAndPush(
//                   context,
//                   customPageTransition: PageTransition(
//                     child: const PurposeOfSurahScreen(),
//                     type: PageTransitionType.fromLeft,
//                   ),
//                 );
//               },
//               image: surah,
//               title: "مقاصد السور",
//             ),

//             //
//             DrawerWidget(
//               onTap: () {
//                 Navigation.popAllAndPush(
//                   context,
//                   customPageTransition: PageTransition(
//                     child: const BenefitsScreen(),
//                     type: PageTransitionType.fromLeft,
//                   ),
//                 );
//               },
//               image: benfits,
//               title: "الفوائد",
//             ),
//             DrawerWidget(
//               onTap: () {
//                 Navigation.push(
//                   context,
//                   customPageTransition: PageTransition(
//                     child: const QuraabSearch(),
//                     type: PageTransitionType.fromLeft,
//                   ),
//                 );
//               },
//               image: fileIcon2,
//               title: "الفهرس",
//             ),

//             DrawerWidget(
//               onTap: () {
//                 context.read<AutoLoginCubit>().fAutoLogin(context: context);

//                 Navigation.pushReplacement(
//                   context,
//                   customPageTransition: PageTransition(
//                     child: const SettingsScreen(),
//                     type: PageTransitionType.fromLeft,
//                   ),
//                 );
//               },
//               image: settingSvg,
//               title: "الاعدادات",
//             ),

//             sizedBoxh20,
//           ],
//         ),
//       ),
//     );
//   }
// }
