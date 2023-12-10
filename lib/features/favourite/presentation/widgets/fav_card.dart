import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/dimenssions/screenutil.dart';
import '../../../../core/constant/images.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/widgets/space.dart';

// ignore: must_be_immutable
class FavCard extends StatefulWidget {
  final String? imgUrl;
  final String? productName;
  final String curreny;
  final String price;
  final String location;
  final Widget icon;
  final String distance;
  final String date;
  final bool fromDashboard;

  const FavCard(
      {Key? key,
      this.imgUrl,
      this.productName,
      required this.curreny,
      required this.price,
      required this.location,
      required this.distance,
      required this.date,
      required this.icon,
      required this.fromDashboard,
      })
      : super(key: key);

  @override
  State<FavCard> createState() => _FavCardState();
}

class _FavCardState extends State<FavCard> {
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
        child: Material(
          color: lightBlackColor,
          borderRadius: BorderRadius.circular(15.r),
          elevation: 6,
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              FittedBox(
                child: Container(
                  color: lightBlackColor,
                  padding: EdgeInsets.only(top: widget.fromDashboard? 48.h: 16.h, right: 8.w, bottom: 16.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 90.w,
                        child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.r)),
                            child: CachedNetworkImage(
                                errorWidget: (context, url, error) =>
                                    Image.asset(logoImage),
                                imageUrl: widget.imgUrl!,
                                fit: BoxFit.cover,
                                width: 150.w,
                                height: 130.h)),
                      ),
                      SizedBox(
                        width: screenWidth / 1.4,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.productName!,
                                    style: TextStyles.textViewRegular16
                                        .copyWith(color: white),
                                  ),
                                ],
                              ),
                              const Space(height: 5),
                              Text(
                                "${widget.price} ${widget.curreny}",
                                style: TextStyles.textViewBold16
                                    .copyWith(color: white),
                              ),
                              const Space(height: 5),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    marker,
                                    color: mainColor,
                                    height: 15,
                                  ),
                                  const Space(width: 5),
                                  Flexible(
                                    child: Text(
                                      widget.location,
                                      style: TextStyles.textViewMedium16
                                          .copyWith(color: textColor),
                                      maxLines: 3,
                                    ),
                                  ),
                                ],
                              ),
                              const Space(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  FittedBox(
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          area,
                                          color: mainColor,
                                          height: 15,
                                        ),
                                        const Space(width: 5),
                                        Text(
                                          "${widget.distance} ${tr("m")}",
                                          style: TextStyles.textViewMedium16
                                              .copyWith(color: textColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                  FittedBox(
                                    child: Text(
                                      widget.date,
                                      style: TextStyles.textViewMedium16
                                          .copyWith(
                                              color: lightGrey.withOpacity(.7)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ///Mohamed Alusifer Buildings
              Positioned(
                right: 0,
                top: 0,
                child: Offstage(
                  offstage: !widget.fromDashboard,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: iconBackground.withOpacity(.9),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.r),
                        bottomLeft: Radius.circular(10.r),
                      ),
                      // border: Border.all(
                      //   color: mainColor,
                      // ),
                    ),
                    child: Center(
                      child: Text(
                        tr('mohammed_alusaifer_aqars'),
                        style: TextStyles.textViewMedium12.copyWith(
                          color: mainColor,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r),
                  ),
                  color: Colors.red,
                ),
                child: widget.icon,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
