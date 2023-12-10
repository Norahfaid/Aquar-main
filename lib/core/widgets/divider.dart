import 'package:flutter/material.dart';

import '../constant/colors/colors.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1.50,
      color: greyColor.withOpacity(.2),
    );
  }
}

///vertical Divider Widget
class MyVerticalDivider extends StatelessWidget {
  const MyVerticalDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      color: greyColor.withOpacity(.2),
    );
  }
}
