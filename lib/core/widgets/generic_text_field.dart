import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant/colors/colors.dart';
import '../constant/styles/styles.dart';
import 'arabic_input.dart';

class GenericTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validation;
  final void Function(String)? onSubmitted;
  final String? labeltext;
  final String? hintText;
  final bool readOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isProfile;

  final List<TextInputFormatter>? inputFormatters;
  final bool? autoFocus;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final double? borderRaduis;
  final bool? isFilled;
  final Function(String)? onChanged;
  final bool? enable;
  final Color? colorStyle;
  final int? maxLines;
  final void Function()? onTap;
  const GenericTextField({
    super.key,
    this.controller,
    this.validation,
    this.labeltext,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onSubmitted,
    this.focusNode,
    this.keyboardType,
    this.readOnly = false,
    this.isProfile = false,
    this.autoFocus = false,
    this.borderRaduis = 25,
    this.isFilled = false,
    this.colorStyle = greyTextColor,
    this.enable = true,
    this.maxLines = 1,
    this.onTap,
    this.onChanged,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enable,
      focusNode: focusNode,
      inputFormatters: inputFormatters ?? [ArabicNumberTextInputFormatter()],
      onTap: onTap,
      onChanged: onChanged,
      // textInputAction: TextInputAction.done,
      autofocus: autoFocus!,
      onFieldSubmitted: onSubmitted,
      readOnly: readOnly,
      controller: controller,
      keyboardType: keyboardType,
      autocorrect: true,
      maxLines: maxLines,
      validator: validation,
      style: TextStyle(
        color: colorStyle,
        fontSize: 14.sp,
      ),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        filled: isFilled,
        fillColor: mainColor.withOpacity(0.3),
        prefixIcon: prefixIcon,
        suffix: suffixIcon,
        hintText: hintText,
        labelText: labeltext,
        labelStyle: TextStyle(fontSize: 14.sp, color: colorStyle),
        hintStyle: TextStyles.textViewRegular20
            .copyWith(color: const Color(0xffC8C1C1)),
        border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: mainColor,
            ),
            borderRadius: BorderRadius.circular(borderRaduis!.sp)),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: redColor,
            ),
            borderRadius: BorderRadius.circular(borderRaduis!.sp)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: mainColor,
            ),
            borderRadius: BorderRadius.circular(borderRaduis!.sp)),
        disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: mainColor,
            ),
            borderRadius: BorderRadius.circular(borderRaduis!.sp)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: mainColor,
            ),
            borderRadius: BorderRadius.circular(borderRaduis!.sp)),
      ),
    );
  }
}
