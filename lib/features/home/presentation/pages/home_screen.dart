import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/dimenssions/screenutil.dart';
import '../../../../core/constant/images.dart';
import '../../../../core/constant/map_style.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/util/app_navigator.dart';
import '../../../../core/widgets/guest_widget.dart';
import '../../../../core/widgets/home_card.dart';
import '../../../../core/widgets/icon_button_card.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/search_text_fiels.dart';
import '../../../../core/widgets/side_padding.dart';
import '../../../../core/widgets/space.dart';
import '../../../../core/widgets/toast.dart';
import '../../../../injection_container/injection_container.dart';
import '../../../aquar/presentation/pages/aquar_screen.dart';
import '../../../aquar/presentation/pages/extinions.dart';
import '../../../auth/presentation/cubit/auto_login/auto_login_cubit.dart';
import '../../../auth/presentation/cubit/get_profile/get_profile_cubit.dart';
import '../../../auth/presentation/cubit/get_real_states/cubit/get_real_states_cubit.dart';
import '../../../dynamic_link.dart';
import '../../../favourite/presentation/pages/favourities_screen.dart';
import '../../../map/presentation/cubit/pick_map/pick_map_cubit.dart';
import '../../../notifications/presentation/pages/notifications_screen.dart';
import '../../../settings/presentation/pages/profile_screen.dart';
import '../cubit/home_cubit.dart';
import '../widgets/main_drawer.dart';
import 'aquar_details_screen.dart';
import 'liquidation_screen.dart';

