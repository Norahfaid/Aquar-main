// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class MainTextField extends StatelessWidget {
//   const MainTextField(
//       {super.key,
//       this.hint,
//       this.prefixIcon,
//       this.hintColor,
//       this.textColor,
//       this.keyboardType,
//       this.borderColor, this.validation});
//   final String? hint;
//   final IconData? prefixIcon;
//   final Color? hintColor, textColor, borderColor;
//   final TextInputType? keyboardType;
//   final String? Function(String?)? validation;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 52.h,
//       child: TextFormField(
//         keyboardType: keyboardType ?? TextInputType.name,
//         cursorColor: const Color(0xFFCBA588),
//         cursorWidth: 2,
//         style: TextStyle(
//           color: textColor ?? Colors.white,
//           fontSize: 15,
//         ),
//         validator: validation,
//         decoration: InputDecoration(
//           focusedBorder: OutlineInputBorder(
//             borderSide:
//                 BorderSide(width: 2, color: borderColor ?? Colors.white),
//             borderRadius: BorderRadius.circular(50.0),
//           ),
//           hintText: hint,
//           hintStyle: TextStyle(
//               color: hintColor ?? Colors.white.withOpacity(0.4), fontSize: 15),
//           prefixIcon: Icon(
//             prefixIcon,
//             size: 20,
//             color: const Color(0xFFCBA588),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderSide:
//                 BorderSide(width: 2, color: borderColor ?? Colors.white),
//             borderRadius: BorderRadius.circular(50.0),
//           ),
//         ),
//       ),
//     );
//   }
// }
