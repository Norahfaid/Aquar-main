import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/dimenssions/screenutil.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/util/app_navigator.dart';
import '../../../../core/widgets/default_app_bar.dart';
import '../../../../core/widgets/home_card.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/space.dart';
import '../../../../core/widgets/toast.dart';
import '../../../../injection_container/injection_container.dart';
import '../../../auth/presentation/cubit/get_real_states/cubit/get_real_states_cubit.dart';
import '../../../home/presentation/cubit/home_cubit.dart';
import '../../../home/presentation/pages/aquar_details_screen.dart';
import '../../../map/presentation/cubit/pick_map/pick_map_cubit.dart';
import '../widgets/title_widget.dart';
import 'extinions.dart';

class AquarScreen extends StatefulWidget {
  const AquarScreen({super.key});

  @override
  State<AquarScreen> createState() => _AquarScreenState();
}

class _AquarScreenState extends State<AquarScreen> {
  bool onTap1 = false;
  bool onTap0 = false;

  bool onTap2 = false;

  bool onTap3 = false;

  final List titles = [
    tr("nearest_to_you"),
    tr("posted_recently"),
    tr("price_dec"),
  ];

  late final ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    context.read<FilterCubit>().fgetFilterData(
          ifIsMore: true,
          map: 1,
          // status: "published",
          isFirst: true,
          buildingtype: context.read<FilterCubit>().buildingTypeSelectedId,
        );
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<FilterCubit>().fgetFilterData(
              // status: "published",
              map: 1,
            );
      }
    });
  }

  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: blackColor,
        appBar: DefaultAppBar(
          // leadingIcon: IconThemeData(color: Colors.black),
          title: tr("aquar"),
          ontapLeading: () {

            sl<AppNavigator>().pop();
          },
          leadingIcon: const Icon(
            Icons.keyboard_arrow_right,
            size: 30,
            color: Colors.black,
          )
        ),
        body: BlocConsumer<FilterCubit, FilterState>(
          listener: (context, state) {
            if (state is GetFilterErrorState) {
              showToast(state.message);
            }
          },
          builder: (context, filterState) {
            return Column(
              children: [
                Column(
                  children: [
                    const Divider(
                      color: greyColor,
                      height: 1,
                    ),
                    const Space(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child:
                          BlocConsumer<GetRealStatesCubit, GetRealStatesState>(
                        listener: (context, state) {
                          if (state is GetRealStatesErrorState) {
                            showToast(state.message);
                          }
                          if (state is GetRealStatesSuccessState) {
                            context.read<FilterCubit>().changeSelectedId(
                                newId: state.data.first.id.toString());
                            // context
                            //     .read<FilterCubit>()
                            //     .unitCurrentPage();
                            context.read<FilterCubit>().fgetFilterData(
                                ifIsMore: true,
                                isNearest: onTap1,
                                // status: "published",
                                map: 1,
                                buildingtype: state.data.first.id.toString());
                          }
                        },
                        builder: (context, state) {
                          final realStateList =
                              context.read<GetRealStatesCubit>().raelStateList;
                          if (state is GetRealStatesLoadingState) {
                            return const Loading();
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
                                              : () {
                                                  final filterCubit = context
                                                      .read<FilterCubit>();
                                                  setState(() {
                                                    selected = index;
                                                    context
                                                        .read<FilterCubit>()
                                                        .changeSelectedId(
                                                            newId: realStateList[
                                                                    index]
                                                                .id
                                                                .toString());
                                                    filterCubit
                                                            .buildingTypeSelectedId =
                                                        realStateList[index]
                                                            .id
                                                            .toString();
                                                    filterCubit.fgetFilterData(
                                                        isFirst: true,
                                                        // status: "published",
                                                        map: 1,
                                                        isNearest: onTap1,
                                                        buildingtype:
                                                            realStateList[index]
                                                                .id
                                                                .toString());
                                                  });
                                                },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: index == selected
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
                                                  color: index == selected
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
                                                          color:
                                                              index == selected
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
                    ),
                    const Space(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        width: screenWidth,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Row(children: [
                            // InkWell(
                            //     onTap: () {},
                            //     child: TitleWidget(title: titles[0])),
                            InkWell(
                                onTap: filterState is GetFilterLoadingState
                                    ? () {
                                        showToast(tr(
                                            "please_wait_until_data_loaded"));
                                      }
                                    : () {
                                        setState(() {
                                          onTap0 = true;
                                          onTap1 = false;
                                          onTap2 = false;
                                          onTap3 = false;
                                          context
                                              .read<FilterCubit>()
                                              .fgetFilterData(
                                                map: 1,
                                                isFirst: true,
                                                isNearest: false,
                                                // status: "published",
                                                buildingtype: context
                                                    .read<FilterCubit>()
                                                    .buildingTypeSelectedId,
                                              );
                                        });
                                      },
                                child: TitleWidget(
                                  title: tr("all"),
                                  onTap: onTap0,
                                )),
                            InkWell(
                                onTap: filterState is GetFilterLoadingState
                                    ? () {
                                        showToast(tr(
                                            "please_wait_until_data_loaded"));
                                      }
                                    : () {
                                        setState(() {
                                          onTap0 = false;
                                          onTap1 = true;
                                          onTap2 = false;
                                          onTap3 = false;
                                          context
                                              .read<FilterCubit>()
                                              .fgetFilterData(
                                                map: 1,
                                                isFirst: true,
                                                // status: "published",
                                                isNearest: true,
                                                buildingtype: context
                                                    .read<FilterCubit>()
                                                    .buildingTypeSelectedId,
                                                latLang: context
                                                    .read<PickMapCubit>()
                                                    .markers
                                                    .first
                                                    .position
                                                    .toStringServer(),
                                              );
                                        });
                                      },
                                child: TitleWidget(
                                  title: titles[0],
                                  onTap: onTap1,
                                )),
                            InkWell(
                                onTap: filterState is GetFilterLoadingState
                                    ? () {
                                        showToast(tr(
                                            "please_wait_until_data_loaded"));
                                      }
                                    : () {
                                        setState(() {
                                          onTap0 = false;
                                          onTap2 = true;
                                          onTap1 = false;
                                          onTap3 = false;
                                        });
                                        context
                                            .read<FilterCubit>()
                                            .fgetFilterData(
                                                isFirst: true,
                                                map: 1,
                                                // status: "published",
                                                buildingtype: context
                                                    .read<FilterCubit>()
                                                    .buildingTypeSelectedId,
                                                latest: 1.toString());
                                      },
                                child: TitleWidget(
                                  title: titles[1],
                                  onTap: onTap2,
                                )),
                            InkWell(
                                onTap: filterState is GetFilterLoadingState
                                    ? () {
                                        showToast(tr(
                                            "please_wait_until_data_loaded"));
                                      }
                                    : () {
                                        setState(() {
                                          onTap0 = false;
                                          onTap3 = true;
                                          onTap2 = false;
                                          onTap1 = false;
                                        });
                                        context
                                            .read<FilterCubit>()
                                            .fgetFilterData(
                                              map: 1,
                                              isFirst: true,
                                              // status: "published",
                                              buildingtype: context
                                                  .read<FilterCubit>()
                                                  .buildingTypeSelectedId,
                                              cheaper: 1.toString(),
                                            );
                                      },
                                child: TitleWidget(
                                  title: titles[2],
                                  onTap: onTap3,
                                )),
                          ]),
                        ),
                      ),
                    ),
                    // const Space(
                    //   boxHeight: 20,
                    // ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: BlocConsumer<FilterCubit, FilterState>(
                      listener: (context, state) {
                        if (state is GetFilterErrorState) {
                          showToast(state.message);
                        }
                      },
                      builder: (context, state) {
                        final filterBloc = context.watch<FilterCubit>();
                        if (state is GetFilterLoadingState) {
                          return const Loading();
                        }
                        return ListView.builder(
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
                                  tap: (() {
                                    sl<AppNavigator>().push(
                                        screen: AquarDetailsScreen(
                                      aqratScreen: true,
                                      data: filterBloc.filterData[index],
                                      fromUnderReview: false,
                                    ));
                                  }),
                                  advId: filterBloc.filterData[index].id,
                                  imgUrl: filterBloc.filterData[index].icon,
                                  isFavorite:
                                      filterBloc.filterData[index].isFavorite,
                                  productName:
                                      "${filterBloc.filterData[index].id}# : ${filterBloc.filterData[index].buildingType.name}",
                                  curreny: tr("rs"),
                                  date:
                                      filterBloc.filterData[index].creationTime,
                                  distance:
                                      "${filterBloc.filterData[index].maxDistance}-${filterBloc.filterData[index].minDistance}",
                                  location:
                                      filterBloc.filterData[index].address,
                                  price:
                                      "${filterBloc.filterData[index].maxPrice}-${filterBloc.filterData[index].minPrice}",
                                ),
                              );
                            });
                      },
                    ),
                  ),
                )
              ],
            );
          },
        ));
  }
}
