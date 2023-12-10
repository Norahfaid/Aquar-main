import 'package:aquar/core/constant/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant/styles/styles.dart';

class MainButton extends StatelessWidget {
  const MainButton(
      {super.key,
      required this.text,
      this.onPressed,
      required this.buttonWidth,
      this.textColor = white,
      this.buttonColor = mainColor});
  final String text;
  final Color textColor;
  final Color buttonColor;
  final double buttonWidth;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 53.h,
      width: buttonWidth,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
          alignment: Alignment.center,
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          )),
        ),
        child: FittedBox(
          child: Text(text,
              style: TextStyles.textViewMedium15.copyWith(color: textColor)),
        ),
      ),
    );
  }
}
