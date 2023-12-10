import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant/styles/styles.dart';

/// Button
class DefaultButton extends StatelessWidget {
  final Function() onTap;
  final String text;
  final Color buttonColor;
  final Color textColor;
  const DefaultButton({
    Key? key,
    required this.onTap,
    required this.text,
    required this.buttonColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Container(
        width: double.infinity,
        // height: screenHeight / 8,
        height: 52.h,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: buttonColor,
        ),
        child: MaterialButton(
          onPressed: onTap,
          child: Text(text,
              style: TextStyles.textViewBold15.copyWith(color: textColor)),
        ),
      ),
    );
  }
}

// /// OutLined Button
// class MyOutlinedButton extends StatelessWidget {
//   final Function() onTap;
//   final String text;
//   const MyOutlinedButton({Key? key,
//     required this.onTap,
//     required this.text,
//    }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height:screenHeight/14,
//       clipBehavior:Clip.antiAliasWithSaveLayer ,
//       decoration:  BoxDecoration(
//           border: Border.all(color: buttonColor),
//         borderRadius: BorderRadius.circular(5),
//       ),
//       child: MaterialButton(
//         onPressed:
//         onTap,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//               height: getHeight(context)/29,
//               width: getWidth(context)/8,
//               child:const Image(image: AssetImage('assets/images/google.png')),
//             ),
//             Text(text,style: const TextStyle(color: buttonColor,fontSize: 18.0,
//               fontWeight: FontWeight.bold,),),
//           ],
//         ),
//       ),
//     );
//   }
// }