import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ErrorImage extends StatelessWidget {
  const ErrorImage({Key? key,this.width,this.height}) : super(key: key);
  final double?width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "",fit: BoxFit.fill,
      height: height!.h,width: width!.w,
    );
  }
}
