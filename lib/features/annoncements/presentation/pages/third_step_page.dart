import 'dart:developer';

import 'package:easy_localization/easy_localization.dart' as e;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/dimenssions/screenutil.dart';
import '../../../../core/constant/images.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/util/validator.dart';
import '../../../../core/widgets/master_textfield.dart';
import '../../../../core/widgets/space.dart';
import '../../../home/presentation/cubit/add_annoncement/addannoncement_cubit.dart';
import '../../../home/presentation/cubit/network_types/get_network_types_cubit.dart';
import '../../../home/presentation/cubit/network_types/network_types_state.dart';
import '../widgets/check_box_widget.dart';
import '../widgets/check_container.dart';

class ThirdStepScreen extends StatefulWidget {
  const ThirdStepScreen({super.key});

  @override
  State<ThirdStepScreen> createState() => _ThirdStepScreenState();
}

class _ThirdStepScreenState extends State<ThirdStepScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetNetWorkTypesCubit>().fGetNetWorkTypes();
    context.read<AddAnnouncementCubit>().selectedIds = [];
  }

  void removeFoucs() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AddAnnouncementCubit>();
    return Form(
      key: bloc.formKey3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Space(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e.tr("bed_rooms"),
                    style: TextStyles.textViewBold15.copyWith(color: textColor),
                  ),
                  const Space(height: 10),
                  MasterTextField(
                    hintText: "",
                    controller: bloc.bedRoomsController,
                    keyboardType: TextInputType.number,
                    validate: (value) => Validator.numbers(value),
                    width: screenWidth / 2.4,
                    fillColor: lightBlackColor,
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
                    e.tr("additional_rooms"),
                    style: TextStyles.textViewBold15.copyWith(color: textColor),
                  ),
                  const Space(height: 10),
                  MasterTextField(
                    filled: true,
                    width: screenWidth / 2.4,
                    fillColor: lightBlackColor,
                    hintText: "",
                    controller: bloc.additionalController,
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
          const Space(height: 20),
          SizedBox(
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Text(
                //       e.tr("number_of_rooms"),
                //       style:
                //           TextStyles.textViewBold15.copyWith(color: textColor),
                //     ),
                //     const Space(boxHeight: 10),
                //     MasterTextField(
                //       hintText: "",
                //       controller: bloc.roomsCountController,
                //       keyboardType: TextInputType.number,
                //       validate: (value) => Validator.numbers(value),
                //       width: screenWidth / 2.4,
                //       fillColor: lightBlackColor,
                //       filled: true,
                //       onEditingComplete: () {
                //         FocusScope.of(context).nextFocus();
                //       },
                //       onChanged: (String value) {},
                //     ),
                //   ],
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e.tr("bathrooms"),
                      style:
                          TextStyles.textViewBold15.copyWith(color: textColor),
                    ),
                    const Space(height: 10),
                    MasterTextField(
                      filled: true,
                      width: screenWidth / 1.16,
                      fillColor: lightBlackColor,
                      hintText: "",
                      controller: bloc.bathRoomsCountController,
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
          const Divider(
            color: greyColor,
            height: 1,
          ),
          const Space(height: 20),
          Text(
            e.tr("additional_data"),
            style: TextStyles.textViewBold15.copyWith(color: textColor),
          ),
          const Space(height: 10),
          CheckContainer(
            onTap1: (t) {
              setState(() {
                bloc.isCelected = !bloc.isCelected;
              });
              removeFoucs();
            },
            onTap2: (t) {
              setState(() {
                bloc.isCelected1 = !bloc.isCelected1;
              });
              removeFoucs();
            },
            text1: e.tr("driver's_room"),
            text2: e.tr("appendix"),
            value1: bloc.isCelected,
            value2: bloc.isCelected1,
          ),
          const Space(height: 10),
          CheckContainer(
            onTap1: (t) {
              setState(() {
                bloc.isCelected2 = !bloc.isCelected2;
              });
              removeFoucs();
            },
            onTap2: (t) {
              setState(() {
                bloc.monsters = !bloc.monsters;
              });
              removeFoucs();
            },
            text1: e.tr("maid's_room"),
            text2: e.tr("monsters"),
            value1: bloc.isCelected2,
            value2: bloc.monsters,
          ),
          const Space(height: 10),
          CheckContainer(
            onTap1: (t) {
              setState(() {
                bloc.isCelected4 = !bloc.isCelected4;
              });
              removeFoucs();
            },
            onTap2: (t) {
              setState(() {
                bloc.isCelected5 = !bloc.isCelected5;
              });
              removeFoucs();
            },
            text1: e.tr("swimming_pool"),
            text2: e.tr("elevator"),
            value1: bloc.isCelected4,
            value2: bloc.isCelected5,
          ),
          const Space(height: 10),
          CheckContainer(
            onTap1: (t) {
              setState(() {
                bloc.isCelected6 = !bloc.isCelected6;
              });
              removeFoucs();
            },
            onTap2: (t) {
              setState(() {
                bloc.isCelected7 = !bloc.isCelected7;
              });
              removeFoucs();
            },
            text1: e.tr("car_intrance"),
            text2: e.tr("kitchen"),
            value1: bloc.isCelected6,
            value2: bloc.isCelected7,
          ),
          const Space(height: 10),
          CheckContainer(
            onTap1: (t) {
              setState(() {
                bloc.isCelected8 = !bloc.isCelected8;
              });
              removeFoucs();
            },
            onTap2: (t) {
              setState(() {
                bloc.isCelected9 = !bloc.isCelected9;
              });
              removeFoucs();
            },
            text1: e.tr("external_stair"),
            text2: e.tr("roof"),
            value1: bloc.isCelected8,
            value2: bloc.isCelected9,
          ),
          const Space(height: 20),
          const Divider(
            color: greyColor,
            height: 1,
          ),
          const Space(height: 20),
          Text(
            e.tr("additional_features"),
            style: TextStyles.textViewBold15.copyWith(color: textColor),
          ),
          const Space(height: 10),
          SizedBox(
            width: screenWidth,
            // color: Colors.grey,
            // height: 50,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: screenWidth / 3,
                      child: CheckBoxWidge(
                        onTap: (t) {
                          setState(() {
                            bloc.value1 = !bloc.value1;
                          });
                          removeFoucs();
                        },
                        title: e.tr("duplex"),
                        value: bloc.value1,
                      ),
                    ),
                    SizedBox(
                      width: screenWidth / 3,
                      child: CheckBoxWidge(
                        onTap: (t) {
                          setState(() {
                            bloc.value2 = !bloc.value2;
                          });
                        },
                        title: e.tr("air_conditioner"),
                        value: bloc.value2,
                      ),
                    ),
                    SizedBox(
                      width: screenWidth / 3,
                      child: CheckBoxWidge(
                        onTap: (t) {
                          setState(() {
                            bloc.value3 = !bloc.value3;
                          });
                          removeFoucs();
                        },
                        title: e.tr("basement"),
                        value: bloc.value3,
                      ),
                    ),
                    SizedBox(
                      width: screenWidth / 3,
                      child: CheckBoxWidge(
                        onTap: (t) {
                          setState(() {
                            bloc.isCelected3 = !bloc.isCelected3;
                          });
                          removeFoucs();
                        },
                        title: e.tr("separated"),
                        value: bloc.isCelected3,
                      ),
                    ),
                    // SizedBox(
                    //   width: screenWidth / 4,
                    //   child: CheckBoxWidge(
                    //     onTap: (t) {
                    //       setState(() {
                    //         bloc.value4 = !bloc.value4;
                    //       });
                    //     },
                    //     title: e.tr("duplex"),
                    //     value: bloc.value4,
                    //   ),
                    // ),
                  ]),
            ),
          ),
          const Space(height: 20),
          const Divider(
            color: greyColor,
            height: 1,
          ),
          const Space(height: 20),
          Text(
            e.tr("coverage"),
            style: TextStyles.textViewBold15.copyWith(color: textColor),
          ),
          const Space(height: 10),
          SizedBox(
            width: screenWidth,
            // color: Colors.grey,
            // height: 50,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  BlocBuilder<GetNetWorkTypesCubit, GetNetWorkTypesState>(
                    builder: (context, state) {
                      final netWorkTypesBloc =
                          context.read<GetNetWorkTypesCubit>();
                      return state is GetNetWorkTypesErrorState
                          ? Center(
                              child: Text(state.message),
                            )
                          : Wrap(
                              children: List.generate(
                                  netWorkTypesBloc.data.length, (index) {
                                return GestureDetector(
                                    onTap: () {
                                      netWorkTypesBloc.chooseNetWorkType(
                                          netWorkTypesBloc.data[index].id
                                              .toString());
                                      bloc.netWorkType = netWorkTypesBloc
                                          .data[index].id
                                          .toString();

                                      // BlocProvider.of<AddannoncementCubit>(
                                      //             context)
                                      //         .addAnnoncementParams
                                      //         .networkTypeId =
                                      //     netWorkTypesBloc.data[index].id;
                                      removeFoucs();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              // Theme(
                                              //   data: ThemeData.dark(),
                                              //   child: Radio<String>(
                                              //     activeColor: mainColor,
                                              //     value: netWorkTypesBloc
                                              //         .data[index].id
                                              //         .toString(),
                                              //     groupValue: bloc.netWorkType,
                                              //     onChanged: (value) {
                                              //       netWorkTypesBloc
                                              //           .chooseNetWorkType(
                                              //               value.toString());
                                              //       bloc.netWorkType =
                                              //           value.toString();

                                              //       BlocProvider.of<AddannoncementCubit>(
                                              //                   context)
                                              //               .addAnnoncementParams
                                              //               .networkTypeId =
                                              //           int.parse(value!);
                                              //       removeFoucs();
                                              //     },
                                              //   ),
                                              // ),
                                              Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          bloc.addSelectedNetworkIdList(
                                                              netWorkTypesBloc
                                                                  .data[index]
                                                                  .id);
                                                        });
                                                        log("${bloc.selectedIds.length}===================");
                                                      },
                                                      child: Container(
                                                        height: 70,
                                                        width: 70,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                width: 4,
                                                                color: bloc
                                                                        .selectedIds
                                                                        .contains(netWorkTypesBloc
                                                                            .data[
                                                                                index]
                                                                            .id)
                                                                    ? mainColor
                                                                    : blackColor),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color:
                                                                lightBlackColor),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          5.0)),
                                                          child: Image.network(
                                                              netWorkTypesBloc
                                                                  .data[index]
                                                                  .image,
                                                              height: 100,
                                                              errorBuilder: (context,
                                                                      error,
                                                                      stackTrace) =>
                                                                  Image.asset(
                                                                      logoImage),
                                                              width: 100,
                                                              fit: BoxFit.fill),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Center(
                                                    child: Text(
                                                        netWorkTypesBloc
                                                            .data[index].name,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyles
                                                            .textViewMedium18
                                                            .copyWith(
                                                                color:
                                                                    mainColor)),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ));
                              }),
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
          // SizedBox(
          //   width: screenWidth,
          //   child: FittedBox(
          //     child: Row(
          //       children: [
          //         InkWell(
          //           onTap: () {
          //             setState(() {
          //               bloc.tapped1 = true;
          //               bloc.tapped2 = false;
          //               bloc.tapped3 = false;
          //             });
          //           },
          //           child: AnnonceContainer(
          //             isStep: true, png: true,
          //             pngImage: mobili,
          //             // imageColor: tapped1 ? mainColor : white,
          //             image: annoncement,
          //             borderColor: bloc.tapped1 ? mainColor : lightBlackColor,
          //             title: "",
          //             titleColor: bloc.tapped1 ? mainColor : white,
          //           ),
          //         ),
          //         const Space(
          //           boxWidth: 10,
          //         ),
          //         InkWell(
          //           onTap: () {
          //             setState(() {
          //               bloc.tapped2 = true;
          //               bloc.tapped1 = false;
          //               bloc.tapped3 = false;
          //             });
          //           },
          //           child: AnnonceContainer(
          //             isStep: true, png: true,
          //             pngImage: zein,
          //             borderColor: bloc.tapped2 ? mainColor : lightBlackColor,
          //             // imageColor: tapped2 ? mainColor : white,
          //             image: annoncement,
          //             title: "",
          //             titleColor: bloc.tapped2 ? mainColor : white,
          //           ),
          //         ),
          //         const Space(
          //           boxWidth: 10,
          //         ),
          //         InkWell(
          //           onTap: () {
          //             setState(() {
          //               bloc.tapped3 = true;
          //               bloc.tapped2 = false;
          //
          //               bloc.tapped1 = false;
          //             });
          //           },
          //           child: AnnonceContainer(
          //             isStep: true,
          //             borderColor: bloc.tapped3 ? mainColor : lightBlackColor,
          //             // imageColor: tapped3 ? mainColor : white,
          //             image: annoncement,
          //             png: true,
          //             pngImage: stc,
          //             title: "",
          //             titleColor: bloc.tapped3 ? mainColor : white,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
