import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/side_padding.dart';

class AuthBodyDecoration extends StatelessWidget {
  final Widget child;
  const AuthBodyDecoration({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SidePadding(
      sidePadding: 35,
      child: Material(
        elevation: 0,
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15.r),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.2),
            borderRadius: BorderRadius.circular(15.r),
          ),
          padding: EdgeInsets.only(top: 30.h, left: 20.w, right: 20.w, bottom: 25.h,),
          child: child,
        ),
      ),
    );
  }
}
