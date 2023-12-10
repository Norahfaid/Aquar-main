import 'package:aquar/features/settings/presentation/widgets/upload_image22.dart';
import 'package:flutter/material.dart';

class UploadImageCreateWidget extends StatelessWidget {
  final Function() function;
  final String text;
  final String message;
  final Color color;
  final Widget widget;
  const UploadImageCreateWidget(
      {super.key,
        required this.function,
        required this.text,
        required this.message,
        required this.color,
        required this.widget});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      child: Center(
        child: UploadProductFilesWidget(
          onTapDialog: function,
          title: 'commercial_Register',
          text: text,
          message: message,
          borderColor: color,
          onTap: () {
            showModalBottomSheet(
                elevation: 3,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )),
                context: context,
                builder: (_) {
                  return widget;
                });
          },
        ),
      ),
    );
  }
}
