import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/styles/styles.dart';
import '../../../../core/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/dimenssions/screenutil.dart';

class AnnounceTapItem extends StatelessWidget {
  final void Function()? onTap;
  final String image;
  final Color titleColor;
  final String title;
  final String subtitle;
  final Color? imageColor;
  final String? pngImage;

  final Color borderColor;
  final bool isSelected;
  final bool? png;

  const AnnounceTapItem({
    this.pngImage,
    this.isSelected = false,
    this.png = false,
    required this.borderColor,
    required this.image,
    required this.titleColor,
    required this.title,
    this.subtitle = '',
    this.imageColor,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: isSelected ? screenHeight / 4 : screenHeight / 6,
        width: screenWidth,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(10),
          color: lightBlackColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            png!
                ? SizedBox(
                    height: 80,
                    width: 130,
                    child: Image.asset(
                      (pngImage!),
                      // fit: BoxFit.fitWidth,
                      height: screenHeight / 8,
                    ),
                  )
                : SvgPicture.asset(
                    image,
                    height: isSelected ? 60 : 30,
                    color: imageColor,
                  ),
            isSelected
                ? const Space(
                    height: 0,
                  )
                : const Space(
                    height: 16,
                  ),
            isSelected
                ? const Space(
                    height: 0,
                  )
                : Text(
                    title,
                    style: TextStyles.textViewMedium16.copyWith(
                      color: titleColor,
                    ),
                    maxLines: 1,
                  ),
            Space(
              height: subtitle.isEmpty ? 0 : 8,
            ),
            subtitle.isEmpty
                ? const Space(
                    height: 0,
                  )
                : Text(
                    subtitle,
                    style: TextStyles.textViewRegular16.copyWith(
                      color: titleColor,
                      fontSize: 13.r,
                    ),
                    maxLines: 1,
                  ),
          ],
        ),
      ),
    );
  }
}
