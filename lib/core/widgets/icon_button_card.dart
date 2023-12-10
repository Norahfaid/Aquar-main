import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constant/colors/colors.dart';

class IconButtonCard extends StatelessWidget {
  final IconData? icon;
  final Color iconColor;
  final bool isImage;
  final double? radiusSize;
  final String? image;
  final double imageHeight;
  final Color? avtarColor;
  final Color? imageColor;
  final Function()? onTap;
  final double? iconSize;
  final Color? color1;
  final Color? color2;
  final double? paddingImage;
  const IconButtonCard(
      {super.key,
      this.icon,
      this.imageColor = white,
      this.iconColor = white,
      this.onTap,
      this.iconSize = 25,
      this.avtarColor,
      this.isImage = false,
      this.image,
      this.radiusSize,
      this.color1,
      this.color2,
      this.imageHeight = 25,
      this.paddingImage = 15});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: avtarColor ?? mainColor,
        radius: radiusSize ?? 25,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color1 ?? blackColor,
                color2 ?? blackColor,
              ],
            ),
          ),
          child: isImage
              ? Padding(
                  padding: EdgeInsets.all(paddingImage!),
                  child: SvgPicture.asset(
                    image!,
                    height: imageHeight,
                    color: imageColor!,
                  ),
                )
              : Center(
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: iconSize,
                  ),
                ),
        ),
      ),
    );
  }
}
