import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/colors/colors.dart';

class HomeProductCard extends StatelessWidget {
  final String image;
  const HomeProductCard({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(10.r),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10.0.r)),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: mainColor)),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10.0.r)),
              child: CachedNetworkImage(
                placeholder: ((context, url) =>
                    Image.asset("assets/images/logo_image.png")),
                imageUrl: image,
                width: 400.w,
                fit: BoxFit.fill,
                height: 220.h,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
