import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/dimenssions/screenutil.dart';
import '../../../../core/constant/images.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/util/app_navigator.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/space.dart';
import '../../../../core/widgets/toast.dart';
import '../../../../injection_container/injection_container.dart';
import '../../../home/presentation/cubit/delete_adv/cubit/delete_adv_cubit.dart';
import '../../../home/presentation/cubit/get_mine_filter_data/get_mine_filter_data_cubit.dart';
import '../../../home/presentation/cubit/get_user_ads_count/cubit/get_user_ads_count_cubit.dart';
import 'delete_adv_dialog.dart';

class UnderReviewCard extends StatelessWidget {
  final String image;
  final String buildingTybe;
  final String creationTime;
  // final String views;
  final String status;
  final String currentStatus;
  // final String view;
  final int id;

  final String price;
  const UnderReviewCard(
      {super.key,
      required this.image,
      // required this.views,
      required this.buildingTybe,
      required this.creationTime,
      required this.price,
      required this.status,
      required this.id,
      required this.currentStatus});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
          border: Border.all(color: mainColor),
          borderRadius: BorderRadius.circular(10),
          color: lightBlackColor),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: CachedNetworkImage(
                  imageUrl: image.isEmpty
                      ? "https://joadre.com/wp-content/uploads/2019/02/no-image.jpg"
                      : image,
                  fit: BoxFit.cover,
                  width: screenWidth,
                  height: 100),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            buildingTybe,
                            style: TextStyles.textViewRegular15
                                .copyWith(color: white),
                          ),
                          const SizedBox(width: 10),
                          currentStatus == "sold"
                              ? const SizedBox()
                              : InkWell(
                                  onTap: () {},
                                  child: SvgPicture.asset(
                                    edit,
                                    height: 20,
                                    color: mainColor,
                                  ))
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                clockImage,
                                height: 15,
                                color: mainColor,
                              ),
                              const Space(
                                width: 5,
                              ),
                              Text(
                                creationTime,
                                style: TextStyles.textViewRegular15
                                    .copyWith(color: white),
                              ),
                            ],
                          ),
                          const Space(
                            width: 25,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(tag, height: 15, color: mainColor),
                          const Space(width: 5),
                          Text(price,
                              style: TextStyles.textViewRegular15
                                  .copyWith(color: white)),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: FittedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      currentStatus == 'pending'
                                          ? loading
                                          : currentStatus == 'published'
                                              ? check
                                              : currentStatus == 'sold'
                                                  ? dolar
                                                  : cross,
                                      height: 18,
                                      color: mainColor,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(status,
                                        style: TextStyles.textViewBold18
                                            .copyWith(color: blackColor))
                                  ]),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return BlocProvider(
                                    create: (context) => sl<DeleteAdvCubit>(),
                                    child: BlocConsumer<DeleteAdvCubit,
                                        DeleteAdvState>(
                                      listener: (context, state) {
                                        if (state is DeleteAdvErrorState) {
                                          showToast(state.message);
                                        }
                                        if (state is DeleteAdvSuccessState) {
                                          context
                                              .read<GetMineFilterDataCubit>()
                                              .fGetMineFilter(
                                                  status: status,
                                                  isFirst: true);
                                          context
                                              .read<GetUserAdsCountCubit>()
                                              .fGetNetWorkTypes();
                                          sl<AppNavigator>().pop();
                                          sl<AppNavigator>().pop();
                                          showToast(state.res.message);
                                        }
                                      },
                                      builder: (context, state) {
                                        if (state is DeleteAdvLoadingState) {
                                          return const Loading();
                                        }
                                        return DeleteAdvDialoug(
                                          yes: () {
                                            sl<AppNavigator>().pop();
                                          },
                                          no: () async {
                                            context
                                                .read<DeleteAdvCubit>()
                                                .fDeleteAdv(id: id);
                                          },
                                        );
                                      },
                                    ),
                                  );
                                });
                          },
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.redAccent,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
