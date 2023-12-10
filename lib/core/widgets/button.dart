import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant/styles/styles.dart';

/// Button
class DefaultButton extends StatelessWidget {
  final Function() onTap;
  final String text;
  final Color buttonColor;
  final Color textColor;
  const DefaultButton({
    Key? key,
    required this.onTap,
    required this.text,
    required this.buttonColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Container(
        width: double.infinity,
        // height: screenHeight / 8,
        height: 52.h,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: buttonColor,
        ),
        child: MaterialButton(
          onPressed: onTap,
          child: Text(text,
              style: TextStyles.textViewBold18.copyWith(color: textColor)),
        ),
      ),
    );
  }
}
