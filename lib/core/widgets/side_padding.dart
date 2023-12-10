import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SidePadding extends StatelessWidget {
  final double sidePadding;
  final Widget? child;
  const SidePadding({Key? key, this.child, this.sidePadding = 0})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: sidePadding.w, right: sidePadding.w),
      child: child,
    );
  }
}
