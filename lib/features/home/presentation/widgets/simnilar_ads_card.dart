import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/dimenssions/screenutil.dart';
import '../../../../core/constant/images.dart';
import '../../../../core/constant/styles/sized_box.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/widgets/space.dart';

// ignore: must_be_immutable
class SimilarAdsCard extends StatefulWidget {
  final String? imgUrl;
  final String productName;
  final String currency;
  final String price;
  final String area;
  const SimilarAdsCard({
    Key? key,
    this.imgUrl,
    required this.productName,
    required this.currency,
    required this.price,
    required this.area,
  }) : super(key: key);

  @override
  State<SimilarAdsCard> createState() => _SimilarAdsCardState();
}

class _SimilarAdsCardState extends State<SimilarAdsCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: FittedBox(
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20.r)),
          child: Material(
            color: lightBlackColor,
            borderRadius: BorderRadius.circular(15.r),
            elevation: 6,
            child: Container(
              color: lightBlackColor,
              width: screenWidth / 1.4,
              padding: const EdgeInsets.only(top: 10, right: 10, bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 90.w,
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20.r)),
                        child: CachedNetworkImage(
                            errorWidget: (context, url, error) =>
                                Image.asset(logoImage),
                            imageUrl: widget.imgUrl ??
                                "https://i.pinimg.com/564x/47/bf/09/47bf097208c3ec72818dd504bd73af11.jpg",
                            fit: BoxFit.cover,
                            width: 150.w,
                            height: 100.h)),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 180.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sizedBoxh10,
                        Text(
                          widget.productName,
                          style: TextStyles.textViewRegular16
                              .copyWith(color: white),
                        ),
                        const Space(height: 15),
                        Text(
                          widget.price + widget.currency,
                          style:
                              TextStyles.textViewBold16.copyWith(color: white),
                        ),
                        const Space(height: 15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              area,
                              color: mainColor,
                              height: 15,
                            ),
                            const Space(
                              width: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                "${widget.area} ${tr("m2")}",
                                style: TextStyles.textViewRegular16
                                    .copyWith(color: white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
