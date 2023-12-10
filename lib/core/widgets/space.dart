import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Space extends StatelessWidget {
  final double width;
  final double height;
  const Space({Key? key, this.height = 0, this.width = 0})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      width: width.w,
    );
  }
}
