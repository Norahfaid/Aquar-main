import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant/colors/colors.dart';
import '../constant/styles/styles.dart';

class SearchTextFeild extends StatefulWidget {
  final double? sidePadding;
  final double? fieldHeight;
  final double? fieldWidth;
  final double? iconHeight;
  final double? suffixIconHeight;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? isPassword;
  final bool? autofocus;
  final Color? borderColor;
  final Color? textFieldColor;
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
//final List<TextInputFormatter>? inputFormatters;
  final Color? suffixColor;
  final Color? fillColor;
  final Function()? onTap;
  final int? maxLines;
  final int? minLines;
  final Function(String)? onChanged;
  final int? borderWidth;
  final Function(String)? onSubmit;
  final String? Function(String?)? validate;
  final void Function(String?)? onSaved;
  final TextDirection? textDirection;
  const SearchTextFeild({
    Key? key,
    this.autofocus,
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
    this.textDirection = TextDirection.ltr,
    this.hintStyle,
    this.enabled,
    this.borderWidth,
    this.borderRadius,
    this.isPassword,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixText,
    this.suffixColor,
    this.sidePadding,
    this.maxLines,
    this.minLines,
    this.onChanged,
    this.onSubmit,
    this.onSaved,
    this.validate,
    this.fillColor,
    this.onTap,
    // this.inputFormatters,
  }) : super(key: key);

  @override
  State<SearchTextFeild> createState() => _SearchTextFeildState();
}

class _SearchTextFeildState extends State<SearchTextFeild> {
  TextDirection? textDirection;

  @override
  void initState() {
    super.initState();
    textDirection = widget.textDirection;
  }

  void _checkForArabicLetter(String text) {
    final arabicRegex = RegExp(r'[ء-ي-_ \.]*$');
    final englishRegex = RegExp(r'[a-zA-Z ]');
    setState(() {
      text.contains(arabicRegex) && !text.startsWith(englishRegex)
          ? textDirection = TextDirection.rtl
          : textDirection = TextDirection.ltr;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: TextFormField(
        onTapOutside: (p) {
          FocusScope.of(context).unfocus();
        },
        //autocorrect: true,
        cursorColor: mainColor,
        controller: widget.controller,
        onChanged: (value) {
          _checkForArabicLetter(value);
          if (widget.onChanged != null) widget.onChanged!(value);
        },
        keyboardType: widget.keyboardType,
        obscureText: widget.isPassword ?? false,
        maxLines: widget.maxLines ?? 1, textDirection: textDirection,
        minLines: widget.minLines ?? 1,
        autofocus: widget.autofocus ?? false,
        style: TextStyles.textViewBold18.copyWith(color: mainColor),
        enabled: widget.enabled,
        onSaved: widget.onSaved,
        validator: widget.validate,
        onFieldSubmitted: widget.onSubmit,
        // inputFormatters: inputFormatters,
        decoration: InputDecoration(
          fillColor: widget.fillColor ?? blackColor.withOpacity(.9),
          // fillColor: widget.fillColor,
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(
                  widget.borderRadius == null ? 15.r : widget.borderRadius!.r)),
              borderSide: BorderSide(
                color: Colors.transparent,
                width: widget.borderWidth == null ? 1.w : widget.borderWidth!.w,
                style: BorderStyle.solid,
              )),
          //focusedBorder: InputBorder.none,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(
                  widget.borderRadius == null ? 15.r : widget.borderRadius!.r)),
              borderSide: BorderSide(
                color: Colors.transparent,
                width: widget.borderWidth == null ? 1.w : widget.borderWidth!.w,
                style: BorderStyle.solid,
              )),

          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(
                  widget.borderRadius == null ? 15.r : widget.borderRadius!.r)),
              borderSide: BorderSide(
                color: Colors.transparent,
                width: widget.borderWidth == null ? 1.w : widget.borderWidth!.w,
                style: BorderStyle.solid,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(
                  widget.borderRadius == null ? 15.r : widget.borderRadius!.r)),
              borderSide: BorderSide(
                color: Colors.transparent,
                width: widget.borderWidth == null ? 1.w : widget.borderWidth!.w,
                style: BorderStyle.solid,
              )),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(
                  widget.borderRadius == null ? 15.r : widget.borderRadius!.r)),
              borderSide: BorderSide(
                color: Colors.transparent,
                width: widget.borderWidth == null ? 1.w : widget.borderWidth!.w,
                style: BorderStyle.solid,
              )),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(
                  widget.borderRadius == null ? 15.r : widget.borderRadius!.r)),
              borderSide: BorderSide(
                color: Colors.transparent,
                width: widget.borderWidth == null ? 1.w : widget.borderWidth!.w,
                style: BorderStyle.solid,
              )),
          hintText: widget.hintText,
          hintStyle: TextStyles.textViewRegular16.copyWith(
            color: greyColor,
          ),
          suffixIconColor: widget.suffixColor,

          suffixIcon: widget.suffixIcon,
          // suffixIcon: widget.suffixIcon == null
          //     ? null
          //     : Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Padding(
          //             padding: EdgeInsets.only(top: 8.h),
          //             child: widget.suffixIcon!,
          //           ),
          //         ],
          //       ),
          prefixIcon: widget.prefixIcon == null
              ? null
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: Image.asset(widget.prefixIcon!,
                          color: mainColor,
                          height: widget.iconHeight == null
                              ? 20.h
                              : widget.iconHeight!.h,
                          fit: BoxFit.contain),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
