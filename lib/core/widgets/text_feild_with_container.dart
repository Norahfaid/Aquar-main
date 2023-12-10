// import 'package:flutter/material.dart';

// import '../../../../core/constant/styles/styles.dart';
// import '../constant/colors/colors.dart';
// import '../util/validator.dart';

// class MasterTextFieldWithContainer extends StatefulWidget {
//   final double? sidePadding;
//   final double? fieldHeight;
//   final double? fieldWidth;
//   final double? iconHeight;
//   final double? suffixIconHeight;
//   final TextEditingController? controller;
//   final Color? hintColor;
//   final TextInputType? keyboardType;
//   final bool? isPassword;
//   final bool? autofocus;
//   final Color? borderColor;
//   final Color? textFieldColor;
//   final String? errorText;
//   final String hintText;
//   final TextStyle? hintStyle;
//   final double? elevation;
//   final Color? shadowColor;
//   final bool? enabled;
//   final double? borderRadius;
//   final Widget? prefixIcon;
//   final String? suffixText;
//   final String? suffixIcon;
// //final List<TextInputFormatter>? inputFormatters;
//   final Color? suffixColor;
//   final int? maxLines;
//   final int? minLines;
//   final Function(String)? onChanged;
//   final int? borderWidth;
//   final Function(String)? onSubmit;
//   final Function()? onTap;
//   final String? Function(String?) validate;
//   final Widget? suffix;
//   final Color? fillColor;
//   final void Function()? onEditingComplete;
//   final bool filled;
//   final void Function(String?)? onSaved;
//   final TextDirection? textDirection;
//   final bool readOnly;
//   final double? width;
//   const MasterTextFieldWithContainer({
//     Key? key,
//     this.width,
//     this.filled = false,
//     this.autofocus,
//     this.fieldWidth,
//     this.elevation,
//     this.shadowColor,
//     this.borderColor,
//     this.textFieldColor,
//     this.readOnly = false,
//     this.suffixIconHeight,
//     this.iconHeight,
//     this.controller,
//     this.fieldHeight,
//     this.errorText,
//     required this.hintText,
//     this.textDirection = TextDirection.ltr,
//     this.hintStyle,
//     this.enabled,
//     this.borderWidth,
//     this.borderRadius,
//     this.isPassword,
//     this.keyboardType,
//     this.prefixIcon,
//     this.suffixIcon,
//     this.suffixText,
//     this.suffixColor,
//     this.onEditingComplete,
//     this.sidePadding,
//     this.maxLines,
//     this.minLines,
//     this.onChanged,
//     this.onSubmit,
//     this.onSaved,
//     this.validate = Validator.defaultEmptyValidator,
//     this.suffix,
//     this.onTap,
//     this.hintColor,
//     this.fillColor,
//     // this.inputFormatters,
//   }) : super(key: key);

//   @override
//   State<MasterTextFieldWithContainer> createState() =>
//       _MasterTextFieldWithContainerState();
// }

// class _MasterTextFieldWithContainerState
//     extends State<MasterTextFieldWithContainer> {
//   bool secure = false;
//   TextDirection? textDirection;
//   String? fontFamily;
//   @override
//   void initState() {
//     super.initState();
//     secure = widget.isPassword ?? false;
//     textDirection = widget.textDirection;
//     if (widget.keyboardType == TextInputType.number) {
//       fontFamily = "Almarai";
//     }
//   }

//   void _checkForArabicLetter(String text) {
//     final arabicRegex = RegExp(r'[ء-ي-_ \.]*$');
//     final englishRegex = RegExp(r'[a-zA-Z ]');
//     final spi = RegExp("[\$&+,:;=?@#|'<>.^*()%!-]+");
//     final numbers = RegExp("^[0-9]*\$");
//     setState(() {
//       text.contains(arabicRegex) &&
//               !text.startsWith(englishRegex) &&
//               !text.startsWith(spi) &&
//               !text.startsWith(numbers)
//           ? textDirection = TextDirection.rtl
//           : textDirection = TextDirection.ltr;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: widget.width ?? double.infinity,
//       child: TextFormField(
//         //autocorrect: true,
//         controller: widget.controller,
//         onChanged: (value) {
//           _checkForArabicLetter(value);
//           if (widget.onChanged != null) widget.onChanged!(value);
//         },
//         onTap: widget.onTap,
//         onEditingComplete: widget.onEditingComplete,

//         keyboardType: widget.keyboardType,
//         obscureText: secure,
//         maxLines: widget.maxLines ?? 1,
//         minLines: widget.minLines ?? 1,
//         autofocus: widget.autofocus ?? false,
//         style: TextStyles.textViewMedium20
//             .copyWith(color: brownColor, fontFamily: fontFamily),
//         enabled: widget.enabled,
//         onSaved: widget.onSaved,
//         validator: widget.validate,
//         onFieldSubmitted: widget.onSubmit,
//         textDirection: textDirection,
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//         // inputFormatters: inputFormatters,
//         decoration: InputDecoration(
//             contentPadding:
//                 const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
//             filled: widget.filled,
//             fillColor: widget.fillColor,
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10.0),
//               borderSide: BorderSide(
//                 color: greyColor.withOpacity(.3).withOpacity(.3),
//                 width: .5,
//               ),
//             ),
//             disabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10.0),
//               borderSide: BorderSide(
//                 color: greyColor.withOpacity(.3),
//                 width: 1,
//               ),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10.0),
//               borderSide: BorderSide(
//                 color: greyColor.withOpacity(.3),
//                 width: 1,
//               ),
//             ),
//             border: OutlineInputBorder(
//               borderSide: BorderSide(
//                 color: greyColor.withOpacity(.3),
//                 width: 1.0,
//               ),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             focusedErrorBorder: OutlineInputBorder(
//                 borderRadius: const BorderRadius.all(Radius.circular(10)),
//                 borderSide: BorderSide(
//                   color: widget.errorText != null
//                       ? redColor
//                       : greyColor.withOpacity(.3),
//                   width: 1,
//                   style: BorderStyle.solid,
//                 )),
//             hintText: widget.hintText,
//             hintStyle: TextStyles.textViewRegular20
//                 .copyWith(color: greyColor.withOpacity(.3)),
//             suffixIconColor: widget.suffixColor ?? greyColor.withOpacity(.3),
//             suffix: widget.suffix,
//             // prefixIcon: widget.prefixIcon,
//             // ? null
//             // : Column(
//             //     mainAxisAlignment: MainAxisAlignment.start,
//             //     children: [
//             //       Padding(
//             //         padding: const EdgeInsets.all(15),
//             //         child: Image.asset(widget.prefixIcon!,
//             //             height: widget.suffixIconHeight ?? 20.h,
//             //             color: widget.suffixColor,
//             //             fit: BoxFit.contain),
//             //       ),
//             //     ],
//             //   ),
//             suffixIcon: widget.prefixIcon),
//       ),
//     );
//   }
// }
