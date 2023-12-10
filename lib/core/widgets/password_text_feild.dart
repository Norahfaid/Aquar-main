import 'package:aquar/core/widgets/side_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant/colors/colors.dart';
import '../constant/styles/styles.dart';
import 'arabic_input.dart';

// ignore: must_be_immutable
class PasswordMasterTextField extends StatefulWidget {
  final double? sidePadding;
  final double? fieldHeight;
  final double? fieldWidth;
  final double? iconHeight;
  final double? suffixIconHeight;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  bool? isPassword;
  final bool? autofocus;
  final Color? borderColor;
  final Color? textFieldColor;

  final List<TextInputFormatter>? inputFormatters;
  final String? errorText;
  final String hintText;
  final TextStyle? hintStyle;
  final double? elevation;
  final Color? shadowColor;
  final bool? enabled;
  final double? borderRadius;
  final String? prefixIcon;
  final String? suffixText;
  final Widget? suffixIcon;
  final Color? hinttextColor;
  final Color? suffixColor;
  final int? maxLines;
  final int? minLines;
  final Function(String)? onChanged;
  final int? borderWidth;
  final String? validation;
  final String? Function(String?)? validationFunction;
  bool? filled;
  final void Function()? onEditingComplete;
  PasswordMasterTextField({
    Key? key,
    this.autofocus,
    this.inputFormatters,
    this.hinttextColor,
    this.filled = false,
    this.fieldWidth,
    this.elevation,
    this.shadowColor,
    this.borderColor,
    this.textFieldColor,
    this.suffixIconHeight,
    this.iconHeight,
    this.controller,
    this.fieldHeight,
    this.errorText,
    required this.hintText,
    this.hintStyle,
    this.enabled,
    this.borderWidth,
    this.borderRadius,
    this.isPassword = false,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixText,
    this.suffixColor,
    this.sidePadding,
    this.maxLines,
    this.minLines,
    this.onChanged,
    this.validation,
    this.validationFunction,
    this.onEditingComplete,
  }) : super(key: key);

  @override
  State<PasswordMasterTextField> createState() =>
      _PasswordMasterTextFieldState();
}

class _PasswordMasterTextFieldState extends State<PasswordMasterTextField> {
  @override
  Widget build(BuildContext context) {
    return SidePadding(
      sidePadding: widget.sidePadding ?? 0,
      child: TextFormField(
        textDirection: TextDirection.ltr,
        onEditingComplete: widget.onEditingComplete,
        controller: widget.controller,
        onChanged: widget.onChanged,
        validator: widget.validationFunction ??
            (value) {
              if (value!.isEmpty) {
                return widget.validation;
              }
              return null;
            },
        keyboardType: widget.keyboardType,
        inputFormatters:
            widget.inputFormatters ?? [ArabicNumberTextInputFormatter()],
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: widget.isPassword ?? false,
        maxLines: widget.maxLines ?? 1,
        minLines: widget.minLines ?? 1,
        autofocus: widget.autofocus ?? false,
        style: TextStyles.textViewBold18.copyWith(color: greyColor),
        enabled: widget.enabled,
        decoration: InputDecoration(
          errorMaxLines: 2,
          fillColor: widget.textFieldColor ?? white,
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                widget.isPassword = !widget.isPassword!;
              });
            },
            child: widget.isPassword! == true
                ? const Icon(
                    Icons.visibility_off,
                    color: mainColor,
                  )
                : const Icon(
                    Icons.visibility,
                    color: mainColor,
                  ),
          ),
          filled: widget.filled,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(
                  widget.borderRadius == null ? 10.r : widget.borderRadius!.r)),
              borderSide: BorderSide(
                color: greyColor,
                width: widget.borderWidth == null ? 1.w : widget.borderWidth!.w,
                style: BorderStyle.solid,
              )),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(
                  widget.borderRadius == null ? 10.r : widget.borderRadius!.r)),
              borderSide: BorderSide(
                color: greyColor,
                width: widget.borderWidth == null ? 1.w : widget.borderWidth!.w,
                style: BorderStyle.solid,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(
                  widget.borderRadius == null ? 10.r : widget.borderRadius!.r)),
              borderSide: BorderSide(
                color: greyColor,
                width: widget.borderWidth == null ? 1.w : widget.borderWidth!.w,
                style: BorderStyle.solid,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(
                  widget.borderRadius == null ? 10.r : widget.borderRadius!.r)),
              borderSide: BorderSide(
                color: greyColor,
                width: widget.borderWidth == null ? 1.w : widget.borderWidth!.w,
                style: BorderStyle.solid,
              )),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(
                  widget.borderRadius == null ? 10.r : widget.borderRadius!.r)),
              borderSide: BorderSide(
                color: widget.errorText != null ? Colors.red : greyColor,
                width: widget.borderWidth == null ? 1.w : widget.borderWidth!.w,
                style: BorderStyle.solid,
              )),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(
                  widget.borderRadius == null ? 10.r : widget.borderRadius!.r)),
              borderSide: BorderSide(
                color: widget.errorText != null ? Colors.red : greyColor,
                width: widget.borderWidth == null ? 1.w : widget.borderWidth!.w,
                style: BorderStyle.solid,
              )),
          hintText: widget.hintText,
          hintStyle: widget.hintStyle ??
              TextStyles.textViewMedium15
                  .copyWith(color: widget.hinttextColor ?? hintColor),
        ),
      ),
    );
  }
}
