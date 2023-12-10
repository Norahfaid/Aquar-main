import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../features/auth/presentation/cubit/auto_login/auto_login_cubit.dart';
import '../../features/favourite/presentation/cubit/toggle_fav/cubit/toggle_fav_cubit.dart';
import '../../features/home/domain/models/filter.dart';
import '../../injection_container/injection_container.dart';
import '../constant/colors/colors.dart';
import '../constant/images.dart';
import '../constant/styles/sized_box.dart';
import '../constant/styles/styles.dart';
import 'loading_widget.dart';
import 'space.dart';
import 'toast.dart';

// ignore: must_be_immutable
class HomeCard extends StatefulWidget {
  final AnnounceData filterData;
  final VoidCallback tap;
  final String? imgUrl;
  final String? productName;
  final String curreny;
  final bool issold;
  final String views;
  final String price;
  final String location;
  final String date;
  final String distance;
  final int advId;

  final bool isFavorite;

  const HomeCard({Key? key,
    required this.tap,
    required this.issold,
    this.imgUrl,
    required this.advId,
    this.productName,
    required this.isFavorite,
    required this.views,
    required this.curreny,
    required this.price,
    required this.location,
    required this.date,
    required this.distance,
    required this.filterData})
      : super(key: key);

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  bool? isFavoriteLocal;

  @override
  void didUpdateWidget(covariant HomeCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget = widget;
    isFavoriteLocal = widget.isFavorite;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    isFavoriteLocal = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.tap,
      child: FittedBox(
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20.r)),
          child: Material(
            color: lightBlackColor,
            borderRadius: BorderRadius.circular(15.r),
            elevation: 6,
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
              Container(
              color: lightBlackColor,
              margin: EdgeInsets.only(
                  top: widget.filterData.fromDashboard ? 32 : 32),
              padding:
              const EdgeInsets.only(top: 10, right: 10, bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 130.w,
                    height: 205.h,
                    child: ClipRRect(
                        borderRadius:
                        BorderRadius.all(Radius.circular(20.r)),
                        child: CachedNetworkImage(
                            errorWidget: (context, url, error) =>
                                Image.asset(logoImage),
                            imageUrl: widget.imgUrl!,
                            fit: BoxFit.cover,
                            width: 170.w,
                            height: 100.h)),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 290.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sizedBoxh10,
                        Text(
                          widget.productName!,
                          style: TextStyles.textViewRegular16
                              .copyWith(color: white),
                        ),
                        const Space(height: 15),
                        FittedBox(
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 200,
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      tag,
                                      color: mainColor,
                                      height: 15,
                                    ),
                                    const Space(width: 5),
                                    Flexible(
                                      child: Text(
                                        "${widget.price} ${widget.curreny}",
                                        style: TextStyles.textViewMedium16
                                            .copyWith(color: textColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // SizedBox(
                              //   width: 100,
                              //   child: Row(
                              //     children: [
                              //       SvgPicture.asset(
                              //         marker,
                              //         color: mainColor,
                              //         height: 15,
                              //       ),
                              //       const Space(boxWidth: 5),
                              //       Flexible(
                              //         child: Text(
                              //           widget.location,
                              //           style: TextStyles.textViewMedium16
                              //               .copyWith(color: textColor),
                              //           maxLines: 2,
                              //           overflow: TextOverflow.ellipsis,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // )
                            ],
                          ),
                        ),
                        const Space(
                          height: 10,
                        ),
                        FittedBox(
                          child: SizedBox(
                            width: 105,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  area,
                                  color: mainColor,
                                  height: 15,
                                ),
                                const Space(width: 5),
                                Text(
                                  widget.distance + tr("m"),
                                  style: TextStyles.textViewMedium16
                                      .copyWith(color: textColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Space(
                          height: 10,
                        ),
                        FittedBox(
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 100,
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      clock,
                                      color: mainColor,
                                      height: 15,
                                    ),
                                    const Space(width: 5),
                                    Text(
                                      widget.date,
                                      style: TextStyles.textViewMedium16
                                          .copyWith(color: textColor),
                                    ),
                                  ],
                                ),
                              ),
                              const Space(
                                width: 30,
                              ),
                              // FittedBox(
                              //   child: SizedBox(
                              //     width: 100,
                              //     child: Row(
                              //       children: [
                              //         SvgPicture.asset(
                              //           area,
                              //           color: mainColor,
                              //           height: 15,
                              //         ),
                              //         const Space(boxWidth: 5),
                              //         Text(
                              //           widget.distance,
                              //           style: TextStyles.textViewMedium16
                              //               .copyWith(color: textColor),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        const Space(
                          height: 10,
                        ),
                        SizedBox(
                          // width: 100,
                          child: Row(
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
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Space(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: mainColor,
                                  size: 17,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  widget.views,
                                  style: TextStyles.textViewMedium18
                                      .copyWith(color: mainColor),
                                ),
                              ],
                            ),
                            widget.issold
                                ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(5),
                                  border: Border.all(
                                    color: mainColor,
                                    width: 1.w,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.check,
                                        color: mainColor,
                                        size: 17,
                                      ),
                                      const Space(
                                        width: 3,
                                      ),
                                      Text(
                                        tr("sold"),
                                        style: TextStyles
                                            .textViewMedium18
                                            .copyWith(
                                            color: mainColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                                : const SizedBox(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            ///Mohamed Alusifer Buildings
            Positioned(
              right: 0,
              top: 0,

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
                  child: !widget.filterData.fromDashboard ? Text(
                    tr('تسويق مشاريع شركات خارجيه'),
                    style: TextStyles.textViewMedium14.copyWith(
                      color: white,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ) : Text(
                    tr('mohammed_alusaifer_aqars'),
                    style: TextStyles.textViewMedium14.copyWith(
                      color: mainColor,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),

                ),
              ),

          ),

          BlocProvider(
            create: (context) => sl<ToggleFavCubit>(),
            child: BlocConsumer<ToggleFavCubit, ToggleFavState>(
                listener: (context, state) {
                  if (state is TogglefavouritiesErrorState) {
                    showToast(state.message);
                  }
                  if (state is TogglefavouritiesSuccessState) {
                    //   context.read<FilterCubit>().unitCurrentPage();
                    //  context.read<FilterCubit>().fgetFilterData();

                    widget.filterData.toggleFav();
                    showToast(!isFavoriteLocal! == true
                        ? tr("deleted_successfully")
                        : tr("added_to_fav_successfully"));
                  }
                }, builder: (context, state) {
              if (state is TogglefavouritiesLoadingState) {
                return const Loading();
              }
              return InkWell(
                onTap: () =>
                    sl<AutoLoginCubit>().loginOrFunction(
                        context: context,
                        function: () {
                          setState(() {
                            isFavoriteLocal = !isFavoriteLocal!;
                          });
                          context
                              .read<ToggleFavCubit>()
                              .fToggleFavourities(id: widget.advId);
                        }),
                child: Container(
                    width: 45,
                    height: 35,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: iconBackground.withOpacity(.9),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20.r),
                      ),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        isFavoriteLocal! ? heart : like,
                        color: mainColor,
                        height: 15,
                      ),
                    )),
              );
            }),
          ),
          ],
        ),
      ),
    ),
    )
    ,
    );
  }
}
