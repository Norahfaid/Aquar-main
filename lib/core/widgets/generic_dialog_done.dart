import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../constant/colors/colors.dart';
import '../constant/styles/styles.dart';
import 'main_button.dart';

class GenericDialogDone extends StatelessWidget {
  final String titleText;
  final String textButton;
  final String imageLotti;
  final Function()? onPressedButon;

  const GenericDialogDone(
      {super.key,
      required this.titleText,
      required this.textButton,
      this.onPressedButon,
      required this.imageLotti});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(45.0),
            bottomRight: Radius.circular(45.0),
            topLeft: Radius.circular(0),
            bottomLeft: Radius.circular(45.0)),
      ),
      title: Column(
        children: [
          SizedBox(
            height: 120.h,
            child: Lottie.asset(imageLotti),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            titleText,
            style: TextStyles.textViewBold20.copyWith(color: textdialogColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: MainButton(
              buttonWidth: 250.w,
              text: textButton,
              onPressed: onPressedButon,
            ),
          ),
        ],
      ),
    );
  }
}
