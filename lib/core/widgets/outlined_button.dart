import 'package:flutter/material.dart';
import '../constant/colors/colors.dart';
import '../constant/dimenssions/screenutil.dart';

/// OutLined Button
class MyOutlinedButton extends StatelessWidget {
  final Function() onTap;
  final String text;
  const MyOutlinedButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: screenHeight / 14,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        border: Border.all(color: brownColor),
        borderRadius: BorderRadius.circular(5),
      ),
      child: MaterialButton(
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              //  height: getHeight(context)/29,
              // width: getWidth(context)/8,
              child: Image(image: AssetImage('assets/images/google.png')),
            ),
            Text(
              text,
              style: const TextStyle(
                color: brownColor,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