DateTime currentBackPressTime = DateTime(1);
Future<bool> onWillPop() {
  DateTime now = DateTime.now();
  if (now.difference(currentBackPressTime) > const Duration(seconds: 3)) {
    currentBackPressTime = now;
    Fluttertoast.showToast(msg: tr("app_will_closed"));
    return Future.value(false);
  }
  return Future.value(true);
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  // final LatLng? perviousLatLng;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // bool isMap = true;
  bool isMap = true;
  bool isClicked = false;
  Position? current;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late final ScrollController _scrollController;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => initDynamicLinks());
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<FilterCubit>().fgetFilterData(status: "published", map: 1);
      }
    });
  }

  toggleMap() {
    setState(() {
      isMap = !isMap;
    });
  }

  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
          drawer: const MainDrawer(),
          key: scaffoldKey,
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color(0xffffffff),
          body: !isMap
              ? VerticalViewWidget(
                  scaffoldKey: scaffoldKey, toggleMap: toggleMap)
              : BlocConsumer<FilterCubit, FilterState>(
                  listener: (context, state) {
                    if (state is GetFilterErrorState) {
                      showToast(state.message);
                    }
                  },
                  builder: (context, filterState) {
                    final filterBloc = context.watch<FilterCubit>();

                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        BlocBuilder<GetRealStatesCubit, GetRealStatesState>(
                          builder: (context, getRealStates) {
                            if (getRealStates is! GetRealStatesSuccessState) {
                              return const SizedBox();
                            }
                            return BlocConsumer<PickMapCubit, PickMapState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                final pickMapCubit = sl<PickMapCubit>();
                                return GoogleMap(
                                  mapType: MapType.normal,
                                  myLocationButtonEnabled: false,
                                  zoomControlsEnabled: false,
                                  myLocationEnabled: true,
                                  mapToolbarEnabled: false,
                                  markers: filterBloc.markers.toSet(),
                                  initialCameraPosition:
                                      pickMapCubit.cameraPosition,
                                  onMapCreated: (GoogleMapController
                                      mapController) async {
                                    if (!_controller.isCompleted) {
                                      _controller.complete(mapController);
                                      pickMapCubit
                                          .updateController(mapController);
                                    }

                                    mapController.setMapStyle(aqarMapStyle);
                                    final filtterCubit = sl<FilterCubit>();
                                    current = await pickMapCubit
                                        .getUserAccessLocation();
                                    if (current == null) {
                                      showToast(
                                          "Location permissions are permanently denied, we cannot get your location");
                                      return;
                                    }
                                    final latlng = current!.latLngFromPostion();
                                    // ignore: use_build_context_synchronously
                                    pickMapCubit.initMapController(
                                        // widget.perviousLatLng == null
                                        //     ? latlng
                                        //     : widget.perviousLatLng!,
                                        latlng,
                                        mapController,
                                        context);

                                    filtterCubit.fgetFilterData(
                                        map: 1,
                                        ifIsMore: true,
                                        isNearest: isMap,
                                        latLang: latlng.toStringServer(),
                                        // status: "published",
                                        markerOnTap: () {
                                          setState(() {
                                            isClicked = true;
                                          });
                                        },
                                        buildingtype: getRealStates
                                            .data.first.id
                                            .toString());
                                  },
                                  // onTap: (latLng) {
                                  //   pickMapCubit.pickLocation(latLng);
                                  // },
                                );
                              },
                            );
                          },
                        ),
                        SidePadding(
                          sidePadding: 15,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    0,
                                    0,
                                    5,
                                    filterBloc.selectedMarker != null
                                        ? 300.h
                                        : 175.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButtonCard(
                                          image: menu,
                                          isImage: true,
                                          onTap: () {
                                            context
                                                .read<FilterCubit>()
                                                .fgetFilterData(
                                                    map: 1,
                                                    // status: "published",
                                                    isFirst: true,
                                                    buildingtype: context
                                                        .read<FilterCubit>()
                                                        .buildingTypeSelectedId);
                                            setState(() {
                                              isMap = !isMap;
                                              filterBloc.selectedMarker = null;
                                              isClicked = false;
                                            });
                                          },
                                        ),
                                        const Space(
                                          height: 10,
                                        ),
                                        IconButtonCard(
                                          image: zoom,
                                          isImage: true,
                                          icon: Icons.filter_alt_outlined,
                                          onTap: () {
                                            final pickMapCubit =
                                                sl<PickMapCubit>();
                                            pickMapCubit
                                                .getCurrentLocation(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Column(children: [
                                    const Space(height: 35),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Space(),
                                        HideFromGuestWidget(
                                          child: Stack(
                                            children: [
                                              IconButtonCard(
                                                icon: Icons.notifications_sharp,
                                                isImage: false,
                                                avtarColor: lightBlackColor,
                                                color1: blackColor,
                                                color2: blackColor,
                                                radiusSize: 25,
                                                onTap: () {
                                                  sl<AppNavigator>().push(
                                                      screen:
                                                          const NotificationsScereen());
                                                },
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.all(15.0),
                                                child: CircleAvatar(
                                                  backgroundColor: mainColor,
                                                  radius: 5,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Space(height: 20),
                                    BlocBuilder<FilterCubit, FilterState>(
                                      builder: (context, state) {
                                        final selectedId = context
                                            .watch<FilterCubit>()
                                            .buildingTypeSelectedId;
                                        return SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          child: BlocConsumer<
                                              GetRealStatesCubit,
                                              GetRealStatesState>(
                                            listener: (context, state) {
                                              if (state
                                                  is GetRealStatesErrorState) {
                                                showToast(state.message);
                                              }
                                              if (state
                                                  is GetRealStatesSuccessState) {
                                                context
                                                    .read<FilterCubit>()
                                                    .changeSelectedId(
                                                        newId: state
                                                            .data.first.id
                                                            .toString());
                                              }
                                            },
                                            builder: (context, state) {
                                              final realStateList = context
                                                  .read<GetRealStatesCubit>()
                                                  .raelStateList;
                                              if (state
                                                  is GetRealStatesLoadingState) {
                                                return const SizedBox();
                                              }
                                              return Row(
                                                  children: List.generate(
                                                      realStateList.length,
                                                      (index) => Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        5),
                                                            child: InkWell(
                                                              onTap: filterState
                                                                      is GetFilterLoadingState
                                                                  ? () {
                                                                      showToast(
                                                                          tr("please_wait_until_data_loaded"));
                                                                    }
                                                                  : () async {
                                                                      final filterCubit =
                                                                          context
                                                                              .read<FilterCubit>();

                                                                      // selected = index;
                                                                      filterCubit.changeSelectedId(
                                                                          newId: realStateList[index]
                                                                              .id
                                                                              .toString());

                                                                      setState(
                                                                          () {});
                                                                      filterBloc
                                                                          .emitGetFilterLoadingState();
                                                                      filterCubit
                                                                          .buildingTypeSelectedId = realStateList[
                                                                              index]
                                                                          .id
                                                                          .toString();
                                                                      filterCubit.fgetFilterData(
                                                                          isFirst: true,
                                                                          map: 1,
                                                                          // status:
                                                                          //     "published",
                                                                          isNearest: isMap,
                                                                          latLang: (await context.read<PickMapCubit>().getUserAccessLocation()).latLngFromPostion().toStringServer(),
                                                                          buildingtype: realStateList[index].id.toString());
                                                                    },
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                        color: selectedId == realStateList[index].id.toString()
                                                                            ? mainColor
                                                                            : lightBlackColor,
                                                                        boxShadow: const [
                                                                          BoxShadow(
                                                                              color: white,
                                                                              spreadRadius: 0,
                                                                              blurRadius: 0),
                                                                        ],
                                                                        borderRadius:
                                                                            const BorderRadius.all(Radius.circular(
                                                                                10.0)),
                                                                        border:
                                                                            Border.all(
                                                                          color: selectedId == realStateList[index].id.toString()
                                                                              ? mainColor
                                                                              : lightBlackColor,
                                                                        )),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          15,
                                                                      vertical:
                                                                          10),
                                                                  child: Center(
                                                                    child: Text(
                                                                      realStateList[
                                                                              index]
                                                                          .name,
                                                                      style: TextStyles
                                                                          .textViewBold16
                                                                          .copyWith(
                                                                              color: selectedId == realStateList[index].id.toString() ? white : greyColor),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )));
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ]),
                                  Padding(
                                    padding: isClicked
                                        ? const EdgeInsets.only(
                                            bottom: 40, left: 5, right: 5)
                                        : EdgeInsets.zero,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        filterBloc.selectedMarker != null
                                            ? Column(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor: redColor,
                                                    child: IconButton(
                                                      onPressed: () {
                                                        filterBloc
                                                            .clearSelectedMarker();
                                                      },
                                                      icon: const Icon(
                                                        Icons.close_rounded,
                                                        color: white,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  HomeCard(
                                                    issold: filterBloc
                                                                .selectedMarker!
                                                                .currentStatus ==
                                                            'sold'
                                                        ? true
                                                        : false,
                                                    filterData: filterBloc
                                                        .selectedMarker!,
                                                    views: filterBloc
                                                        .selectedMarker!.views
                                                        .toString(),
                                                    tap: (() {
                                                      sl<AppNavigator>().push(
                                                          screen: AquarDetailsScreen(
                                                              fromUnderReview:
                                                                  false,
                                                              fromMap: true,
                                                              data: filterBloc
                                                                  .selectedMarker!));
                                                      setState(() {
                                                        isClicked = false;
                                                        filterBloc
                                                            .clearSelectedMarker();
                                                      });
                                                    }),
                                                    imgUrl: filterBloc
                                                        .selectedMarker!.icon,
                                                    isFavorite: filterBloc
                                                        .selectedMarker!
                                                        .isFavorite,
                                                    productName: filterBloc
                                                        .selectedMarker!
                                                        .buildingType
                                                        .name,
                                                    curreny: tr("rs"),
                                                    date: filterBloc
                                                        .selectedMarker!
                                                        .creationTime,
                                                    distance:
                                                        "${filterBloc.selectedMarker!.minDistance} -${filterBloc.selectedMarker!.maxDistance} ",
                                                    location: filterBloc
                                                        .selectedMarker!
                                                        .address,
                                                    price:
                                                        "${filterBloc.selectedMarker!.minPrice}- ${filterBloc.selectedMarker!.maxPrice}",
                                                    advId: filterBloc
                                                        .selectedMarker!.id,
                                                  ),
                                                ],
                                              )
                                            : SafeArea(
                                                child: BottomIcons(
                                                    scaffoldKey: scaffoldKey),
                                              ),
                                      ],
                                    ),
                                  ),
                                  if (filterState is GetFilterLoadingState &&
                                      isMap)
                                    const Loading()
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  },
                )),
    );
  }
}

class VerticalViewWidget extends StatefulWidget {
  const VerticalViewWidget(
      {super.key, required this.scaffoldKey, required this.toggleMap});
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function toggleMap;
  @override
  State<VerticalViewWidget> createState() => _VerticalViewWidgetState();
}

class _VerticalViewWidgetState extends State<VerticalViewWidget> {
  TextEditingController searchController = TextEditingController();

  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => initDynamicLinks());
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<FilterCubit>().fgetFilterData(status: "published", map: 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FilterCubit, FilterState>(
      listener: (context, state) {
        if (state is GetFilterErrorState) {
          showToast(state.message);
        }
      },
      builder: (context, filterState) {
        final filterBloc = context.watch<FilterCubit>();
        return Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(children: [
                const Space(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButtonCard(
                      image: filter2,
                      avtarColor: blackColor,
                      isImage: true,
                      onTap: () {
                        sl<AppNavigator>()
                            .push(screen: const LiquidationScreen());
                      },
                      color1: lightBlackColor,
                      color2: lightBlackColor,
                      radiusSize: 25,
                    ),
                    HideFromGuestWidget(
                      child: Stack(
                        children: [
                          IconButtonCard(
                            icon: Icons.notifications_sharp,
                            isImage: false,
                            avtarColor: blackColor,
                            color1: lightBlackColor,
                            color2: lightBlackColor,
                            radiusSize: 25,
                            onTap: () {
                              sl<AppNavigator>()
                                  .push(screen: const NotificationsScereen());
                            },
                          ),
                          const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: CircleAvatar(
                              backgroundColor: mainColor,
                              radius: 5,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const Space(height: 10),
                SearchTextFeild(
                    hintText: tr("search"),
                    controller: searchController,
                    onChanged: (value) {
                      final filterCubit = sl<FilterCubit>();
                      if (value.isEmpty) {
                        return filterCubit.fgetFilterData(
                          ifIsMore: true,
                          map: 1,
                          // status: "published",
                        );
                      }
                      if (value.length >= 3) {
                        filterCubit.fgetFilterData(
                            map: 1,
                            // status: "published",
                            search: value.trim(),
                            buildingtype: filterCubit.buildingTypeSelectedId,
                            isSearch: true,
                            isFirst: true);
                      }
                    },
                    fillColor: lightBlackColor,
                    suffixIcon: const Icon(
                      Icons.search,
                      color: mainColor,
                      size: 30,
                    )),
                const Space(height: 20),
                BlocBuilder<FilterCubit, FilterState>(
                  builder: (context, state) {
                    final selectedId =
                        context.watch<FilterCubit>().buildingTypeSelectedId;
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child:
                          BlocConsumer<GetRealStatesCubit, GetRealStatesState>(
                        listener: (context, state) {
                          if (state is GetRealStatesErrorState) {
                            showToast(state.message);
                          }
                          if (state is GetRealStatesSuccessState) {
                            sl<FilterCubit>().changeSelectedId(
                                newId: state.data.first.id.toString());
                          }
                        },
                        builder: (context, state) {
                          final realStateList =
                              context.read<GetRealStatesCubit>().raelStateList;
                          if (state is GetRealStatesLoadingState) {
                            return const SizedBox();
                          }
                          return Row(
                              children: List.generate(
                                  realStateList.length,
                                  (index) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: InkWell(
                                          onTap: filterState
                                                  is GetFilterLoadingState
                                              ? () {
                                                  showToast(tr(
                                                      "please_wait_until_data_loaded"));
                                                }
                                              : () async {
                                                  final filterCubit = context
                                                      .read<FilterCubit>();

                                                  // selected = index;
                                                  filterCubit.changeSelectedId(
                                                      newId:
                                                          realStateList[index]
                                                              .id
                                                              .toString());

                                                  setState(() {});
                                                  filterBloc
                                                      .emitGetFilterLoadingState();
                                                  filterCubit
                                                          .buildingTypeSelectedId =
                                                      realStateList[index]
                                                          .id
                                                          .toString();
                                                  filterCubit.fgetFilterData(
                                                      search:
                                                          searchController.text,
                                                      isFirst: true,
                                                      map: 1,
                                                      // status:
                                                      //     "published",
                                                      isNearest: false,
                                                      latLang: (await context
                                                              .read<
                                                                  PickMapCubit>()
                                                              .getUserAccessLocation())
                                                          .latLngFromPostion()
                                                          .toStringServer(),
                                                      buildingtype:
                                                          realStateList[index]
                                                              .id
                                                              .toString());
                                                },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: selectedId ==
                                                        realStateList[index]
                                                            .id
                                                            .toString()
                                                    ? mainColor
                                                    : lightBlackColor,
                                                boxShadow: const [
                                                  BoxShadow(
                                                      color: white,
                                                      spreadRadius: 0,
                                                      blurRadius: 0),
                                                ],
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10.0)),
                                                border: Border.all(
                                                  color: selectedId ==
                                                          realStateList[index]
                                                              .id
                                                              .toString()
                                                      ? mainColor
                                                      : lightBlackColor,
                                                )),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 10),
                                              child: Center(
                                                child: Text(
                                                  realStateList[index].name,
                                                  style: TextStyles
                                                      .textViewBold16
                                                      .copyWith(
                                                          color: selectedId ==
                                                                  realStateList[
                                                                          index]
                                                                      .id
                                                                      .toString()
                                                              ? white
                                                              : greyColor),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )));
                        },
                      ),
                    );
                  },
                ),
                const Space(height: 10),
                filterState is GetFilterLoadingState
                    ? SizedBox(
                        height: screenHeight / 3,
                        child: const Center(
                          child: Loading(),
                        ))
                    : Expanded(
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            controller: _scrollController,
                            itemCount: filterBloc.filterData.length + 1,
                            itemBuilder: (BuildContext context, int index) {
                              if (filterBloc.filterData.length == index) {
                                if (filterState
                                    is GetFilterPaginationLoadingState) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  return const SizedBox();
                                }
                              }
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: HomeCard(
                                  issold: filterBloc.filterData[index]
                                              .currentStatus ==
                                          'sold'
                                      ? true
                                      : false,
                                  views: filterBloc.filterData[index].views
                                      .toString(),
                                  filterData: filterBloc.filterData[index],
                                  advId: filterBloc.filterData[index].id,
                                  tap: (() async {
                                    await sl<AppNavigator>()
                                        .push(
                                            screen: AquarDetailsScreen(
                                          // adUserId: ,
                                          data: filterBloc.filterData[index],
                                          fromUnderReview: false,
                                        ))
                                        .then((value) => setState(() {}));
                                  }),
                                  imgUrl: filterBloc.filterData[index].icon,
                                  isFavorite:
                                      filterBloc.filterData[index].isFavorite,
                                  productName:
                                      "${filterBloc.filterData[index].id.toString()}# ${filterBloc.filterData[index].buildingType.name.toString()}",
                                  curreny: tr("sr"),
                                  date:
                                      filterBloc.filterData[index].creationTime,
                                  distance:
                                      "${filterBloc.filterData[index].minDistance} -${filterBloc.filterData[index].maxDistance} ",
                                  location:
                                      filterBloc.filterData[index].address,
                                  price:
                                      "${filterBloc.filterData[index].minPrice} -${filterBloc.filterData[index].maxPrice} ",
                                ),
                              );
                            })),
              ]),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: InkWell(
                    onTap: () async {
                      widget.toggleMap();
                      context.read<FilterCubit>().fgetFilterData(
                            map: 1,
                            // status: "published",
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
                    },
                    child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        color: blackColor.withOpacity(.9),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: white.withOpacity(.9),
                                size: 20,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(tr("map"),
                                  style: TextStyles.textViewMedium18
                                      .copyWith(color: white.withOpacity(.9)))
                            ]),
                      ),
                    ),
                  ),
                ),
                BottomIcons(scaffoldKey: widget.scaffoldKey),
              ],
            )
          ],
        );
      },
    );
  }
}

