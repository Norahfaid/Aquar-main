// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import '../../../../core/constant/colors/colors.dart';
// import '../../../../core/constant/styles/sized_box.dart';
// import '../../../../core/constant/styles/styles.dart';

// class DrawerWidget extends StatelessWidget {
//   final String title;
//   final String image;
//   final Function() onTap;
//   const DrawerWidget({
//     Key? key,
//     required this.title,
//     required this.image,
//     required this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 10),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             SvgPicture.asset(
//               image,
//               color: white,
//               height: 50.h,
//             ),
//             sizedBoxh5,
//             Text(
//               title,
//               style: TextStyles.textViewRegular20.copyWith(color: white),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
