// import 'package:aquar/core/widgets/select_photo_button.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class SelectPhoto extends StatelessWidget {
//   final Function(ImageSource source) onTap;
//   const SelectPhoto({super.key, required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // color: greyColor.shade300,
//       padding: const EdgeInsets.all(20),
//       child: Stack(
//         alignment: AlignmentDirectional.topCenter,
//         clipBehavior: Clip.none,
//         children: [
//           Positioned(
//             top: -35,
//             child: Container(
//               width: 50,
//               height: 6,
//               margin: const EdgeInsets.only(bottom: 20),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(2.5),
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Column(children: [
//             SelectPhotoButton(
//               onTap: () => onTap(ImageSource.gallery),
//               icon: Icons.image,
//               textLabel: 'Browse Gallery',
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             const Center(
//               child: Text(
//                 'OR',
//                 style: TextStyle(fontSize: 18),
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             SelectPhotoButton(
//               onTap: () => onTap(ImageSource.camera),
//               icon: Icons.camera_alt_outlined,
//               textLabel: 'Use a Camera',
//             ),
//           ])
//         ],
//       ),
//     );
//   }
// }
