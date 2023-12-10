import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/dimenssions/screenutil.dart';
import '../../../../core/constant/extenions.dart';
import '../../../../core/constant/images.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/util/app_navigator.dart';
import '../../../../core/widgets/gradiant_button.dart';
import '../../../../core/widgets/icon_button_card.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/space.dart';
import '../../../../core/widgets/toast.dart';
import '../../../../injection_container/injection_container.dart';
import '../../../auth/presentation/cubit/auto_login/auto_login_cubit.dart';
import '../../../dynamic_link.dart';
import '../../../favourite/presentation/cubit/toggle_fav/cubit/toggle_fav_cubit.dart';
import '../../../map/presentation/cubit/pick_map/pick_map_cubit.dart';
import '../../../settings/presentation/cubit/social_links/cubit/social_links_cubit.dart';
import '../../../update_ad/presentation/pages/edit_ad.dart';
import '../../domain/models/filter.dart';
import '../cubit/aquar_details/cubit/aquar_details_cubit.dart';
import '../cubit/home_cubit.dart';
import '../cubit/similar_ads/cubit/similar_ads_cubit.dart';
import '../cubit/update_annoncement/cubit/update_annoncement_cubit.dart';
import '../widgets/ads_card.dart';
import '../widgets/details_container.dart';
import '../widgets/property_info_widget.dart';
import '../widgets/simnilar_ads_card.dart';
import 'video_screen.dart';

class AquarDetailsScreen extends StatefulWidget {
// final int adUserId;
  final AnnounceData data;
  final bool fromUnderReview;
  final bool fromMap;
  final bool aqratScreen;
  const AquarDetailsScreen(
      {super.key,
      // required this.adUserId ,
      required this.fromUnderReview,
      this.aqratScreen = false,
      required this.data,
      this.fromMap = false});

  @override
  State<AquarDetailsScreen> createState() => _AquarDetailsScreenState();
}

