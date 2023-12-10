import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../injection_container/injection_container.dart';
import '../constant/colors/colors.dart';
import '../constant/styles/styles.dart';
import '../util/app_navigator.dart';

// ignore: non_constant_identifier_names
DefaultAppBar(
    {required String title,
    Color? titleColor,
    Color? backPressedColor,
    bool isBack = false,
    bool? isProfile,
    Widget? icon1,
    Widget? icon2,
    Widget? leadingIcon,
    Color? backgroundColor,
    Function()? ontapLeading,
    // String? actionIcon,
    VoidCallback? backPressed}) {
  return AppBar(
    backgroundColor: backgroundColor ?? transparent,
    elevation: 0.0,
    centerTitle: true,
    title: Text(
      title,
      style: TextStyles.textViewBold20.copyWith(color: titleColor ?? white),
    ),
    leadingWidth: 110.w,
    leading: IconButton(
        onPressed: ontapLeading,
        icon: leadingIcon ??
            const Icon(
              Icons.arrow_back_ios,
              size: 25,
            )
        // IconButtonCard(
        //   // avtarColor: white,
        //   iconColor: mainColor,
        //   icon: Icons.keyboard_arrow_right,
        //   onTap: () {
        //     AppNavigator.pop( );
        //   },
        // ),
        ),
    actions: [
      isBack
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () {
                  sl<AppNavigator>().pop();
                },
                child: const Icon(
                  Icons.close,
                  color: white,
                ),
              ),
            )
          : const SizedBox()
    ],
  );
}
