import 'package:aquar/core/widgets/side_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/styles/styles.dart';
import '../constant/size_config.dart';
import 'space.dart';

class MasterButton extends StatelessWidget {
  final Color? buttonColor;
  final Color? borderColor;
  final Color? iconColor;
  final double? buttonHeight;
  final double? buttonWidth;
  final double? buttonRadius;
  final double? sidePadding;
  final double? iconSize;
  final IconData? icon;
  final String buttonText;
  final TextStyle? buttonStyle;
  final VoidCallback? onPressed;
  final Object tag;
  final IconData? secIcon;
  final BorderRadiusDirectional radius;

  const MasterButton({
    Key? key,
    required this.buttonText,
    this.buttonColor,
    this.borderColor,
    this.buttonHeight,
    this.buttonRadius,
    this.buttonWidth,
    this.buttonStyle,
    this.onPressed,
    this.sidePadding,
    this.icon,
    this.iconColor,
    this.iconSize,
    this.secIcon,
    this.radius = BorderRadiusDirectional.zero,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: SidePadding(
        sidePadding: sidePadding ?? 0,
        child: ElevatedButton(
          onPressed: onPressed,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          style: ElevatedButton.styleFrom(
            foregroundColor: white,
            backgroundColor: buttonColor ?? mainColor,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: borderColor ?? mainColor,
                width: 2,
              ),
              borderRadius: buttonRadius == null
                  ? radius
                  : BorderRadius.all(Radius.circular(
                      buttonRadius == null ? 10.r : buttonRadius!.r)),
            ),
          ),
          child: SizedBox(
            height: buttonHeight == null ? 70.h : buttonHeight!.h,
            width:
                buttonWidth == null ? SizeConfig.screenWidth : buttonWidth!.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                secIcon != null
                    ? Icon(
                        secIcon,
                        size: iconSize,
                        color: iconColor,
                      )
                    : const SizedBox(),
                const Space(
                  width: 10,
                ),
                Text(
                  buttonText,
                  style: buttonStyle ??
                      TextStyles.textViewMedium20.copyWith(color: white),
                  textAlign: TextAlign.center,
                ),
                icon != null
                    ? Icon(
                        icon,
                        size: iconSize,
                        color: iconColor,
                      )
                    // Image.asset(
                    //     icon!,
                    //     height: iconSize,
                    //     color: iconColor,
                    //   )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
