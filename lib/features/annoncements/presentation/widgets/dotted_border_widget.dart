import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/dimenssions/screenutil.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/widgets/space.dart';

class DottedBorderWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  const DottedBorderWidget(
      {super.key,
      required this.title,
      this.icon = Icons.cloud_upload_outlined});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      radius: const Radius.circular(12),
      strokeWidth: 1,
      color: lightGrey.withOpacity(.8),
      padding: const EdgeInsets.all(6),
      dashPattern: const [7, 3],
      borderType: BorderType.RRect,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Container(
          height: 100,
          width: screenWidth,
          color: lightBlackColor,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: mainColor,
                ),
                const Space(
                  height: 10,
                ),
                Text(
                  title,
                  style: TextStyles.textViewMedium15.copyWith(color: mainColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DottedBorderFilledWidget extends StatelessWidget {
  final Widget widget;
  const DottedBorderFilledWidget({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      radius: const Radius.circular(12),
      strokeWidth: 1,
      // color: lightGrey.withOpacity(.8),
      padding: const EdgeInsets.all(6),
      dashPattern: const [7, 3],
      borderType: BorderType.RRect,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: SizedBox(
          height: 100,
          width: screenWidth,
          // color: lightBlackColor,
          child: const Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