class BottomIcons extends StatelessWidget {
  const BottomIcons({
    super.key,
    required this.scaffoldKey,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButtonCard(
              image: person,
              isImage: true,
              onTap: () => sl<AutoLoginCubit>().loginOrFunction(
                  context: context,
                  function: () {
                    context.read<GetProfileCubit>().fGetProfile();
                    sl<AppNavigator>().push(screen: const ProfileScreen());
                  }),
              radiusSize: 27,
              avtarColor: mainColor,
              color1: mainColor,
              color2: lightMainColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButtonCard(
              // icon: Icons.filter_alt_outlined,
              image: house,
              isImage: true,
              avtarColor: mainColor,
              onTap: (() {
                sl<AppNavigator>().push(screen: const AquarScreen());
              }),
              radiusSize: 27,
              color1: mainColor,
              color2: lightMainColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButtonCard(
              image: like,
              isImage: true,
              avtarColor: mainColor,
              onTap: () => sl<AutoLoginCubit>().loginOrFunction(
                  context: context,
                  function: () {
                    sl<AppNavigator>().push(screen: const FavouritesScreen());
                  }),
              radiusSize: 27,
              color1: mainColor,
              color2: lightMainColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButtonCard(
              icon: Icons.menu,
              // image: menu,
              isImage: false,
              avtarColor: mainColor,
              onTap: (() {
                scaffoldKey.currentState!.openDrawer();
              }),
              radiusSize: 27,
              color1: mainColor,
              color2: lightMainColor,
            ),
          ),
        ],
      ),
    );
  }
}
