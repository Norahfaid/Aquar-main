import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/styles/styles.dart';
import 'space.dart';

class DrawerWidget extends StatelessWidget {
  final String title;
  final String image;
  final Color? textColor2;
  final Function() onTap;
  const DrawerWidget({
    Key? key,
    this.textColor2 = white,
    required this.title,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 55,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                image,
                color: mainColor,
                height: 30.h,
              ),
              const Space(
                width: 10,
              ),
              Text(
                title,
                style: TextStyles.textViewRegular20.copyWith(color: textColor2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
