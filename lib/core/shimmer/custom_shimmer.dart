import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../constant/colors/colors.dart';

class CustomShimmer extends StatelessWidget {
  final Widget child;

  const CustomShimmer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: greyColor.withOpacity(0.3),
      highlightColor: greyColor.withOpacity(0.1),
      child: child,
    );
  }
}
