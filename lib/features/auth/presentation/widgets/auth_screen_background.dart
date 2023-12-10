import 'package:flutter/material.dart';

import '../../../../core/constant/images.dart';

class AuthScreenBackground extends StatelessWidget {
  const AuthScreenBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      background,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.fill,
    );
  }
}