class _AquarDetailsScreenState extends State<AquarDetailsScreen> {
  bool agree = false;
  bool? isFavoriteLocal;
  late final ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    context
        .read<AquarDetailsCubit>()
        .fAquarDetails(id: widget.data.id, fromDetails: true);
    isFavoriteLocal = widget.data.isFavorite;
    context.read<SimilarAdsCubit>().fGetSimilarAds(
          isFirst: true,
          id: widget.data.id,
          map: 1,
          buildingTypeId: widget.data.buildingType.id.toString(),
          // status: 'published'
        );
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<SimilarAdsCubit>().fGetSimilarAds(
              id: widget.data.id, map: 1,
              buildingTypeId: widget.data.buildingType.id.toString(),
              // status: 'published'
            );
      }
    });
    context.read<SocialLinksCubit>().fSocialLinks();
    // context.read<FilterCubit>().mineAds(adUserId: ,userId:context.read<LoginCubit>().user.id );
  }

  Future<void> _createDynamicLink(
      bool short, String link, String message) async {
    await createDynamicLink(short, link, message);
  }

  bool isLoading = false;
  Future<void> _createDynamicLinkToShare(
      bool short, String link, String message) async {
    await createDynamicLinkToShare(short, link, message);
  }

  bool loading = false;
  toggleLoading() {
    setState(() {
      loading = !loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final filterBloc = context.watch<FilterCubit>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(alignment: Alignment.bottomCenter, children: [
        Stack(
          children: [
            AdsCard(
              sliders: widget.data.aqarImages,
              image: widget.data.icon,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, right: 20, left: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      loading
                          ? const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(mainColor),
                            )
                          : IconButtonCard(
                              icon: Icons.keyboard_arrow_right,
                              avtarColor: lightBlackColor,
                              isImage: false,
                              onTap: widget.aqratScreen
                                  ? () {
                                      toggleLoading();
                                      context
                                          .read<FilterCubit>()
                                          .fgetFilterData(
                                            map: 1,
                                            isFirst: true,
                                            buildingtype: context
                                                .read<FilterCubit>()
                                                .buildingTypeSelectedId,
                                          );
                                      toggleLoading();
                                      context
                                          .read<FilterCubit>()
                                          .selectedMarker = null;
                                      sl<AppNavigator>().pop();
                                    }
                                  : widget.fromMap
                                      ? () async {
                                          toggleLoading();
                                          context
                                              .read<FilterCubit>()
                                              .fgetFilterData(
                                                map: 1,
                                                isFirst: true,
                                                isNearest: true,
                                                buildingtype: context
                                                    .read<FilterCubit>()
                                                    .buildingTypeSelectedId,
                                                latLang: (await context
                                                        .read<PickMapCubit>()
                                                        .getUserAccessLocation())
                                                    .latLngFromPostion()
                                                    .toStringServer(),
                                              );
                                          toggleLoading();
                                          sl<AppNavigator>().pop();
                                        }
                                      : () async {
                                          toggleLoading();
                                          context
                                              .read<FilterCubit>()
                                              .fgetFilterData(
                                                map: 1,
                                                isFirst: true,
                                                isNearest: false,
                                                buildingtype: context
                                                    .read<FilterCubit>()
                                                    .buildingTypeSelectedId,
                                              );
                                          toggleLoading();
                                          sl<AppNavigator>().pop();
                                        },
                              color1: lightBlackColor,
                              color2: lightBlackColor,
                              iconSize: 30,
                              radiusSize: 20,
                            ),
                      BlocConsumer<ToggleFavCubit, ToggleFavState>(
                          listener: (context, state) {
                        if (state is TogglefavouritiesErrorState) {
                          showToast(state.message);
                        }
                        if (state is TogglefavouritiesSuccessState) {
                          context.read<FilterCubit>().toggleFav(widget.data);
                          // context
                          //     .read<FilterCubit>()
                          //     .fgetFilterData(widget.data.buildingType.id);
                          //  context.read<FilterCubit>().fgetFilterData();
                          showToast(!isFavoriteLocal! == true
                              ? tr("deleted_successfully")
                              : tr("added_to_fav_successfully"));
                        }
                      }, builder: (context, state) {
                        if (state is TogglefavouritiesLoadingState) {
                          return const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(mainColor),
                          );
                        }
                        return IconButtonCard(
                            image: isFavoriteLocal! ? heart : like,
                            isImage: true,
                            avtarColor: blackColor,
                            color1: lightBlackColor,
                            color2: lightBlackColor,
                            imageHeight: 30,
                            paddingImage: 10,
                            radiusSize: 20,
                            onTap: () => sl<AutoLoginCubit>().loginOrFunction(
                                  context: context,
                                  function: () {
                                    setState(() {
                                      isFavoriteLocal = !isFavoriteLocal!;
                                    });
                                    context
                                        .read<ToggleFavCubit>()
                                        .fToggleFavourities(id: widget.data.id);
                                  },
                                ));
                      }),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(mainColor),
                              ),
                            )
                          : IconButtonCard(
                              icon: Icons.share,
                              avtarColor: lightBlackColor,
                              isImage: false,
                              onTap: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                await _createDynamicLinkToShare(
                                        true,
                                        'https://akar.alusaifer.com.sa/api/advertisements/${widget.data.id}',
                                        '${widget.data.buildingType.name} ${tr("for_sale")} ${tr("in")} ${widget.data.address}')
                                    .onError(
                                        (error, stackTrace) => setState(() {
                                              isLoading = false;
                                            }));
                                setState(() {
                                  isLoading = false;
                                });
                              },
                              color1: lightBlackColor,
                              color2: lightBlackColor,
                              iconSize: 30,
                              radiusSize: 20,
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          height: screenHeight / 1.41,
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.r),
              topRight: Radius.circular(25.r),
            ),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.data.buildingType.name.toString(),
                                style: TextStyles.textViewBold20
                                    .copyWith(color: textColor),
                              ),
                              widget.data.currentStatus == 'sold'
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
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
                                                    .copyWith(color: mainColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox()
                            ],
                          ),
                          widget.data.video == null ||
                                  widget.data.video!.isEmpty
                              ? const SizedBox()
                              : InkWell(
                                  onTap: () {
                                    sl<AppNavigator>().push(
                                        screen: AdsEquipmentsScreen(
                                      videoUrl: widget.data.video!,
                                    ));
                                  },
                                  child: const Icon(
                                    Icons.video_camera_back,
                                    color: mainColor,
                                    size: 30,
                                  ),
                                ),
                          widget.data.videoLink == null ||
                                  widget.data.videoLink!.isEmpty
                              ? const SizedBox()
                              : InkWell(
                                  onTap: () async {
                                    final Uri youtypeUri =
                                        Uri.parse(widget.data.videoLink!);
                                    await launchUrl(youtypeUri);
                                  },
                                  child: const Icon(
                                    Icons.video_camera_back,
                                    color: mainColor,
                                    size: 30,
                                  ),
                                )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Html(
                        data: widget.data.desc,
                        style: {
                          "body": Style(
                            fontSize: FontSize(
                              14.0,
                            ),
                            color: mainColor,
                          ),
                        },
                      ),
                      const Space(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${tr("from")} ${widget.data.minPrice} ${tr("to")} ${widget.data.maxPrice} ${tr("sr")}",
                            style: TextStyles.textViewBold20
                                .copyWith(color: textColor),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.remove_red_eye_outlined,
                                color: mainColor,
                                size: 15,
                              ),
                              const Space(
                                width: 3,
                              ),
                              Text(widget.data.views.toString(),
                                  style: TextStyles.textViewRegular15
                                      .copyWith(color: mainColor)),
                            ],
                          ),
                        ],
                      ),
                      const Space(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        width: screenWidth,
                        // color: Colors.red,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: FittedBox(
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Details(
                                          title: tr("advertiser_no"),
                                          // data: widget.data.licenseNumber.toString()
                                          data: "1200017549")),
                                  Container(
                                    height: 35,
                                    width: 2,
                                    color: lightGrey,
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Details(
                                        title: tr("advertiser_status"),
                                        data: widget.data.userType.toString(),
                                      )),
                                  Container(
                                    height: 35,
                                    width: 2,
                                    color: lightGrey,
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Details(
                                          title: tr("advertisement_number"),
                                          data: widget.data.id.toString())),
                                  Container(
                                    height: 35,
                                    width: 2,
                                    color: lightGrey,
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Details(
                                          title: tr("authorization_number"),
                                          data: widget.data.advLicenseNumber
                                              .toString())),
                                ]),
                          ),
                        ),
                      ),
                      const Space(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            tr("property_info"),
                            style: TextStyles.textViewBold20
                                .copyWith(color: textColor),
                          ),
                          const Space(
                            width: 8,
                          ),

                          ///Mohammed Alusaifer Buildings
                          Offstage(
                            offstage: !widget.data.fromDashboard,
                            child: Text(
                              '(${tr('mohammed_alusaifer_aqars')})',
                              style: TextStyles.textViewRegular15.copyWith(
                                color: mainColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      PropertyInfoWidget(
                        title: tr("date_of_publication"),
                        data: widget.data.creationTime.toString(),
                      ),
                      PropertyInfoWidget(
                        title: tr("last_updated"),
                        data: widget.data.lastUpdate.toString(),
                      ),
                      PropertyInfoWidget(
                        title: tr("address"),
                        data: widget.data.address,
                      ),
                      PropertyInfoWidget(
                        title: tr("purpose"),
                        data: widget.data.purpose.toString(),
                      ),
                      // PropertyInfoWidget(
                      //   title: tr("block_number"),
                      //   data: widget.data.id.toString(),
                      // ),
                      PropertyInfoWidget(
                        title: tr("the_age_of_the_property"),
                        data: widget.data.age.toString(),
                      ),
                      PropertyInfoWidget(
                        title: tr("area"),
                        data:
                            "${widget.data.minDistance} - ${widget.data.maxDistance}",
                      ),
                      widget.data.interface != 0
                          ? PropertyInfoWidget(
                              title: tr("interface"),
                              data: widget.data.interface.toString(),
                            )
                          : const SizedBox(),

                      PropertyInfoWidget(
                        title: tr("number_of_apartments"),
                        data: widget.data.apartmentsCount.toString(),
                      ),
                      PropertyInfoWidget(
                        title: tr("stores"),
                        data: widget.data.shopsCount.toString(),
                      ),
                      widget.data.streetWidth != 0
                          ? PropertyInfoWidget(
                              title: tr("street_view"),
                              data: widget.data.streetWidth.toString(),
                            )
                          : const SizedBox(),

                      // widget.data.videoLink != null &&
                      //         widget.data.videoLink!.isNotEmpty &&
                      //         widget.data.videoLink != ''
                      //     ? SizedBox(
                      //         height: 30,
                      //         child: Row(
                      //             mainAxisAlignment: MainAxisAlignment.start,
                      //             children: [
                      //               SizedBox(
                      //                   width: screenWidth / 2.8,
                      //                   child: Text(
                      //                     tr("video_link"),
                      //                     style: TextStyles.textViewRegular15
                      //                         .copyWith(
                      //                             color:
                      //                                 const Color(0xffAFAFAF)),
                      //                   )),
                      //               SizedBox(
                      //                 width: screenWidth / 2.8,
                      //                 child: InkWell(
                      //                   onTap: () async {},
                      //                   child: Row(
                      //                     children: [
                      //                       const Icon(
                      //                         Icons.remove_red_eye_outlined,
                      //                         color: mainColor,
                      //                         size: 13,
                      //                       ),
                      //                       const SizedBox(
                      //                         width: 2,
                      //                       ),
                      //                       Text(tr("show_video"),
                      //                           style: TextStyles.textViewBold15
                      //                               .copyWith(
                      //                                   color: mainColor)),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ),
                      //             ]),
                      //       )
                      //     : const SizedBox(),
                      // widget.data.videoLink!.isNotEmpty &&
                      //         widget.data.videoLink != null &&
                      //         widget.data.videoLink != ''
                      //     ? SizedBox(
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.start,
                      //           children: [
                      //             Text(
                      //               tr("video_link"),
                      //               style: TextStyles.textViewRegular15
                      //                   .copyWith(
                      //                       color: const Color(0xffAFAFAF)),
                      //             ),
                      //             const SizedBox(
                      //               width: 70,
                      //             ),
                      //             TextButton(
                      //                 onPressed: () async {
                      //                   final Uri youtypeUri =
                      //                       Uri.parse(widget.data.videoLink!);
                      //                   await launchUrl(youtypeUri);
                      //                 },
                      //                 child: Row(
                      //                   children: [
                      //                     const Icon(
                      //                       Icons.remove_red_eye_outlined,
                      //                       color: mainColor,
                      //                       size: 13,
                      //                     ),
                      //                     const SizedBox(
                      //                       width: 2,
                      //                     ),
                      //                     Text(
                      //                       tr("show_video"),
                      //                       style: TextStyles.textViewBold15
                      //                           .copyWith(color: mainColor),
                      //                     ),
                      //                   ],
                      //                 ))
                      //           ],
                      //         ),
                      // //       )
                      //     : const SizedBox(
                      //         height: 0,
                      //       ),
                      PropertyInfoWidget(
                        isLocation: true,
                        title: tr("location"),
                        data: "12-12-2022",
                        lat: widget.data.lat,
                        lng: widget.data.long,
                      ),

                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Divider(
                          color: greyColor,
                          height: 1,
                        ),
                      ),
                      Text(
                        tr("features_and_warranties"),
                        style: TextStyles.textViewBold20
                            .copyWith(color: textColor),
                      ),

                      // PropertyInfoWidget(
                      //   title: tr("rooms"),
                      //   data: widget.data.allRooms.toString(),
                      // ),
                      PropertyInfoWidget(
                        title: tr("bed_rooms_numbers"),
                        data: widget.data.bedroomsCount.toString(),
                      ),
                      PropertyInfoWidget(
                        title: tr("bathrooms"),
                        data: widget.data.bathroomsCount.toString(),
                      ),
                      PropertyInfoWidget(
                        title: tr("additional_rooms"),
                        data: widget.data.additionalRoomsCount.toString(),
                      ),
                      PropertyInfoWidget(
                        title: tr("coverage"),
                        data: '',
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            widget.data.networkTypes.length,
                            (index) => Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: mainColor),
                                        borderRadius: BorderRadius.circular(5),
                                        color: lightBlackColor),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      child: Image.network(
                                          widget.data.networkTypes[index].image,
                                          height: 100,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Image.asset(logoImage),
                                          width: 100,
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                ),
                                const Space(
                                  height: 10,
                                ),
                                Text(
                                  widget.data.networkTypes[index].name,
                                  style: TextStyles.textViewMedium18
                                      .copyWith(color: white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Space(
                        height: 10,
                      ),
                      widget.data.supplement != 0 ||
                              widget.data.separated != 0 ||
                              widget.data.elevator != 0 ||
                              widget.data.kitchen != 0 ||
                              widget.data.roof != 0 ||
                              widget.data.duplex != 0 ||
                              widget.data.carEntrance != 0 ||
                              widget.data.courtyard != 0 ||
                              widget.data.driverRoom != 0 ||
                              widget.data.maidRoom != 0 ||
                              widget.data.pool != 0 ||
                              widget.data.basement != 0 ||
                              widget.data.externalStaircase != 0
                          ? const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Divider(
                                color: greyColor,
                                height: 1,
                              ),
                            )
                          : const SizedBox(),
                      const Space(
                        height: 10,
                      ),
                      widget.data.supplement != 0 ||
                              widget.data.separated != 0 ||
                              widget.data.elevator != 0 ||
                              widget.data.kitchen != 0 ||
                              widget.data.roof != 0 ||
                              widget.data.duplex != 0 ||
                              widget.data.carEntrance != 0 ||
                              widget.data.courtyard != 0 ||
                              widget.data.driverRoom != 0 ||
                              widget.data.maidRoom != 0 ||
                              widget.data.pool != 0 ||
                              widget.data.basement != 0 ||
                              widget.data.externalStaircase != 0
                          ? Text(
                              tr("additional_features"),
                              style: TextStyles.textViewBold20
                                  .copyWith(color: textColor),
                            )
                          : const SizedBox(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.data.supplement == 0
                              ? const SizedBox()
                              : Row(
                                  children: [
                                    const Icon(
                                      Icons.check_box_outlined,
                                      color: mainColor,
                                      size: 20,
                                    ),
                                    const Space(
                                      width: 10,
                                    ),
                                    Text(
                                      tr("appendix"),
                                      style: TextStyles.textViewRegular15
                                          .copyWith(
                                              color: const Color(0xffAFAFAF)),
                                    ),
                                  ],
                                ),
                          widget.data.separated == 0
                              ? const SizedBox()
                              : Row(
                                  children: [
                                    const Icon(
                                      Icons.check_box_outlined,
                                      color: mainColor,
                                      size: 20,
                                    ),
                                    const Space(
                                      width: 10,
                                    ),
                                    Text(
                                      tr("separate"),
                                      style: TextStyles.textViewRegular15
                                          .copyWith(
                                              color: const Color(0xffAFAFAF)),
                                    ),
                                  ],
                                ),
                          widget.data.elevator == 0
                              ? const SizedBox()
                              : Row(
                                  children: [
                                    const Icon(
                                      Icons.check_box_outlined,
                                      color: mainColor,
                                      size: 20,
                                    ),
                                    const Space(
                                      width: 10,
                                    ),
                                    Text(
                                      tr("elevator"),
                                      style: TextStyles.textViewRegular15
                                          .copyWith(
                                              color: const Color(0xffAFAFAF)),
                                    ),
                                  ],
                                ),
                          widget.data.kitchen == 0
                              ? const SizedBox()
                              : Row(
                                  children: [
                                    const Icon(
                                      Icons.check_box_outlined,
                                      color: mainColor,
                                      size: 20,
                                    ),
                                    const Space(
                                      width: 10,
                                    ),
                                    Text(
                                      tr("kitchen"),
                                      style: TextStyles.textViewRegular15
                                          .copyWith(
                                              color: const Color(0xffAFAFAF)),
                                    ),
                                  ],
                                ),
                          widget.data.roof == 0
                              ? const SizedBox()
                              : Row(
                                  children: [
                                    const Icon(
                                      Icons.check_box_outlined,
                                      color: mainColor,
                                      size: 20,
                                    ),
                                    const Space(
                                      width: 10,
                                    ),
                                    Text(
                                      tr("surface"),
                                      style: TextStyles.textViewRegular15
                                          .copyWith(
                                              color: const Color(0xffAFAFAF)),
                                    ),
                                  ],
                                ),
                          widget.data.duplex == 0
                              ? const SizedBox()
                              : Row(
                                  children: [
                                    const Icon(
                                      Icons.check_box_outlined,
                                      color: mainColor,
                                      size: 20,
                                    ),
                                    const Space(
                                      width: 10,
                                    ),
                                    Text(
                                      tr("duplex"),
                                      style: TextStyles.textViewRegular15
                                          .copyWith(
                                              color: const Color(0xffAFAFAF)),
                                    ),
                                  ],
                                ),
                          widget.data.carEntrance == 0
                              ? const SizedBox()
                              : Row(
                                  children: [
                                    const Icon(
                                      Icons.check_box_outlined,
                                      color: mainColor,
                                      size: 20,
                                    ),
                                    const Space(
                                      width: 10,
                                    ),
                                    Text(
                                      tr("car_intrance"),
                                      style: TextStyles.textViewRegular15
                                          .copyWith(
                                              color: const Color(0xffAFAFAF)),
                                    ),
                                  ],
                                ),
                          widget.data.courtyard == 0
                              ? const SizedBox()
                              : Row(
                                  children: [
                                    const Icon(
                                      Icons.check_box_outlined,
                                      color: mainColor,
                                      size: 20,
                                    ),
                                    const Space(
                                      width: 10,
                                    ),
                                    Text(
                                      tr("monsters"),
                                      style: TextStyles.textViewRegular15
                                          .copyWith(
                                              color: const Color(0xffAFAFAF)),
                                    ),
                                  ],
                                ),
                          widget.data.driverRoom == 0
                              ? const SizedBox()
                              : Row(
                                  children: [
                                    const Icon(
                                      Icons.check_box_outlined,
                                      color: mainColor,
                                      size: 20,
                                    ),
                                    const Space(
                                      width: 10,
                                    ),
                                    Text(
                                      tr("driver's_room"),
                                      style: TextStyles.textViewRegular15
                                          .copyWith(
                                              color: const Color(0xffAFAFAF)),
                                    ),
                                  ],
                                ),
                          widget.data.maidRoom == 0
                              ? const SizedBox()
                              : Row(
                                  children: [
                                    const Icon(
                                      Icons.check_box_outlined,
                                      color: mainColor,
                                      size: 20,
                                    ),
                                    const Space(
                                      width: 10,
                                    ),
                                    Text(
                                      tr("maid's_room"),
                                      style: TextStyles.textViewRegular15
                                          .copyWith(
                                              color: const Color(0xffAFAFAF)),
                                    ),
                                  ],
                                ),
                          widget.data.pool == 0
                              ? const SizedBox()
                              : Row(
                                  children: [
                                    const Icon(
                                      Icons.check_box_outlined,
                                      color: mainColor,
                                      size: 20,
                                    ),
                                    const Space(
                                      width: 10,
                                    ),
                                    Text(
                                      tr("swimming_pool"),
                                      style: TextStyles.textViewRegular15
                                          .copyWith(
                                              color: const Color(0xffAFAFAF)),
                                    ),
                                  ],
                                ),
                          widget.data.basement == 0
                              ? const SizedBox()
                              : Row(
                                  children: [
                                    const Icon(
                                      Icons.check_box_outlined,
                                      color: mainColor,
                                      size: 20,
                                    ),
                                    const Space(
                                      width: 10,
                                    ),
                                    Text(
                                      tr("basement"),
                                      style: TextStyles.textViewRegular15
                                          .copyWith(
                                              color: const Color(0xffAFAFAF)),
                                    ),
                                  ],
                                ),
                          widget.data.externalStaircase == 0
                              ? const SizedBox()
                              : Row(
                                  children: [
                                    const Icon(
                                      Icons.check_box_outlined,
                                      color: mainColor,
                                      size: 20,
                                    ),
                                    const Space(
                                      width: 10,
                                    ),
                                    Text(
                                      tr("internal_staircase"),
                                      style: TextStyles.textViewRegular15
                                          .copyWith(
                                              color: const Color(0xffAFAFAF)),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                      // widget.fromUnderReview
                      //     ? Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Padding(
                      //       padding: const EdgeInsets.symmetric(
                      //           horizontal: 10),
                      //       child: Text(
                      //           tr("accreditation_and_publication"),
                      //           style: TextStyles.textViewRegular19
                      //               .copyWith(color: textColor)),
                      //     ),
                      //     FlutterSwitch(
                      //         toggleColor: white,
                      //         activeColor: mainColor,
                      //         inactiveColor: greyColor.withOpacity(0.3),
                      //         inactiveToggleColor: greyColor,
                      //         width: 40,
                      //         height: 20,
                      //         toggleSize: 18,
                      //         value: agree,
                      //         borderRadius: 30.0,
                      //         padding: 2,
                      //         showOnOff: false,
                      //         onToggle: (val) {
                      //           setState(() {
                      //             agree = !agree;
                      //           });
                      //         }),
                      //   ],
                      // )
                      //     : const SizedBox(),
                      widget.fromUnderReview
                          ? const SizedBox()
                          : const Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Divider(
                                color: greyColor,
                                height: 1,
                              ),
                            ),
                      widget.fromUnderReview
                          ? const SizedBox()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tr("mohamed_asifer_Company_information"),
                                  style: TextStyles.textViewBold20
                                      .copyWith(color: textColor),
                                ),
                                const Space(
                                  height: 20,
                                ),
                                BlocConsumer<SocialLinksCubit,
                                        SocialLinksState>(
                                    listener: (context, state) {
                                  if (state is SocialLinksErrorState) {
                                    showToast(state.message);
                                  }
                                }, builder: (context, state) {
                                  return state is SocialLinksSuccessState
                                      ? Container(
                                          height: 120,
                                          width: screenWidth,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color:
                                                    brownColor.withOpacity(.3)),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                state.response.data.app.logo !=
                                                        null
                                                    ? ClipRRect(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    15)),
                                                        child: Image.network(
                                                          state.response.data
                                                              .app.logo!,
                                                          width: 120,
                                                        ),
                                                      )
                                                    : const SizedBox(),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 15),
                                                  child: Container(
                                                    height: 100,
                                                    width: 1,
                                                    color: lightGrey,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: SingleChildScrollView(
                                                    physics:
                                                        const BouncingScrollPhysics(),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        // state.response.data.app
                                                        //             .phone !=
                                                        //         null &&
                                                        //     state
                                                        //         .response
                                                        //         .data
                                                        //         .app
                                                        //         .phone!
                                                        //         .isNotEmpty
                                                        // ? Row(
                                                        //     // crossAxisAlignment:
                                                        //     //     CrossAxisAlignment
                                                        //     //         .center,
                                                        //     children: [
                                                        //       const Space(
                                                        //         boxHeight:
                                                        //             10,
                                                        //       ),
                                                        //       const IconButtonCard(
                                                        //         radiusSize:
                                                        //             14,
                                                        //         image:
                                                        //             call2,
                                                        //         color1:
                                                        //             mainColor,
                                                        //         color2:
                                                        //             mainColor,
                                                        //         avtarColor:
                                                        //             mainColor,
                                                        //         paddingImage:
                                                        //             4,
                                                        //         isImage:
                                                        //             true,
                                                        //       ),
                                                        //       const Space(
                                                        //         boxWidth: 5,
                                                        //       ),
                                                        //       InkWell(
                                                        //         onTap:
                                                        //             () async {
                                                        //           final Uri phoneUri = Uri(
                                                        //               scheme:
                                                        //                   "tel",
                                                        //               path: state
                                                        //                   .response
                                                        //                   .data
                                                        //                   .app
                                                        //                   .phone);
                                                        //           try {
                                                        //             if (await canLaunchUrl(
                                                        //                 phoneUri)) {
                                                        //               await launchUrl(
                                                        //                   phoneUri);
                                                        //             }
                                                        //           } catch (error) {
                                                        //             throw ("Cannot dial");
                                                        //           }
                                                        //         },
                                                        //         child: Text(
                                                        //           state
                                                        //               .response
                                                        //               .data
                                                        //               .app
                                                        //               .phone!,
                                                        //           style: TextStyles
                                                        //               .textViewBold18
                                                        //               .copyWith(
                                                        //                   color: mainColor),
                                                        //         ),
                                                        //       ),
                                                        //     ],
                                                        //   )
                                                        // : const SizedBox(),
                                                        const Space(
                                                          height: 10,
                                                        ),
                                                        state.response.data
                                                                    .whatsApp !=
                                                                null
                                                            ? Row(
                                                                // crossAxisAlignment:
                                                                //     CrossAxisAlignment
                                                                //         .center,
                                                                children: [
                                                                  const Space(
                                                                    height: 10,
                                                                  ),
                                                                  SvgPicture
                                                                      .asset(
                                                                    whaats,
                                                                    height: 25,
                                                                  ),
                                                                  const Space(
                                                                    width: 5,
                                                                  ),
                                                                  InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      context
                                                                              .read<
                                                                                  SocialLinksCubit>()
                                                                              .data
                                                                              .data
                                                                              .whatsApp !=
                                                                          state
                                                                              .response
                                                                              .data
                                                                              .whatsApp;
                                                                      _createDynamicLink(
                                                                          true,
                                                                          'https://akar.alusaifer.com.sa/api/advertisements/${widget.data.id}',
                                                                          tr("msg_text"));
                                                                      //(${widget.data.buildingType.name} ${tr("for_sale")} ${tr("in")} ${widget.data.address}
                                                                      // DynamicLink().createLink(
                                                                      //     refCode:
                                                                      //         'https://akar.alusaifer.com.sa/api/advertisements/${widget.data.id}');
                                                                      // final Uri
                                                                      //     phoneUri =
                                                                      //     Uri.parse(
                                                                      //         "whatsapp://send?phone=${state.response.data.whatsApp}&text=${tr("msg_text")}(${widget.data.buildingType.name.toString} ${tr("for_sale")} ${tr("in")} ${widget.data.address.toString}) ${widget.data.link.toString}");
                                                                      // await launchUrl(
                                                                      // phoneUri);
                                                                    },
                                                                    child: Text(
                                                                      state
                                                                          .response
                                                                          .data
                                                                          .whatsApp!,
                                                                      style: TextStyles
                                                                          .textViewBold18
                                                                          .copyWith(
                                                                              color: mainColor),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            : const SizedBox(),
                                                        const Space(
                                                          height: 15,
                                                        ),
                                                        if (state.response.data
                                                            .phones!.isNotEmpty)
                                                          Column(
                                                            children:
                                                                List.generate(
                                                              state
                                                                  .response
                                                                  .data
                                                                  .phones!
                                                                  .length,
                                                              (index) =>
                                                                  Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            10),
                                                                child:
                                                                    GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    final Uri phoneUri = Uri(
                                                                        scheme:
                                                                            "tel",
                                                                        path: state
                                                                            .response
                                                                            .data
                                                                            .phones![index]);
                                                                    try {
                                                                      if (await canLaunchUrl(
                                                                          phoneUri)) {
                                                                        await launchUrl(
                                                                            phoneUri);
                                                                      }
                                                                    } catch (error) {
                                                                      throw ("Cannot dial");
                                                                    }
                                                                  },
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      const IconButtonCard(
                                                                        radiusSize:
                                                                            12,
                                                                        color1:
                                                                            mainColor,
                                                                        color2:
                                                                            mainColor,
                                                                        image:
                                                                            call2,
                                                                        paddingImage:
                                                                            4,
                                                                        isImage:
                                                                            true,
                                                                      ),
                                                                      const Space(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                        state
                                                                            .response
                                                                            .data
                                                                            .phones![index],
                                                                        style: TextStyles
                                                                            .textViewBold18
                                                                            .copyWith(color: mainColor),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        const Space(
                                                          height: 10,
                                                        ),
                                                        // Html(
                                                        //   data: state
                                                        //       .response
                                                        //       .data
                                                        //       .app
                                                        //       .description,
                                                        //   style: {
                                                        //     "body": Style(
                                                        //       fontSize:
                                                        //           FontSize(
                                                        //               14.0),
                                                        //       color: white,
                                                        //     ),
                                                        //   },
                                                        // ),

                                                        // Row(
                                                        //   crossAxisAlignment:
                                                        //       CrossAxisAlignment.center,
                                                        //   children: [
                                                        //     CircleAvatar(
                                                        //       radius: 10,
                                                        //       backgroundColor: mainColor,
                                                        //       child: FittedBox(
                                                        //         child: Padding(
                                                        //           padding:
                                                        //               const EdgeInsets.all(
                                                        //                   5),
                                                        //           child:
                                                        //               Image.asset(whatsapp),
                                                        //         ),
                                                        //       ),
                                                        //     ),
                                                        //     const Space(
                                                        //       boxWidth: 5,
                                                        //     ),
                                                        //     Text(
                                                        //       widget.data.,
                                                        //       style: TextStyles
                                                        //           .textViewRegular15
                                                        //           .copyWith(
                                                        //               color: lightGrey),
                                                        //     ),
                                                        //   ],
                                                        // )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : const Loading();
                                }),
                                context
                                        .watch<SimilarAdsCubit>()
                                        .filterData
                                        .isEmpty
                                    ? const SizedBox()
                                    : const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 20),
                                        child: Divider(
                                          color: greyColor,
                                          height: 1,
                                        ),
                                      ),
                                context
                                        .watch<SimilarAdsCubit>()
                                        .filterData
                                        .isEmpty
                                    ? const SizedBox()
                                    : Text(
                                        tr("similar_ads"),
                                        style: TextStyles.textViewBold20
                                            .copyWith(color: textColor),
                                      ),
                              ],
                            ),
                    ],
                  ),
                ),
                widget.fromUnderReview ||
                        context.watch<SimilarAdsCubit>().filterData.isEmpty
                    ? const SizedBox()
                    : SizedBox(
                        height: 120,
                        width: screenWidth,
                        child: BlocConsumer<SimilarAdsCubit, SimilarAdsState>(
                          listener: (context, state) {
                            if (state is GetSimilarAdsErrorState) {
                              showToast(state.message);
                            }
                          },
                          builder: (context, filterState) {
                            if (filterState is GetSimilarAdsLoadingState) {
                              return const Loading();
                            }
                            final similarAds =
                                context.watch<SimilarAdsCubit>().filterData;
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                controller: _scrollController,
                                itemCount: similarAds.length + 1,
                                itemBuilder: (BuildContext context, int index) {
                                  if (similarAds.length == index) {
                                    if (filterState
                                        is GetSimilarAdsPaginationLoadingState) {
                                      return const Center(
                                          child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                mainColor),
                                      ));
                                    } else {
                                      return const SizedBox();
                                    }
                                  }
                                  return GestureDetector(
                                    onTap: () {
                                      sl<AppNavigator>().pop();
                                      sl<AppNavigator>().push(
                                          screen: AquarDetailsScreen(
                                              aqratScreen: false,
                                              fromUnderReview: false,
                                              data: similarAds[index]));
                                    },
                                    child: SimilarAdsCard(
                                      area:
                                          "${similarAds[index].minDistance}-${similarAds[index].maxDistance}",
                                      price:
                                          "${similarAds[index].minPrice}-${similarAds[index].maxPrice}",
                                      currency: tr("sr"),
                                      productName:
                                          similarAds[index].buildingType.name,
                                      imgUrl: similarAds[index].icon,
                                    ),
                                  );
                                });
                          },
                        ),
                      ),
                const Space(
                  height: 15,
                ),
                widget.fromUnderReview
                    ? Padding(
                        padding: const EdgeInsets.all(20),
                        child: widget.data.currentStatus == 'sold'
                            ? const SizedBox()
                            : GradiantButton(
                                title: tr("update_annoncement"),
                                tap: () {
                                  context
                                      .read<UpdateAnnoncementCubit>()
                                      .emitInit();
                                  sl<AppNavigator>().push(
                                      screen: UpdateAnnoncementScreen(
                                    data: widget.data,
                                  ));
                                },
                              ),
                      )
                    : const SizedBox()
              ],
            ),
          ),
        )
      ]),
    );
  }
}
