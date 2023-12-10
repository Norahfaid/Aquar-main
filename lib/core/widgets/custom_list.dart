import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant/dimenssions/screenutil.dart';

class CustomList extends StatelessWidget {
  final Widget Function(BuildContext, int)? child;
  final int count;
  final Axis axis;
  final double listHeight;
  final ScrollPhysics? scroll;
  final double? listWidth;
  final double? itemExtent;
  final ScrollController? controller;
  const CustomList(
      {Key? key,
      this.child,
      this.controller,
      this.axis = Axis.vertical,
      this.count = 1,
      this.listWidth,
      this.listHeight = 5,
      this.itemExtent,
      this.scroll})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxHeight: listHeight.h,
      maxWidth: listWidth == null ? screenWidth : listWidth!.w,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        controller: controller,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        physics: scroll,
        itemExtent: itemExtent,
        scrollDirection: axis,
        shrinkWrap: true,
        itemCount: count,
        itemBuilder: child!,
      ),
    );
  }
}
