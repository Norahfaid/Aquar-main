import 'package:aquar/core/constant/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constant/colors/colors.dart';
import '../constant/dimenssions/screenutil.dart';

class GradiantButton extends StatelessWidget {
  final String title;
  final VoidCallback? tap;
  final double? fillHeight;
  final double? borderRadius;
  final double? buttonWidth;
  final Color? firstColor;
  final Color? secondColor;
  final TextStyle? bottomStyle;
  final Color? borderColor;
  const GradiantButton({
    Key? key,
    required this.title,
    this.tap,
    this.firstColor,
    this.secondColor,
    this.fillHeight,
    this.borderRadius,
    this.buttonWidth,
    this.bottomStyle,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(3.0),
        child: GestureDetector(
          onTap: () {
            tap!();
          },
          child: Container(
            height: 66.h,
            padding: EdgeInsets.all(fillHeight ?? 10.0),
            width: buttonWidth ?? screenWidth,
            decoration: BoxDecoration(
                border: borderColor == null
                    ? null
                    : Border.all(color: borderColor!, width: 2),
                boxShadow: const [
                  BoxShadow(color: white, spreadRadius: 0, blurRadius: 0),
                ],
                borderRadius:
                    BorderRadius.all(Radius.circular(borderRadius ?? 10.0.r)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    secondColor ?? mainColor,
                    firstColor ?? lightMainColor,
                  ],
                )),
            child: Center(
              child: Text(
                title,
                style: bottomStyle ??
                    TextStyles.textViewMedium15.copyWith(color: white),
              ),
            ),
          ),
        ));
  }
}
