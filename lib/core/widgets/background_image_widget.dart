import 'package:flutter/material.dart';

import '../constant/dimenssions/screenutil.dart';

class BackgroundImageWidget extends StatelessWidget {
  final Widget child;
  final String backgroundImage;
  const BackgroundImageWidget(
      {Key? key, required this.child, required this.backgroundImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          backgroundImage,
          width: screenWidth,
          height: screenHeight,
          fit: BoxFit.cover,
        ),
        child,
      ],
    );
  }
}
