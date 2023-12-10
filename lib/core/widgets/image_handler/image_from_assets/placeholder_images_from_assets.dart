import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/size_config.dart';

class PlaceHolderImage extends StatelessWidget {
  const PlaceHolderImage(
      {Key? key, this.height, this.width, this.fit, this.image})
      : super(key: key);
  final double? width;
  final double? height;
  final BoxFit? fit;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image ?? "",
      fit: fit ?? BoxFit.fill,
      height: height == null ? SizeConfig.screenHeight! / 4 : height!.h,
      width: width == null ? SizeConfig.screenWidth : width!.w,
    );
  }
}
