import 'package:flutter/material.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/widgets/space.dart';

class NotificationsCard extends StatelessWidget {
  final bool isRead;
  final String title;
  final String message;
  final String time;
  const NotificationsCard(
      {super.key,
      required this.isRead,
      required this.title,
      required this.message,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isRead ? const Color(0xff312E2D) : const Color(0xff1D1D1D),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                isRead
                    ? const SizedBox(
                        width: 10,
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: mainColor,
                        ))
                    : const SizedBox(
                        width: 10,
                      ),
                isRead
                    ? const SizedBox(
                        width: 4,
                      )
                    : const SizedBox(
                        width: 0,
                      ),
                Text(
                  title,
                  style:
                      TextStyles.textViewRegular15.copyWith(color: textColor),
                ),
              ],
            ),
            const Space(height: 10),
            Text(
              message,
              style: TextStyles.textViewRegular12.copyWith(color: greyColor),
            ),
            const Space(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  time,
                  textAlign: TextAlign.end,
                  style:
                      TextStyles.textViewRegular12.copyWith(color: greyColor),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
