import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GradiantContainerWidget extends StatelessWidget {
  const GradiantContainerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 240.h,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          end: Alignment.bottomRight,
          begin: Alignment.topRight,
          colors: [
            Colors.white.withOpacity(0),
            Colors.white.withOpacity(0),
            Colors.white.withOpacity(.0),
            Colors.white.withOpacity(.5),
            Colors.white.withOpacity(.5),
            Colors.white.withOpacity(.6),
            Colors.white.withOpacity(.7),
            Colors.white.withOpacity(.8),
            Colors.white.withOpacity(.9),
            Colors.white.withOpacity(.91),
            Colors.white.withOpacity(.92),
            Colors.white.withOpacity(.93),
            Colors.white.withOpacity(.94),
          ],
        )));
  }
}
