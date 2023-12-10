import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../constant/colors/colors.dart';
import '../constant/styles/styles.dart';

class FailureScreen extends StatelessWidget {
  const FailureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/lottie/error.json',
            width: 200,
            height: 200,
          ),
          const SizedBox(height: 15),
          Text(tr('error'),
              style: TextStyles.textViewBold20.copyWith(color: mainColor)),
        ],
      ),
    );
  }
}
