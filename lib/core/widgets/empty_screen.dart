import 'package:flutter/material.dart';

import '../../../core/constant/colors/colors.dart';
import '../../../core/constant/styles/styles.dart';
import '../../../core/widgets/space.dart';

class EmptyScreen extends StatelessWidget {
  final String image;
  final String title;
  const EmptyScreen({Key? key, required this.image, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image),
        const Space(
          height: 50,
        ),
        Text(
          title,
          style: TextStyles.textViewMedium25.copyWith(color: mainColor),
        ),
      ],
    );
  }
}
