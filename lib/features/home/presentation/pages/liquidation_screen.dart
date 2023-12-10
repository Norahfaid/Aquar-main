import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/dimenssions/screenutil.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/util/app_navigator.dart';
import '../../../../core/widgets/default_app_bar.dart';
import '../../../../core/widgets/gradiant_button.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/master_textfield.dart';
import '../../../../core/widgets/space.dart';
import '../../../../core/widgets/toast.dart';
import '../../../../injection_container/injection_container.dart';
import '../../../auth/presentation/cubit/get_real_states/cubit/get_real_states_cubit.dart';
import '../cubit/home_cubit.dart';

class LiquidationScreen extends StatefulWidget {
  const LiquidationScreen({super.key});

  @override
  State<LiquidationScreen> createState() => _LiquidationScreenState();
}

class _LiquidationScreenState extends State<LiquidationScreen> {
  @override
  void initState() {
    final filterBloc = context.read<FilterCubit>();
    filterBloc.filterParams.buildingtype = null;
    super.initState();
  }

  String userType = '-1';

  TextEditingController lowAreaController = TextEditingController();
  TextEditingController highPriceController = TextEditingController();
  TextEditingController lowPriceController = TextEditingController();
  TextEditingController highAreaController = TextEditingController();
  TextEditingController interfaceController = TextEditingController();
  TextEditingController bathroomsCountController = TextEditingController();
  TextEditingController bedRoomsCountController = TextEditingController();
  TextEditingController streetViewController = TextEditingController();
  TextEditingController ageOfPropertyController = TextEditingController();
  TextEditingController shopsController = TextEditingController();
  TextEditingController apartmentCountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userTypeBloc = context.read<GetRealStatesCubit>();
    final filterBloc = context.read<FilterCubit>();
    return Scaffold(
      backgroundColor: blackColor,
      appBar: DefaultAppBar(
        title: tr("liquidation"),
        isBack: true,
        leadingIcon: InkWell(
          onTap: () {
            lowAreaController.clear();
            highPriceController.clear();
            lowPriceController.clear();
            highAreaController.clear();
            interfaceController.clear();
            bathroomsCountController.clear();
            bedRoomsCountController.clear();
            streetViewController.clear();
            ageOfPropertyController.clear();
            shopsController.clear();
            apartmentCountController.clear();

            filterBloc.filterParams.buildingtype = null;
            setState(() {});
          },
          child: Text(
            tr("reset"),
            style: const TextStyle(color: mainColor),
          ),
        ),
      ),
      body: Column(
        children: [
          const Divider(
            color: greyColor,
            height: 1,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Space(height: 20),
                    Text(
                      tr("property_type"),
                      style: TextStyles.textViewBold15.copyWith(color: white),
                    ),
                    const Space(height: 10),
                    BlocBuilder<GetRealStatesCubit, GetRealStatesState>(
                      builder: (context, state) {
                        return state is GetRealStatesErrorState
                            ? Center(
                                child: Text(state.message),
                              )
                            : Wrap(
                                children: List.generate(
                                    userTypeBloc.raelStateList.length, (index) {
                                  return Row(
                                    children: [
                                      Theme(
                                        data: ThemeData.dark(),
                                        child: Radio<String>(
                                          activeColor: mainColor,
                                          value: userTypeBloc
                                              .raelStateList[index].id
                                              .toString(),
                                          groupValue: filterBloc
                                              .filterParams.buildingtype,
                                          onChanged: (value) {
                                            userTypeBloc.chooseRealState(
                                                value.toString());
                                            userType = value.toString();

                                            ///BUT VALUE IN REGISTER PARAMS HERE//////
                                            BlocProvider.of<FilterCubit>(
                                                        context)
                                                    .filterParams
                                                    .buildingtype =
                                                value.toString();
                                          },
                                        ),
                                      ),
                                      Text(
                                          userTypeBloc
                                              .raelStateList[index].name,
                                          style: TextStyles.textViewMedium18
                                              .copyWith(color: mainColor)),
                                    ],
                                  );
                                }),
                              );
                      },
                    ),
                    const Space(height: 20),
                    const Divider(
                      color: greyColor,
                      height: 1,
                    ),
                    const Space(height: 20),
                    Text(
                      tr("determine_price"),
                      style: TextStyles.textViewBold15.copyWith(color: white),
                    ),
                    const Space(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MasterTextField(
                            hintText: tr("low_price"),
                            controller: lowPriceController,
                            keyboardType: TextInputType.phone,
                            width: screenWidth / 2.4,
                            fillColor: lightBlackColor,
                            filled: true,
                            onEditingComplete: () {
                              FocusScope.of(context).nextFocus();
                            },
                            onChanged: (String value) {},
                          ),
                          MasterTextField(
                            filled: true,
                            width: screenWidth / 2.4,
                            fillColor: lightBlackColor,
                            hintText: tr("high_price"),
                            controller: highPriceController,
                            keyboardType: TextInputType.phone,
                            onEditingComplete: () {
                              FocusScope.of(context).nextFocus();
                            },
                            onChanged: (String value) {},
                          ),
                        ],
                      ),
                    ),
                    const Space(height: 20),
                    Text(
                      tr("determine_area"),
                      style: TextStyles.textViewBold15.copyWith(color: white),
                    ),
                    const Space(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MasterTextField(
                            hintText: tr("low_distance"),
                            controller: lowAreaController,
                            keyboardType: TextInputType.phone,
                            width: screenWidth / 2.4,
                            fillColor: lightBlackColor,
                            filled: true,
                            onEditingComplete: () {
                              FocusScope.of(context).nextFocus();
                            },
                            onChanged: (String value) {},
                          ),
                          MasterTextField(
                            filled: true,
                            width: screenWidth / 2.4,
                            fillColor: lightBlackColor,
                            hintText: tr("high_distance"),
                            controller: highAreaController,
                            keyboardType: TextInputType.phone,
                            onEditingComplete: () {
                              FocusScope.of(context).nextFocus();
                            },
                            onChanged: (String value) {},
                          ),
                        ],
                      ),
                    ),
                    const Space(height: 20),
                    const Divider(
                      color: greyColor,
                      height: 1,
                    ),
                    const Space(height: 20),
                    Text(
                      tr("number_of_apartments"),
                      style: TextStyles.textViewBold15.copyWith(color: white),
                    ),
                    const Space(height: 10),
                    MasterTextField(
                      hintText: tr("appartment_number"),
                      controller: apartmentCountController,
                      keyboardType: TextInputType.number,
                      // width: screenWidth / 2.4,
                      fillColor: lightBlackColor,
                      filled: true,
                      onEditingComplete: () {
                        FocusScope.of(context).nextFocus();
                      },
                      onChanged: (String value) {},
                    ),
                    const Space(height: 10),
                    Text(
                      tr("stores"),
                      style: TextStyles.textViewBold15.copyWith(color: white),
                    ),
                    const Space(height: 10),
                    MasterTextField(
                      hintText: tr("stores"),
                      controller: shopsController,
                      keyboardType: TextInputType.number,
                      // width: screenWidth / 2.4,
                      fillColor: lightBlackColor,
                      filled: true,
                      onEditingComplete: () {
                        FocusScope.of(context).nextFocus();
                      },
                      onChanged: (String value) {},
                    ),
                    const Space(height: 10),
                    Text(
                      tr("street_view"),
                      style: TextStyles.textViewBold15.copyWith(color: white),
                    ),
                    const Space(height: 10),
                    MasterTextField(
                      hintText: tr("street_view"),
                      controller: streetViewController,
                      keyboardType: TextInputType.number,
                      // width: screenWidth / 2.4,
                      fillColor: lightBlackColor,
                      filled: true,
                      onEditingComplete: () {
                        FocusScope.of(context).nextFocus();
                      },
                      onChanged: (String value) {},
                    ),
                    const Space(height: 10),
                    Text(
                      tr("the_age_of_the_property"),
                      style: TextStyles.textViewBold15.copyWith(color: white),
                    ),
                    const Space(height: 10),
                    MasterTextField(
                      hintText: tr("the_age_of_the_property"),
                      controller: ageOfPropertyController,
                      keyboardType: TextInputType.number,
                      // width: screenWidth / 2.4,
                      fillColor: lightBlackColor,
                      filled: true,
                      onEditingComplete: () {
                        FocusScope.of(context).nextFocus();
                      },
                      onChanged: (String value) {},
                    ),
                    const Space(height: 10),
                    Text(
                      tr("bedrooms_count"),
                      style: TextStyles.textViewBold15.copyWith(color: white),
                    ),
                    const Space(height: 10),
                    MasterTextField(
                      hintText: tr("bedrooms_count"),
                      controller: bedRoomsCountController,
                      keyboardType: TextInputType.number,
                      // width: screenWidth / 2.4,
                      fillColor: lightBlackColor,
                      filled: true,
                      onEditingComplete: () {
                        FocusScope.of(context).nextFocus();
                      },
                      onChanged: (String value) {},
                    ),
                    const Space(height: 10),
                    Text(
                      tr("bathrooms_count"),
                      style: TextStyles.textViewBold15.copyWith(color: white),
                    ),
                    const Space(height: 10),
                    MasterTextField(
                      hintText: tr("bathrooms_count"),
                      controller: bathroomsCountController,
                      keyboardType: TextInputType.number,
                      // width: screenWidth / 2.4,
                      fillColor: lightBlackColor,
                      filled: true,
                      onEditingComplete: () {
                        FocusScope.of(context).nextFocus();
                      },
                      onChanged: (String value) {},
                    ),
                    const Space(height: 10),
                    Text(
                      tr("interface_distance"),
                      style: TextStyles.textViewBold15.copyWith(color: white),
                    ),
                    const Space(height: 10),
                    MasterTextField(
                      hintText: tr("interface_distance"),
                      controller: interfaceController,
                      keyboardType: TextInputType.number,
                      // width: screenWidth / 2.4,
                      fillColor: lightBlackColor,
                      filled: true,
                      onEditingComplete: () {
                        FocusScope.of(context).nextFocus();
                      },
                      onChanged: (String value) {},
                    ),
                    const Space(height: 20),
                    const Divider(
                      color: greyColor,
                      height: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: BlocConsumer<FilterCubit, FilterState>(
              listener: (context, state) {
                if (state is GetFilterErrorState) {
                  showToast(state.message);
                }
                if (state is GetFilterSuccessState) {
                  filterBloc.selectedMarker = null;

                  sl<AppNavigator>().pop();
                  // sl<AppNavigator>().pushReplacement(
                  //     screen: HomeScreen(
                  //   isMap: false,
                  //   isClicked: true,
                  // ));
                }
              },
              builder: (context, filterState) {
                final filterBloc = context.watch<FilterCubit>();
                if (filterState is GetFilterLoadingState) {
                  return const Loading();
                }
                return GradiantButton(
                  title: tr("search_for_ads"),
                  tap: (() {
                    // filterBloc.buildingTypeSelectedId = userType;
                    filterBloc.changeSelectedId(newId: userType);
                    context.read<FilterCubit>().fgetFilterData(
                          map: 1,
                          isFirst: true,
                          //  status: "published",
                          age: ageOfPropertyController.text,
                          mindistance: lowAreaController.text,
                          maxdistance: highAreaController.text,
                          minprice: lowPriceController.text,
                          maxprice: highPriceController.text,
                          buildingtype: userType,
                          apartmentscount: apartmentCountController.text,
                          bedroomscount: bedRoomsCountController.text,
                          // bathroomsCount:
                          // bathroomsCountController.text,
                          shopscount: shopsController.text,
                          interface: interfaceController.text,
                          streetwidth: streetViewController.text,
                        );
                  }),
                );
              },
            ),
          ),
          const Space(height: 10),
        ],
      ),
    );
  }
}
