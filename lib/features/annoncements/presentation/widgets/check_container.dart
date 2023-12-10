import 'package:flutter/material.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/dimenssions/screenutil.dart';
import '../../../../core/constant/styles/styles.dart';

class CheckContainer extends StatelessWidget {
  final void Function(bool?)? onTap1;
  final void Function(bool?)? onTap2;
  final bool value1;
  final bool value2;
  final String text1;
  final String text2;
  const CheckContainer(
      {super.key,
      required this.onTap1,
      required this.onTap2,
      required this.value1,
      required this.value2,
      required this.text1,
      required this.text2});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Container(
              height: 50,
              decoration: const BoxDecoration(
                color: lightBlackColor,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              width: screenWidth / 2,
              child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  checkColor: blackColor,
                  title: Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: Text(text1,
                        style: TextStyles.textViewRegular15
                            .copyWith(color: textColor)),
                  ),
                  activeColor: mainColor,
                  value: value1,
                  side: const BorderSide(color: mainColor, width: 2),
                  onChanged: onTap1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Container(
              height: 50,
              decoration: const BoxDecoration(
                color: lightBlackColor,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              width: screenWidth / 2,
              child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  checkColor: blackColor,
                  title: Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: Text(text2,
                        style: TextStyles.textViewRegular15
                            .copyWith(color: textColor)),
                  ),
                  activeColor: mainColor,
                  value: value2,
                  side: const BorderSide(color: mainColor, width: 2),
                  onChanged: onTap2),
            ),
          ),
        ],
      ),
    );
  }
}
