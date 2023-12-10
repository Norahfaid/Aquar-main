import 'package:flutter/material.dart';

import '../../../../core/constant/colors/colors.dart';

class CancelconButton extends StatelessWidget {
  const CancelconButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: const Padding(
        padding: EdgeInsets.only(top: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 15,
            ),
            CircleAvatar(
                backgroundColor: white,
                radius: 10,
                child: Icon(
                  Icons.close,
                  size: 15,
                  color: textDarkColor,
                )),
          ],
        ),
      ),
    );
  }
}
