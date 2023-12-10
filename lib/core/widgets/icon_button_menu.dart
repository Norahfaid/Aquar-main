import 'divider.dart';
import 'icon_button_card.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/styles/styles.dart';
import '../constant/colors/colors.dart';

class IconButtonMenu extends StatelessWidget {
  const IconButtonMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        position: PopupMenuPosition.under,
        offset: const Offset(0, 15),
        // iconSize: 30,
        // icon: const IconButtonCard(
        //   icon: Icons.keyboard_arrow_down,
        //   iconSize: 70,
        //   avtarColor: redColor,
        // ),
        // icon: const CircleAvatar(
        //   backgroundColor: white,
        //   maxRadius: 50,
        //   child: Icon(
        //     Icons.keyboard_arrow_down,
        //     size: 30,
        //   ),
        // ),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
                child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'الاستماع للايات',
                    style: TextStyles.textViewMedium20
                        .copyWith(color: textDarkColor),
                  ),
                  const MyDivider(),
                ],
              ),
            )),
            PopupMenuItem(
                child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'الاستماع للتفسير',
                    style: TextStyles.textViewMedium20
                        .copyWith(color: textDarkColor),
                  ),
                  const MyDivider(),
                ],
              ),
            )),
            PopupMenuItem(
                child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'الاستماع للايات والتفسير',
                    style: TextStyles.textViewMedium20
                        .copyWith(color: textDarkColor),
                  ),
                ],
              ),
            )),
          ];
        },
        child: const IconButtonCard(icon: Icons.keyboard_arrow_down));
  }
}
