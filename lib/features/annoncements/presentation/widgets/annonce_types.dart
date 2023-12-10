import 'package:aquar/core/constant/colors/colors.dart';
import 'package:aquar/core/constant/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnnonceTypes extends StatelessWidget {
  final String title;
  final String amount;
  final String image;
  const AnnonceTypes(
      {super.key,
      required this.title,
      required this.amount,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: lightBlackColor),
            borderRadius: BorderRadius.circular(10),
            color: lightBlackColor),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SvgPicture.asset(
                    image,
                    color: white,
                  ),
                ),
              ),
            ),
            Text(
              title,
              style: TextStyles.textViewRegular16.copyWith(color: white),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: lightGrey,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Center(
                  child: Text(
                    amount,
                    style: TextStyles.textViewBold16.copyWith(color: white),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
