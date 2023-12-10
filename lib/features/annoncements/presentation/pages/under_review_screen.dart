import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/util/app_navigator.dart';
import '../../../../core/widgets/default_app_bar.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/toast.dart';
import '../../../../injection_container/injection_container.dart';
import '../../../home/presentation/cubit/get_mine_filter_data/get_mine_filter_data_cubit.dart';
import '../../../home/presentation/cubit/home_cubit.dart';
import '../../../home/presentation/pages/aquar_details_screen.dart';
import '../widgets/under_review.dart';

class UnderReviewScreen extends StatefulWidget {
  final String status;
  const UnderReviewScreen({super.key, required this.status});

  @override
  State<UnderReviewScreen> createState() => _UnderReviewScreenState();
}

class _UnderReviewScreenState extends State<UnderReviewScreen> {
  late final ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context
            .read<GetMineFilterDataCubit>()
            .fGetMineFilter(status: widget.status);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: DefaultAppBar(
        title: tr("annoncement"),
        ontapLeading: () {
          sl<AppNavigator>().pop();
        },
        // leadingIcon: const Icon(
        //   Icons.keyboard_arrow_right,
        //   size: 30,
        // )
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: BlocConsumer<GetMineFilterDataCubit, GetMineFilterDataState>(
          listener: (context, state) {
            if (state is GetMineFilterErrorState) {
              showToast(state.message);
            }
          },
          builder: (context, filterState) {
            final filterBloc = context.watch<GetMineFilterDataCubit>();
            if (filterState is GetMineFilterLoadingState) {
              return const Loading();
            }
            return filterBloc.filterData.isEmpty
                ? Center(
                    child: Text(
                      tr("have_no_advs"),
                      style: TextStyles.textViewMedium20.copyWith(color: white),
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: filterBloc.filterData.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (filterBloc.filterData.length == index) {
                        if (filterState is GetFilterPaginationLoadingState) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return const SizedBox();
                        }
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: InkWell(
                            onTap: () async {
                              await sl<AppNavigator>()
                                  .push(
                                      screen: AquarDetailsScreen(
                                    data: filterBloc.filterData[index],
                                    fromUnderReview: true,
                                  ))
                                  .whenComplete(() => context
                                      .read<GetMineFilterDataCubit>()
                                      .fGetMineFilter(isFirst: true));
                            },
                            child: UnderReviewCard(
                              // views:
                              //     filterBloc.filterData[index].views.toString(),
                              currentStatus:
                                  filterBloc.filterData[index].currentStatus,
                              id: filterBloc.filterData[index].id,
                              buildingTybe:
                                  "# ${filterBloc.filterData[index].id} ${filterBloc.filterData[index].buildingType.name}",
                              creationTime:
                                  filterBloc.filterData[index].creationTime,
                              image: filterBloc.filterData[index].icon,
                              status: filterBloc.filterData[index].status
                                  .toString(),
                              price:
                                  "${filterBloc.filterData[index].minPrice}- ${filterBloc.filterData[index].maxPrice}",
                            )),
                      );
                    });
          },
        ),
      ),
    );
  }
}
