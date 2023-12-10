import 'package:aquar/core/constant/styles/styles.dart';
import 'package:aquar/features/home/presentation/pages/aquar_details_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/util/app_navigator.dart';
import '../../../../core/widgets/default_app_bar.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/space.dart';
import '../../../../core/widgets/toast.dart';
import '../../../../injection_container/injection_container.dart';
import '../cubit/favourite_cubit.dart';
import '../cubit/toggle_fav/cubit/toggle_fav_cubit.dart';
import '../widgets/fav_card.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  void initState() {
    context.read<FavouriteCubit>().fGetFavourities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: blackColor,
        appBar: DefaultAppBar(
          title: tr("favourities"),
          ontapLeading: () {
            sl<AppNavigator>().pop();
          },
          // leadingIcon: const Icon(
          //   Icons.keyboard_arrow_right,
          //   size: 30,
          // )
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const Divider(
                color: greyColor,
                height: 1,
              ),
              const Space(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: BlocConsumer<FavouriteCubit, FavouriteState>(
                    listener: (context, state) {
                  if (state is GetfavouritiesErrorState) {
                    showToast(state.message);
                  }
                }, builder: (context, state) {
                  final favList = context.read<FavouriteCubit>().favList;
                  if (state is GetfavouritiesLoadingState) {
                    return const Loading();
                  }
                  return favList.isNotEmpty
                      ? Column(
                          children: List.generate(
                            favList.length,
                            (index) => Padding(
                              padding: const EdgeInsets.all(5),
                              child: InkWell(
                                onTap: () {
                                  sl<AppNavigator>().push(
                                      screen: AquarDetailsScreen(
                                          fromUnderReview: false,
                                          data: favList[index]));
                                },
                                child: FavCard(
                                  icon: BlocProvider(
                                    create: (context) => sl<ToggleFavCubit>(),
                                    child: BlocConsumer<ToggleFavCubit,
                                        ToggleFavState>(
                                      listener: (context, state) {
                                        if (state
                                            is TogglefavouritiesErrorState) {
                                          showToast(state.message);
                                        }
                                        if (state
                                            is TogglefavouritiesSuccessState) {
                                          context
                                              .read<FavouriteCubit>()
                                              .fGetFavourities();
                                          showToast(tr("deleted_successfully"));
                                        }
                                      },
                                      builder: (context, state) {
                                        if (state
                                            is TogglefavouritiesLoadingState) {
                                          return SizedBox(
                                            width: 25.w,
                                            height: 25.h,
                                            child: const CircularProgressIndicator(
                                              color: mainColor,
                                              strokeWidth: 4,
                                            ),
                                          );
                                        }
                                        return InkWell(
                                          child: Icon(
                                            Icons.delete_forever_rounded,
                                            color: Colors.white,
                                            size: 25.r,
                                          ),
                                          onTap: () {
                                            context
                                                .read<ToggleFavCubit>()
                                                .fToggleFavourities(
                                                    id: favList[index].id);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  imgUrl: favList[index].icon,
                                  productName: favList[index].buildingType.name,
                                  curreny: tr("rs"),
                                  date: favList[index].creationTime.toString(),
                                  distance:
                                      "${favList[index].maxDistance}-${favList[index].minDistance}",
                                  location: favList[index].address,
                                  price:
                                      "${favList[index].minPrice} -${favList[index].maxPrice} ",
                                  fromDashboard: favList[index].fromDashboard,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Text(
                          tr("there_are_no_data"),
                          style: TextStyles.textViewBold20
                              .copyWith(color: mainColor),
                        );
                }),
              )
            ],
          ),
        ));
  }
}
