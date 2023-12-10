import 'dart:developer';

import 'package:easy_localization/easy_localization.dart' as e;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/dimenssions/screenutil.dart';
import '../../../../core/constant/images.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/util/app_navigator.dart';
import '../../../../core/util/validator.dart';
import '../../../../core/widgets/master_textfield.dart';
import '../../../../core/widgets/space.dart';
import '../../../../injection_container/injection_container.dart';
import '../../../auth/presentation/cubit/get_real_states/cubit/get_real_states_cubit.dart';
import '../../../home/domain/models/filter.dart';
import '../../../home/presentation/cubit/update_annoncement/cubit/update_annoncement_cubit.dart';
import '../../../map/presentation/map_screen.dart';

class FirstStepUpdatePage extends StatefulWidget {
  final AnnounceData data;
  const FirstStepUpdatePage({super.key, required this.data});

  @override
  State<FirstStepUpdatePage> createState() => _FirstStepUpdatePageState();
}

class _FirstStepUpdatePageState extends State<FirstStepUpdatePage> {
  void checkRadio(String value) {
    final bloc = context.read<UpdateAnnoncementCubit>();
    setState(() {
      bloc.groupValue = value;
    });
  }

  void checkRadio2(String value) {
    final bloc = context.read<UpdateAnnoncementCubit>();
    setState(() {
      bloc.groupValue2 = value;
    });
  }

  void removeFoucs() {
    FocusScope.of(context).unfocus();
  }

