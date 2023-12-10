import 'package:flutter/material.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/widgets/space.dart';

class Details extends StatelessWidget {
  final String title;
  final String data;
  const Details({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyles.textViewRegular13
                  .copyWith(color: const Color(0xffAFAFAF)),
            ),
            const Space(
              height: 10,
            ),
            Text(
              data,
              style: TextStyles.textViewRegular13
                  .copyWith(color: const Color(0xffAFAFAF)),
            ),
          ],
        ),
      ),
    );
  }
}

class Details2 extends StatelessWidget {
  final String title;
  final String data;
  final Color? dataColor;
  const Details2(
      {super.key,
      required this.title,
      required this.data,
      this.dataColor = white});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyles.textViewRegular15
                  .copyWith(color: const Color(0xffAFAFAF)),
            ),
            const Space(
              height: 15,
            ),
            Text(
              data,
              style: TextStyles.textViewBold16.copyWith(color: dataColor),
            ),
          ],
        ),
      ),
    );
  }
}
