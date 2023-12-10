import 'package:flutter/material.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/dimenssions/screenutil.dart';
import '../../../../core/constant/styles/styles.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final bool onTap;
  const TitleWidget({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        width: screenWidth / 4,
        height: 45,
        decoration: BoxDecoration(
            color: onTap ? mainColor : blackColor.withOpacity(.8),
            boxShadow: const [
              BoxShadow(color: white, spreadRadius: 0, blurRadius: 0),
            ],
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(
              color:onTap ? mainColor : blackColor.withOpacity(.8)
            )
        ),
        child: Center(
          child: FittedBox(
            child: Text(
              title,
              style: TextStyles.textViewBold16.copyWith(color: onTap ? white : greyColor),
            ),
          ),
        ),
      ),
    );
  }
}