  @override
  void initState() {
    context.read<UpdateAnnoncementCubit>().isFromDashboard = widget.data.fromDashboard;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userTypeBloc = context.read<GetRealStatesCubit>();
    final bloc = context.read<UpdateAnnoncementCubit>();
    return Form(
      key: bloc.formKey1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            e.tr("address"),
            style: TextStyles.textViewBold15.copyWith(color: textColor),
          ),
          const Space(
            height: 10,
          ),

          MasterTextField(
            hintText: "",
            enabled: true,
            onTap: () {
              sl<AppNavigator>().push(
                  screen: PickLocationMapScreen(
                perviousLatLng: LatLng(double.parse(widget.data.lat),
                    double.parse(widget.data.long)),
                controller: bloc.addressController,
              ));
            },
            textDirection: TextDirection.ltr,
            keyboardType: TextInputType.name,
            controller: bloc.addressController,
            fillColor: lightBlackColor,
            filled: true,
            validate: (value) => Validator.defaultValidator(value),
            onEditingComplete: () {
              FocusScope.of(context).nextFocus();
            },
            onChanged: (String value) {},
          ),

          const Space(height: 20),
          Text(
            e.tr("phone"),
            style: TextStyles.textViewBold15.copyWith(color: textColor),
          ),
          const Space(height: 10),
          MasterTextField(
            hintText: e.tr("enter_phone"),
            controller: bloc.phoneController,
            keyboardType: TextInputType.number,
            fillColor: lightBlackColor,
            validate: (value) => Validator.phone(value),
            filled: true,
            onEditingComplete: () {
              removeFoucs();
            },
            onChanged: (String value) {},
          ),
          const Space(height: 20),
          Text(
            e.tr("purpose"),
            style: TextStyles.textViewBold15.copyWith(color: textColor),
          ),
          const Space(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Row(
              children: [
                Theme(
                  data: ThemeData.dark(),
                  child: Radio(
                      fillColor:
                          MaterialStateProperty.all(const Color(0xFFCBA588)),
                      activeColor: const Color(0xFFCBA588),
                      value: 'commercial',
                      groupValue: bloc.groupValue,
                      onChanged: (value) {
                        bloc.purpose = 'commercial';
                        checkRadio(value!);
                        bloc.purpose = value;
                        // checkRadio('commercial');
                        BlocProvider.of<UpdateAnnoncementCubit>(context)
                            .updateAnnoncementParams
                            .purpose = value;
                        removeFoucs();
                      }),
                ),
                Text(
                  e.tr("commercial"),
                  style: const TextStyle(fontSize: 15, color: mainColor),
                )
              ],
            ),
            const Space(
              width: 5,
            ),
            Row(
              children: [
                Theme(
                  data: ThemeData.dark(),
                  child: Radio(
                      fillColor:
                          MaterialStateProperty.all(const Color(0xFFCBA588)),
                      activeColor: const Color(0xFFCBA588),
                      value: 'residential',
                      groupValue: bloc.groupValue,
                      onChanged: (value) {
                        bloc.purpose = value!;
                        bloc.purpose = 'residential';
                        checkRadio(value);

                        // checkRadio('residential');
                        BlocProvider.of<UpdateAnnoncementCubit>(context)
                            .updateAnnoncementParams
                            .purpose = value;
                        log("ssssss==$value");
                        removeFoucs();
                      }),
                ),
                Text(
                  e.tr("residential"),
                  style: const TextStyle(fontSize: 15, color: mainColor),
                )
              ],
            ),
            const Space(
              width: 10,
            ),
          ]),
          Text(
            e.tr("property_type"),
            style: TextStyles.textViewBold15.copyWith(color: textColor),
          ),
          const Space(
            height: 10,
          ),
          SizedBox(
            width: screenWidth,
            child: BlocBuilder<GetRealStatesCubit, GetRealStatesState>(
              builder: (context, state) {
                return state is GetRealStatesErrorState
                    ? Center(
                        child: Text(state.message),
                      )
                    : SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                              userTypeBloc.raelStateList.length, (index) {
                            return Row(
                              children: [
                                Theme(
                                  data: ThemeData.dark(),
                                  child: Radio<String>(
                                    activeColor: mainColor,
                                    value: userTypeBloc.raelStateList[index].id
                                        .toString(),
                                    groupValue: bloc.groupValue2,
                                    onChanged: (value) {
                                      checkRadio2(value!);
                                      userTypeBloc
                                          .chooseRealState(value.toString());
                                      bloc.buildingTypeId = value.toString();

                                      BlocProvider.of<UpdateAnnoncementCubit>(
                                              context)
                                          .updateAnnoncementParams
                                          .buildingTypeId = int.parse(value);
                                      removeFoucs();
                                    },
                                  ),
                                ),
                                Text(userTypeBloc.raelStateList[index].name,
                                    style: TextStyles.textViewMedium18
                                        .copyWith(color: mainColor)),
                              ],
                            );
                          }),
                        ),
                      );
              },
            ),
          ),
          const Space(height: 10),
          Text(
            e.tr("determine_price"),
            style: TextStyles.textViewBold15.copyWith(color: textColor),
          ),
          const Space(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: MasterTextField(
                  hintText: e.tr("low_price"),
                  controller: bloc.lowPriceController,
                  keyboardType: TextInputType.number,
                  validate: (value) =>
                      Validator.price(value, bloc.highPriceController.text),
                  width: screenWidth / 2.4,
                  fillColor: lightBlackColor,
                  filled: true,
                  onEditingComplete: () {
                    FocusScope.of(context).nextFocus();
                  },
                  onChanged: (String value) {},
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: MasterTextField(
                  filled: true,
                  width: screenWidth / 2.4,
                  fillColor: lightBlackColor,
                  hintText: e.tr("high_price"),
                  validate: (value) =>
                      Validator.priceMax(value, bloc.lowPriceController.text),
                  controller: bloc.highPriceController,
                  keyboardType: TextInputType.number,
                  onEditingComplete: () {
                    FocusScope.of(context).nextFocus();
                  },
                  onChanged: (String value) {},
                ),
              )
            ],
          ),
          const Space(height: 20),
          Text(
            e.tr("determine_area"),
            style: TextStyles.textViewBold15.copyWith(color: textColor),
          ),
          const Space(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: MasterTextField(
                  hintText: e.tr("low_distance"),
                  controller: bloc.lowDistanceController,
                  keyboardType: TextInputType.number,
                  width: screenWidth / 2.4,
                  fillColor: lightBlackColor,
                  validate: (value) =>
                      Validator.area(value, bloc.highDistanceController.text),
                  filled: true,
                  onEditingComplete: () {
                    FocusScope.of(context).nextFocus();
                  },
                  onChanged: (String value) {},
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: MasterTextField(
                  filled: true,
                  width: screenWidth / 2.4,
                  fillColor: lightBlackColor,
                  hintText: e.tr("high_distance"),
                  controller: bloc.highDistanceController,
                  keyboardType: TextInputType.phone,
                  validate: (value) =>
                      Validator.areaMax(value, bloc.lowDistanceController.text),
                  onEditingComplete: () {
                    FocusScope.of(context).nextFocus();
                  },
                  onChanged: (String value) {},
                ),
              ),
            ],
          ),
          const Space(height: 20),
          const Divider(
            color: greyColor,
            height: 1,
          ),
          const Space(height: 20),
          SizedBox(
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e.tr("number_of_apartments"),
                      style:
                          TextStyles.textViewBold15.copyWith(color: textColor),
                    ),
                    const Space(height: 10),
                    MasterTextField(
                      hintText: "",
                      controller: bloc.apartmentCountController,
                      width: screenWidth / 2.4,
                      fillColor: lightBlackColor,
                      keyboardType: TextInputType.number,
                      validate: (value) => Validator.numbers(value),
                      filled: true,
                      onEditingComplete: () {
                        FocusScope.of(context).nextFocus();
                      },
                      onChanged: (String value) {},
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e.tr("stores"),
                      style:
                          TextStyles.textViewBold15.copyWith(color: textColor),
                    ),
                    const Space(height: 10),
                    MasterTextField(
                      filled: true,
                      width: screenWidth / 2.4,
                      fillColor: lightBlackColor,
                      hintText: "",
                      controller: bloc.storesController,
                      keyboardType: TextInputType.number,
                      validate: (value) => Validator.numbers(value),
                      onEditingComplete: () {
                        FocusScope.of(context).nextFocus();
                      },
                      onChanged: (String value) {},
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Space(height: 20),
          Text(
            e.tr("street_view"),
            style: TextStyles.textViewBold15.copyWith(color: textColor),
          ),
          const Space(height: 10),
          MasterTextField(
            hintText: "",
            controller: bloc.streetWidthController,
            keyboardType: TextInputType.number,
            validate: (value) => Validator.numbers(value),
            fillColor: lightBlackColor,
            filled: true,
            onEditingComplete: () {
              FocusScope.of(context).nextFocus();
            },
            onChanged: (String value) {},
          ),
          const Space(height: 20),
          Text(
            e.tr("interface"),
            style: TextStyles.textViewBold15.copyWith(color: textColor),
          ),
          const Space(height: 10),
          MasterTextField(
            hintText: e.tr("interface"),
            controller: bloc.interFaceController,
            keyboardType: TextInputType.text,
            validate: (value) => Validator.defaultEmptyValidator(value),
            fillColor: lightBlackColor,
            filled: true,
            onEditingComplete: () {
              FocusScope.of(context).nextFocus();
            },
            onChanged: (String value) {},
          ),

          const Space(height: 20),
          Text(
            e.tr("the_age_of_the_property"),
            style: TextStyles.textViewBold15.copyWith(color: white),
          ),
          const Space(height: 10),
          MasterTextField(
            hintText: "",
            controller: bloc.ageController,
            keyboardType: TextInputType.text,
            validate: (value) => Validator.defaultEmptyValidator(value),
            fillColor: lightBlackColor,
            filled: true,
            onEditingComplete: () {
              FocusScope.of(context).nextFocus();
            },
            onChanged: (String value) {},
          ),
          const Space(height: 10),
          const Divider(
            color: greyColor,
            height: 1,
          ),
          const Space(height: 20),
          Text(
            e.tr("description_of_the_property"),
            style: TextStyles.textViewBold15.copyWith(color: textColor),
          ),
          const Space(
            height: 10,
          ),
          MasterTextField(
            hintText: "",
            maxLines: 7,
            minLines: 3,
            fillColor: lightBlackColor,
            filled: true,
            fieldHeight: 120,
            controller: bloc.decsController,
            keyboardType: TextInputType.multiline,
            onChanged: (value) {},
            validate: (value) => Validator.defaultValidator(value),
          ),
          const Space(height: 20),
          Text(
            e.tr("authorization_number"),
            style: TextStyles.textViewBold15.copyWith(color: textColor),
          ),
          const Space(
            height: 10,
          ),
          MasterTextField(
            hintText: "",
            textDirection: TextDirection.ltr,
            keyboardType: TextInputType.number,
            fillColor: lightBlackColor,
            // validate: (value) => Validator.numbers(value),
            filled: true,
            controller: bloc.advLicenseNumber,
            onEditingComplete: () {
              FocusScope.of(context).nextFocus();
            },
          ),
          const Space(height: 20),
          Container(
            height: 58,
            width: screenWidth,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                color: const Color.fromARGB(255, 92, 76, 58).withOpacity(.9)),
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 17,
                      width: 25,
                      child: SvgPicture.asset(
                        terms,
                        color: textColor,
                        height: 12,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: screenWidth / 1.3,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          e.tr("annonce_text"),
                          style: TextStyles.textViewRegular12
                              .copyWith(color: textColor),
                        ),
                      ),
                    )
                  ],
                )),
          ),
          // const Space(boxHeight: 20),
          // Text(
          //   e.tr("location"),
          //   style: TextStyles.textViewBold15.copyWith(color: textColor),
          // ),
          // const Space(
          //   boxHeight: 10,
          // ),
          // MasterTextField(
          //   hintText: e.tr("add_google_link_here"),
          //   textDirection: TextDirection.ltr,
          //   keyboardType: TextInputType.name,
          //   controller: bloc.addressController,
          //   fillColor: lightBlackColor,
          //   filled: true,
          //   onEditingComplete: () {
          //     FocusScope.of(context).nextFocus();
          //   },
          //   onChanged: (String value) {},
          // ),
          // const Space(boxHeight: 20),
          // Container(
          //   height: 130,
          //   width: screenWidth,
          //   decoration: const BoxDecoration(
          //     borderRadius: BorderRadius.all(Radius.circular(10.0)),
          //   ),
          //   child: ClipRRect(
          //     borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          //     child: CachedNetworkImage(
          //       imageUrl:
          //           "https://i.pinimg.com/564x/1d/ec/f3/1decf39e58d8f957b8fc7d3f3ac9ee1e.jpg",
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          const Space(height: 20),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 10),
          //       child: Text(e.tr("whdat"),
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
          //         value: whdat,
          //         borderRadius: 30.0,
          //         padding: 2,
          //         showOnOff: false,
          //         onToggle: (val) {
          //           setState(() {
          //             whdat = !whdat;
          //           });
          //         }),
          //   ],
          // ),
          _fromDashboardSection,
        ],
      ),
    );
  }

  Widget get _fromDashboardSection => StatefulBuilder(
    builder: (context, setCheckboxState) {
      return Row(
        children: [
          Text(
            e.tr('mohammed_alusaifer_aqars'),
            style: TextStyles.textViewSemiBold14.copyWith(
              color: Colors.white,
              fontSize: 15.r,
            ),
          ),
          Switch.adaptive(
            value: context.read<UpdateAnnoncementCubit>().isFromDashboard,
            activeColor: Colors.white,
            activeTrackColor: mainColor,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey,
            onChanged: (t) {
              setCheckboxState(() {
                context.read<UpdateAnnoncementCubit>().isFromDashboard = !context.read<UpdateAnnoncementCubit>().isFromDashboard;
                log('Update Ad isFromDashboardSelected: ${context.read<UpdateAnnoncementCubit>().isFromDashboard}');
              });
            },
          ),
        ],
      );
    },
  );
}
