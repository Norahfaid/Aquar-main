// import 'dart:io';
//
// import 'package:dotted_border/dotted_border.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_native_image/flutter_native_image.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:image_picker/image_picker.dart';
//
// import '../../../core/constant/colors/colors.dart';
//
// class GetImageFromCameraAndGellary extends StatelessWidget {
//   final Function(File) onPickImage;
//   final bool isVideo;
//   final bool isFile;
//
//   GetImageFromCameraAndGellary(
//       {Key? key,
//         required this.onPickImage,
//         this.isVideo = false,
//         this.isFile = false})
//       : super(key: key);
//
//   final ImagePicker _picker = ImagePicker();
//
//   Future getImagefromcamera() async {
//     final pickedFile = await _picker.pickImage(
//       source: ImageSource.camera,
//       // imageQuality: 50,
//       maxHeight: 4000,
//       maxWidth: 3000,
//     );
//     if (pickedFile != null) {
//       File compressedFile = await FlutterNativeImage.compressImage(
//           pickedFile.path,
//           quality: 70,
//           percentage: 70);
//       onPickImage(compressedFile);
//     } else {}
//   }
//
//   Future getImagefromgallary() async {
//     final pickedFile = await _picker.pickImage(
//       source: ImageSource.gallery,
//       // imageQuality: 50,
//     );
//
//     // setState(() {
//     if (pickedFile != null) {
//       File compressedFile = await FlutterNativeImage.compressImage(
//           pickedFile.path,
//           quality: 70,
//           percentage: 70);
//       onPickImage(compressedFile);
//     } else {}
//     // });
//   }
//
//   // Future getFile() async {
//   //   FilePickerResult? result = await FilePicker.platform
//   //       .pickFiles(type: FileType.custom, allowedExtensions: ['pdf', 'doc']);
//   //   if (result != null) {
//   //     File file = File(result.files.single.path!);
//   //     onPickImage(file);
//   //     //  Uint8List fileBytes = result.files.first.bytes!;
//   //     return file;
//   //   } else {}
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
//       ListTile(
//         leading: const Icon(
//           Icons.photo,
//           size: 25,
//           color: mainColor,
//         ),
//         title: Text(
//           // ignore: deprecated_member_use
//           tr('gallery'),
//           style: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         onTap: () {
//           getImagefromgallary();
//           Navigator.of(context).pop();
//         },
//       ),
//       ListTile(
//         leading: const Icon(
//           Icons.camera_alt_outlined,
//           size: 25,
//           color: mainColor,
//         ),
//         title: Text(
//           // ignore: deprecated_member_use
//           tr('camera'),
//           style: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         onTap: () async {
//           getImagefromcamera();
//           Navigator.pop(context);
//         },
//       ),
//       // isFile == false
//       //     ? const SizedBox()
//       //     : ListTile(
//       //   leading: const Icon(
//       //     Icons.file_copy,
//       //     size: 25,
//       //     color: mainColor,
//       //   ),
//       //   title: Text(
//       //     // ignore: deprecated_member_use
//       //     tr('pdf'),
//       //     style: const TextStyle(
//       //       fontSize: 16,
//       //       fontWeight: FontWeight.w600,
//       //     ),
//       //   ),
//       //   onTap: () async {
//       //     // getFile();
//       //     Navigator.pop(context);
//       //   },
//       // ),
//     ]);
//   }
// }
//
// class UploadImageCreateWidget extends StatelessWidget {
//   final Function() function;
//   final String text;
//   final String message;
//   final Color color;
//   final Widget widget;
//   const UploadImageCreateWidget(
//       {super.key,
//         required this.function,
//         required this.text,
//         required this.message,
//         required this.color,
//         required this.widget});
//
//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: const BorderRadius.all(Radius.circular(5)),
//       child: Center(
//         child: UploadProductFilesWidget(
//           onTapDialog: function,
//           title: 'commercial_Register',
//           text: text,
//           message: message,
//           borderColor: color,
//           onTap: () {
//             showModalBottomSheet(
//                 elevation: 3,
//                 shape: const RoundedRectangleBorder(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(10),
//                       topRight: Radius.circular(10),
//                     )),
//                 context: context,
//                 builder: (_) {
//                   return widget;
//                 });
//           },
//         ),
//       ),
//     );
//   }
// }
