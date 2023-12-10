import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constant/size_config.dart';
import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../core/widgets/side_padding.dart';

class BuildDropDown<T> extends StatelessWidget {
  final double? buttonHeight;
  final double? buttonWidth;
  final Color? textColor;
  final double? buttonRadius;
  final Color? dropdownColor;
  final Color? buildDropColor;
  final Color? buildDropBorderColor;
  final Widget? icon;
  final bool isExpanded;
  final String hint;
  // final String? image;
  final dynamic value;
  final dynamic onChange;
  final List<DropdownMenuItem<T>> items;

  const BuildDropDown({
    Key? key,
    this.dropdownColor,
    this.buildDropColor,
    this.textColor,
    this.icon,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonRadius,
    required this.isExpanded,
    required this.hint,
    required this.value,
    required this.onChange,
    required this.items,
    // this.image,
    this.buildDropBorderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        //  Container(
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(20), color: mainColor),
        //   child:
        DropdownButtonHideUnderline(
      child: LimitedBox(
        maxHeight: buttonHeight ?? 70.h,
        maxWidth: buttonWidth ?? SizeConfig.screenWidth!,
        child: Container(
          decoration: BoxDecoration(
              color: buildDropColor ?? mainColor,
              border: Border.all(
                color: buildDropBorderColor ?? white,
                width: 1.w,
              ),
              borderRadius: BorderRadius.circular(buttonRadius ?? 30.r)),
          child: SidePadding(
            sidePadding: 10,
            child: DropdownButton<T>(
              isExpanded: isExpanded,
              elevation: 0,
              hint: Text(
                hint,
                style: TextStyles.textViewRegular20
                    .copyWith(color: textColor ?? mainColor),
              ),
              icon: icon ??
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: mainColor,
                    size: 30,
                  ),
              dropdownColor: dropdownColor ?? white,
              style: TextStyles.textViewMedium15.copyWith(color: mainColor),
              borderRadius: BorderRadius.circular(4.r),
              value: value,
              onChanged: onChange,
              items: items,
            ),
          ),
        ),
      ),
      //  ),
    );
  }
}
