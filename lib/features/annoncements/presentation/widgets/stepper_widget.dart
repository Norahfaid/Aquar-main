// import 'package:flutter/material.dart';

// import '../../../../core/constant/colors/colors.dart';

// class StepperWidget extends StatefulWidget {
//   final String? x;
//   final ValueSetter<int>? myValueSetter;
//   const StepperWidget({Key? key, this.x, this.myValueSetter}) : super(key: key);

//   @override
//   State<StepperWidget> createState() => _StepperWidgetState();
// }

// class _StepperWidgetState extends State<StepperWidget> {
//   final int _index = 0;
//   bool isActive = true;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.red),
//         borderRadius: BorderRadius.circular(
//           10.0,
//         ),
//       ),
//       child: Theme(
//         data: ThemeData(
//           ///primarySwatch:  MaterialColor(0xffF48A36, ),
//           canvasColor: mainColor,
//           colorScheme: const ColorScheme.light(primary: mainColor)
//               .copyWith(background: Colors.green),
//         ),
//         child: Stepper(
//           elevation: 1,
//           controlsBuilder: (BuildContext context, ControlsDetails controls) {
//             return const SizedBox();
//           },
//           type: StepperType.horizontal,
//           steps: [
//             Step(
//               // isActive:isActive,
//               title: Text(widget.x!),
//               content: const SizedBox(
//                 height: 1,
//               ),
//             ),
//             const Step(
//               //  isActive:isActive,
//               //state:_index >1? StepState.complete:StepState.indexed,
//               title: Text("Confirmed"),
//               content: SizedBox(
//                 height: 1,
//               ),
//             ),
//             const Step(
//               // isActive: isActive ,
//               title: Text("Delivered"),
//               content: SizedBox(
//                 height: 1,
//               ),
//             ),
//           ],
//           currentStep: _index,
//           onStepTapped: (index) {
//             widget.myValueSetter!(index);
//             // setState(() {
//             //   _index = index;
//             //
//             // });
//           },
//         ),
//       ),
//     );
//   }
// }
