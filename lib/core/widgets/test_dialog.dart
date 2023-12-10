import 'package:aquar/core/constant/styles/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constant/colors/colors.dart';
import '../constant/styles/styles.dart';
import 'main_button.dart';

class TestDialog extends StatelessWidget {
  final String titleText;
  final String textButton;
  final String imageLotti;
  final Function()? onPressedButon;

  const TestDialog(
      {super.key,
      required this.titleText,
      required this.textButton,
      this.onPressedButon,
      required this.imageLotti});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      title: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            "مبروك",
            style: TextStyles.textViewBold20.copyWith(color: textdialogColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "حصلت علي نسبة 90% (ممتاز)",
            style: TextStyles.textViewBold20.copyWith(color: textdialogColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "عدد اسئلة الاختبار",
                style: TextStyles.textViewMedium22.copyWith(color: mainColor),
                textAlign: TextAlign.center,
              ),
              Text(
                "20",
                style:
                    TextStyles.textViewBold20.copyWith(color: textdialogColor),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          sizedBoxh10,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "عدد الاحابات الصحيحة ",
                style: TextStyles.textViewMedium22
                    .copyWith(color: textdialogColor),
                textAlign: TextAlign.center,
              ),
              Text(
                "18",
                style:
                    TextStyles.textViewBold20.copyWith(color: textdialogColor),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          sizedBoxh10,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "عدد  الاجابات الخاطئة",
                style: TextStyles.textViewMedium22
                    .copyWith(color: textdialogColor),
                textAlign: TextAlign.center,
              ),
              Text(
                "2",
                style:
                    TextStyles.textViewBold20.copyWith(color: textdialogColor),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Center(
            child: MainButton(
              buttonWidth: double.infinity,
              text: textButton,
              onPressed: onPressedButon,
            ),
          ),
          sizedBoxh20,
          Center(
            child: MainButton(
              buttonWidth: double.infinity,
              text: textButton,
              onPressed: onPressedButon,
            ),
          ),
        ],
      ),
    );
  }
}
