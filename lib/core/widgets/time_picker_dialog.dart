// import 'space.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

// import '../../injection_container/injection_container.dart';
// import '../constant/colors/colors.dart';
// import '../constant/styles/styles.dart';
// import '../util/app_navigator.dart';
// import 'main_button.dart';

// class TimeDialog extends StatefulWidget {
//   const TimeDialog({super.key});

//   @override
//   State<TimeDialog> createState() => _TimeDialogState();
// }

// class _TimeDialogState extends State<TimeDialog> {
//   DateTime _dateTime = DateTime.now();
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: white,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
//       title: FittedBox(
//         child: Column(
//           children: <Widget>[
//             const SizedBox(
//               height: 20,
//             ),
//             Text(
//               tr("daily_reminder"),
//               style:
//                   TextStyles.textViewMedium20.copyWith(color: dialogTitleColor),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             hourMinute12H(),
//             // hourMinute15Interval(),
//             // hourMinuteSecond(),
//             // hourMinute12HCustomStyle(),
//             // Container(
//             //   margin: const EdgeInsets.symmetric(vertical: 50),
//             //   child: Text(
//             //     '${_dateTime.hour.toString().padLeft(2, '0')}:${_dateTime.minute.toString().padLeft(2, '0')}:${_dateTime.second.toString().padLeft(2, '0')}',
//             //     style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             //   ),
//             // ),
//             const SizedBox(
//               height: 20,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 MainButton(
//                   text: "حفظ",
//                   buttonWidth: 135.w,
//                   buttonColor: mainColor,
//                   onPressed: () {
//                     sl<AppNavigator>().pop();
//                     // showDialog(
//                     //     context: context,
//                     //     builder: (BuildContext context) {
//                     //       return SendMessageDialog(
//                     //         lottie: successLottie,
//                     //         buttonWidth: 200.w,
//                     //         tap: () {
//                     //           AppNavigator.push(
//                     //               context: context,
//                     //               screen: const StudyPlansTabViewScreen());
//                     //         },
//                     //         buttonText: tr("ok"),
//                     //         text:
//                     //             "تم إنشاء الخطة الدراسية وسيتم تذكيرك بالورد اليومي يوميا",
//                     //       );
//                     //     });
//                   },
//                   textColor: white,
//                 ),
//                 const Space(boxWidth: 10),
//                 MainButton(
//                   text: "تراجع",
//                   buttonWidth: 135.w,
//                   buttonColor: redColor,
//                   onPressed: () {
//                     sl<AppNavigator>().pop();
//                   },
//                   textColor: white,
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// SAMPLE
//   Widget hourMinute12H() {
//     return TimePickerSpinner(
//       normalTextStyle:
//           TextStyle(fontSize: 24, color: greyColor.withOpacity(.6)),
//       highlightedTextStyle:
//           const TextStyle(fontSize: 24, color: dialogTitleColor),
//       is24HourMode: false,
//       onTimeChange: (time) {
//         setState(() {
//           _dateTime = time;
//         });
//       },
//     );
//   }

//   Widget hourMinuteSecond() {
//     return TimePickerSpinner(
//       isShowSeconds: true,
//       onTimeChange: (time) {
//         setState(() {
//           _dateTime = time;
//         });
//       },
//     );
//   }

//   Widget hourMinute15Interval() {
//     return TimePickerSpinner(
//       spacing: 40,
//       minutesInterval: 15,
//       onTimeChange: (time) {
//         setState(() {
//           _dateTime = time;
//         });
//       },
//     );
//   }

//   Widget hourMinute12HCustomStyle() {
//     return TimePickerSpinner(
//       is24HourMode: false,
//       normalTextStyle:
//           TextStyle(fontSize: 24, color: greyColor.withOpacity(.3)),
//       highlightedTextStyle: const TextStyle(fontSize: 24, color: Colors.black),
//       spacing: 50,
//       itemHeight: 80,
//       isForce2Digits: true,
//       minutesInterval: 15,
//       onTimeChange: (time) {
//         setState(() {
//           _dateTime = time;
//         });
//       },
//     );
//   }
// }
