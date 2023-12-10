import 'package:flutter/material.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/styles/styles.dart';

class CheckBoxWidge extends StatelessWidget {
  final String title;
  final bool value;
  // final IconData icon;
  final void Function(bool?) onTap;
  const CheckBoxWidge({
    super.key,
    required this.title,
    required this.value,
    required this.onTap,
    // required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        dense: false,
        contentPadding: EdgeInsets.zero,
        visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
        checkColor: blackColor,
        // tristate: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 7),
          child: Text(title,
              style: TextStyles.textViewRegular18.copyWith(color: textColor)),
        ),
        activeColor: mainColor,
        value: value,
        side: const BorderSide(color: mainColor, width: 2),
        onChanged: onTap);
  }
}
//  Row(
//       children: [
//         Icon(
//           icon,
//           color: mainColor,
//         ),
//         const Space(
//           boxWidth: 5,
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 7),
//           child: FittedBox(
//             child: Text(title,
//                 style: TextStyles.textViewRegular15.copyWith(color: textColor)),
//           ),
//         ),
//       ],
//     );