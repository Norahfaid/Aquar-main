import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/dimenssions/screenutil.dart';
import '../../../../../core/constant/styles/styles.dart';

class UploadProductFilesWidget extends StatelessWidget {
  final String title;
  final String text;
  final String message;
  final Color borderColor;
  final Function() onTap;
  final Function() onTapDialog;
  const UploadProductFilesWidget(
      {super.key,
      required this.title,
      required this.onTapDialog,
      required this.message,
      required this.text,
      required this.onTap,
      required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tr("product_image"),
                style: TextStyles.textViewBold20.copyWith(color: mainColor),
              ),
              TextButton(
                onPressed: onTapDialog,
                child: Text(
                  tr("show_image"),
                  style: TextStyles.textViewMedium18.copyWith(color: mainColor),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          DottedBorder(
            radius: const Radius.circular(12),
            strokeWidth: 1,
            color: borderColor,
            padding: const EdgeInsets.all(6),
            dashPattern: const [9, 6],
            borderType: BorderType.RRect,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Container(
                height: 100,
                width: screenWidth,
                color: Colors.white.withOpacity(.1),
                child: InkWell(
                  onTap: onTap,
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.cloud_upload_outlined,
                                color: mainColor,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                text,
                                style: TextStyles.textViewMedium15
                                    .copyWith(color: mainColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 5,
                        right: 105,
                        child: Text(
                          message,
                          style: TextStyles.textViewMedium15
                              .copyWith(color: mainColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
