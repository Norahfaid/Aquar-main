import 'package:easy_localization/easy_localization.dart' as e;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constant/styles/styles.dart';
import '../constant/colors/colors.dart';
import 'arabic_input.dart';

// ignore: must_be_immutable
class PhoneFormFeild extends StatefulWidget {
  final TextEditingController controller;
  final bool obSecure;
  bool isClickable;
  final TextInputType keyboardType;
  TextDirection? textDirection;

  final String? Function(String?)? validation;
  final String hintText;
  Function()? onTap;
  Function()? clicked;
  IconData? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final String? prefixIcon;
  final Function(String)? onChanged;
  Widget? widget;
  Function? validateFunction;
  PhoneFormFeild({
    Key? key,
    required this.controller,
    this.isClickable = true,
    this.obSecure = false,
    this.keyboardType = TextInputType.text,
    this.validation,
    this.textDirection = TextDirection.ltr,
    required this.hintText,
    this.onTap,
    this.clicked,
    this.suffixIcon,
    this.widget,
    this.validateFunction,
    this.prefixIcon,
    this.onChanged,
    this.inputFormatters,
  }) : super(key: key);

  @override
  State<PhoneFormFeild> createState() => _PhoneFormFeildState();
}

class _PhoneFormFeildState extends State<PhoneFormFeild> {
  bool secure = false;
  TextDirection? textDirection;
  String? fontFamily;
  @override
  void initState() {
    super.initState();
    textDirection = widget.textDirection;
    if (widget.keyboardType == TextInputType.number) {
      fontFamily = "Almarai";
    }
  }

  void _checkForArabicLetter(String text) {
    final arabicRegex = RegExp(r'[ء-ي-_ \.]*$');
    final englishRegex = RegExp(r'[a-zA-Z ]');
    final spi = RegExp("[\$&+,:;=?@#|'<>.^*()%!-]+");
    final numbers = RegExp("^[0-9]*\$");
    setState(() {
      text.contains(arabicRegex) &&
              !text.startsWith(englishRegex) &&
              !text.startsWith(spi) &&
              !text.startsWith(numbers)
          ? textDirection = TextDirection.rtl
          : textDirection = TextDirection.ltr;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          e.EasyLocalization.of(context)!.currentLocale!.languageCode == "en"
              ? TextDirection.ltr
              : TextDirection.rtl,
      child: TextFormField(
        maxLines: 1,

        inputFormatters:
            widget.inputFormatters ?? [ArabicNumberTextInputFormatter()],
        textDirection: widget.textDirection,
        enabled: widget.isClickable,

        onChanged: (value) {
          _checkForArabicLetter(value);
          if (widget.onChanged != null) widget.onChanged!(value);
        },
        // onChanged: widget.onChanged,

        style: TextStyles.textViewMedium20
            .copyWith(color: mainColor, fontFamily: "Almarai"),
        decoration: InputDecoration(
          filled: false,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          labelStyle: TextStyles.textViewRegular20.copyWith(color: mainColor),
          fillColor: mainColor.withOpacity(.06),
          // contentPadding:const EdgeInsets.symmetric(vertical: 15),
          prefixIcon: e.EasyLocalization.of(context)!
                      .currentLocale!
                      .languageCode ==
                  "en"
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                  child: Text("+966",
                      style: TextStyles.textViewRegular20.copyWith(
                        color: mainColor,
                      ),
                      textDirection: TextDirection.ltr),
                )
              : null,
          // prefixIcon:Padding(
          //   padding: const EdgeInsets.all(15),
          //   child: Image.asset(widget.prefixIcon!, fit: BoxFit.contain ,height: 10, ),
          // ),
          hintText: widget.hintText,
          hintStyle: TextStyles.textViewRegular20.copyWith(color: greyColor),
          suffixIcon:
              e.EasyLocalization.of(context)!.currentLocale!.languageCode !=
                      "en"
                  ? Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text("+966",
                          style: TextStyles.textViewRegular20.copyWith(
                            color: mainColor,
                          ),
                          textDirection: TextDirection.ltr),
                    )
                  : null,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(
              color: mainColor.withOpacity(.6),
              width: 1,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(
              color: mainColor.withOpacity(.6),
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(
              color: mainColor.withOpacity(.6),
              width: 1,
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: mainColor.withOpacity(.6),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        obscureText: widget.obSecure,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        validator: widget.validation,
      ),
    );
  }
}
