// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../constant/icons.dart';

// import '../../bloc/bottom_bar/bottom_bar_cubit.dart';
// import '../constant/colors/colors.dart';
// import '../constant/dimenssions/screen_util.dart';

// class MasterBottomBar extends StatelessWidget {
//   const MasterBottomBar({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final bloc = BlocProvider.of<BottomBarCubit>(context, listen: true);
//     return BottomNavigationBar(
//       backgroundColor: white,
//       items: <BottomNavigationBarItem>[
//         BottomNavigationBarItem(
//           icon: Image.asset(
//             homeIcon,
//             color: bloc.selectedIndex == 0 ? mainColor : hintColor,
//             height: width(20),
//             fit: BoxFit.contain,
//           ),
//           label: tr("main"),
//         ),
//         BottomNavigationBarItem(
//           icon: Image.asset(
//             orderIcon,
//             color: bloc.selectedIndex == 1 ? mainColor : hintColor,
//             height: width(20),
//             fit: BoxFit.contain,
//           ),
//           label: tr("orders"),
//         ),
//         BottomNavigationBarItem(
//           icon: Image.asset(
//             notificationIcon,
//             color: bloc.selectedIndex == 2 ? mainColor : hintColor,
//             height: width(20),
//             fit: BoxFit.contain,
//           ),
//           label: tr("notifications"),
//         ),
//         BottomNavigationBarItem(
//           icon: Image.asset(
//             messageIcon,
//             color: bloc.selectedIndex == 3 ? mainColor : hintColor,
//             height: width(20),
//             fit: BoxFit.contain,
//           ),
//           label: tr("messages"),
//         ),
//         BottomNavigationBarItem(
//           icon: Image.asset(
//             moreIcon,
//             color: bloc.selectedIndex == 4 ? mainColor : hintColor,
//             height: width(8),
//             fit: BoxFit.contain,
//           ),
//           label: tr("more"),
//         ),
//       ],
//       onTap: (int index) => bloc.changeBottomBar(index),
//       iconSize: width(20),
//       currentIndex: bloc.selectedIndex,
//       type: BottomNavigationBarType.fixed,
//       unselectedItemColor: hintColor,
//       elevation: 1.0,
//       selectedItemColor: mainColor,
//     );
//     // }));
//   }
// }
