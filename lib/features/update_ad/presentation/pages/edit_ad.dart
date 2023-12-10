import 'dart:io';

import 'package:aquar/core/constant/extenions.dart';
import 'package:aquar/features/update_ad/presentation/pages/second_step_update_page.dart';
import 'package:aquar/features/update_ad/presentation/pages/third_step_update_page.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:easy_localization/easy_localization.dart' as e;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/util/app_navigator.dart';
import '../../../../core/widgets/default_app_bar.dart';
import '../../../../core/widgets/gradiant_button.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/toast.dart';
import '../../../../injection_container/injection_container.dart';
import '../../../../main.dart';
import '../../../home/domain/models/filter.dart';
import '../../../home/presentation/cubit/get_user_ads_count/cubit/get_user_ads_count_cubit.dart';
import '../../../home/presentation/cubit/update_annoncement/cubit/update_annoncement_cubit.dart';
import 'first_step_update_page.dart';

enum DialogAction { cancel, delete }

class UpdateAnnoncementScreen extends StatefulWidget {
  final AnnounceData data;
  const UpdateAnnoncementScreen({super.key, required this.data});

  @override
  State<UpdateAnnoncementScreen> createState() =>
      _UpdateAnnoncementScreenState();
}

class _UpdateAnnoncementScreenState extends State<UpdateAnnoncementScreen> {
  int itemCount = 2;
  bool tappedCancel = false;
  bool isVisibile = true;
  bool isActive = false;
  bool canceledOrder = true;
  int _activeCurrentStep = 0;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<UpdateAnnoncementCubit>();
    bloc.latLng =
        "${widget.data.lat},${widget.data.long}".latLngFromStringServer();
    bloc.addressController.text = widget.data.address;
    bloc.phoneController.text = widget.data.phone;
    bloc.purpose = widget.data.purpose == 'سكني' ? 'residential' : 'commercial';
    bloc.groupValue =
        widget.data.purpose == 'سكني' ? 'residential' : 'commercial';
    bloc.groupValue2 = widget.data.buildingType.id.toString();
    bloc.advLicenseNumber.text = widget.data.advLicenseNumber.toString();
    bloc.updateAnnoncementParams.buildingTypeId = widget.data.buildingType.id;
    bloc.buildingTypeId = widget.data.buildingType.id.toString();
    bloc.lowPriceController.text = widget.data.minPrice.toString();
    bloc.highPriceController.text = widget.data.maxPrice.toString();
    bloc.lowDistanceController.text = widget.data.minDistance.toString();
    bloc.highDistanceController.text = widget.data.maxDistance.toString();
    bloc.apartmentCountController.text = widget.data.apartmentsCount.toString();
    bloc.storesController.text = widget.data.shopsCount.toString();
    bloc.streetWidthController.text = widget.data.streetWidth.toString();
    bloc.interFaceController.text = widget.data.interface.toString();
    bloc.ageController.text = widget.data.age.toString();
    bloc.decsController.text = widget.data.desc.toString();
    widget.data.videoLink != null
        ? bloc.videoLinkController.text = widget.data.videoLink!
        : null;
    bloc.updateAnnoncementParams.icon = dartz.Right(widget.data.icon);
    bloc.updateAnnoncementParams.video =
        widget.data.video != null ? dartz.Right(widget.data.video!) : null;
    List<ImageFilter> aquarImagesList = widget.data.aqarImages;
    List<dartz.Either<File, ImageFilter>> imagesInFile = [];
    for (var i in aquarImagesList) {
      imagesInFile.add(dartz.right(i));
    }
    bloc.updateAnnoncementParams.images = imagesInFile;
    bloc.imageFileList = imagesInFile;
    int totalRooms = int.parse(widget.data.bedroomsCount.toString()) +
        int.parse(widget.data.additionalRoomsCount.toString());
    bloc.roomsCountController.text = totalRooms.toString();
    bloc.bathRoomsCountController.text = widget.data.bathroomsCount.toString();
    bloc.bedRoomsController.text = widget.data.bedroomsCount.toString();
    bloc.additionalController.text =
        widget.data.additionalRoomsCount.toString();
    bloc.isCelected = widget.data.driverRoom == 1;
    bloc.isCelected1 = widget.data.supplement == 1;
    bloc.isCelected2 = widget.data.maidRoom == 1;
    bloc.monsters = widget.data.courtyard == 1;
    bloc.isCelected4 = widget.data.pool == 1;
    bloc.isCelected5 = widget.data.elevator == 1;
    bloc.isCelected6 = widget.data.carEntrance == 1;
    bloc.isCelected7 = widget.data.kitchen == 1;
    bloc.isCelected8 = widget.data.externalStaircase == 1;
    bloc.isCelected9 = widget.data.roof == 1;
    bloc.value1 = widget.data.duplex == 1;
    bloc.value2 = widget.data.airConditioner == 1;
    bloc.value3 = widget.data.basement == 1;
    bloc.isCelected3 = widget.data.separated == 1;
    // bloc.selectedNetWork = widget.data.networkTypes;
    bloc.initNetworkTypes(selectedNetWork: widget.data.networkTypes);
    // bloc.netWorkType = widget.data.networkType.id.toString();
    // bloc.updateAnnoncementParams.networkTypeId = widget.data.networkType.id;
  }

  void removeFoucs() {
    FocusScope.of(context).unfocus();
  }

  List<Step> stepList() => [
        Step(
          state:
              _activeCurrentStep <= 0 ? StepState.indexed : StepState.complete,
          isActive: _activeCurrentStep >= 0,
          title: FittedBox(
            child: Text(
              e.tr("information"),
              style: TextStyles.textViewRegular12.copyWith(
                  color: _activeCurrentStep >= 0
                      ? white
                      : lightGrey.withOpacity(.8)),
            ),
          ),
          content: FirstStepUpdatePage(data: widget.data),
        ),
        // This is Step2 here we will enter our address
        Step(
          state:
              _activeCurrentStep <= 1 ? StepState.indexed : StepState.complete,
          isActive: _activeCurrentStep >= 1,
          title: FittedBox(
            child: Text(
              e.tr("media"),
              style: TextStyles.textViewRegular12.copyWith(
                  color: _activeCurrentStep >= 1
                      ? white
                      : lightGrey.withOpacity(.9)),
            ),
          ),
          content: SecondStepUpdatePage(data: widget.data),
        ),
        Step(
            state: _activeCurrentStep <= 2
                ? StepState.indexed
                : StepState.complete,
            isActive: _activeCurrentStep >= 2,
            title: FittedBox(
              child: Text(
                e.tr("features_and_warranties"),
                style: TextStyles.textViewRegular12.copyWith(
                    color: _activeCurrentStep >= 2
                        ? white
                        : lightGrey.withOpacity(.9)),
              ),
            ),
            content: ThirdStepUpdateScreen(data: widget.data))
      ];
  // @override
  // void initState() {
  //   super.initState();
  //   context.read<UpdateAnnoncementCubit>().clearData();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: DefaultAppBar(
        title: e.tr("update_annoncement"),
        ontapLeading: () {
          sl<AppNavigator>().pop();
        },
        // leadingIcon: const Icon(
        //   Icons.keyboard_arrow_right,
        //   size: 30,
        // )
      ),
      body: Column(
        children: [
          Expanded(
            child: Theme(
              data: ThemeData(
                  canvasColor: blackColor,
                  colorScheme: const ColorScheme.light(primary: mainColor)
                  // .copyWith(secondary: Colors.red)
                  // .copyWith(secondary: Colors.blueAccent)
                  ),
              child: Stepper(
                controlsBuilder: (context, details) => const SizedBox(),
                type: StepperType.horizontal,
                currentStep: _activeCurrentStep,
                steps: stepList(),

                onStepContinue: () {
                  if (_activeCurrentStep < (stepList().length - 1)) {
                    setState(() {
                      _activeCurrentStep += 1;
                    });
                  }
                },
                // onStepCancel: () {
                //   if (_activeCurrentStep == 0) {
                //     return;
                //   }

                //   setState(() {
                //     _activeCurrentStep -= 1;
                //   });
                // },
                // onStepTapped: (int index) {
                //   setState(() {
                //     _activeCurrentStep = index;
                //   });
                // },
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child:
                  BlocConsumer<UpdateAnnoncementCubit, UpdateAnnoncementState>(
                listener: (context, state) {
                  if (state is UpdateAnnoncementErrorState) {
                    showToast(state.mesage);
                  }
                  if (state is UpdateAnnoncementSuccessState) {
                    // context.read<UpdateAnnoncementCubit>().clearData();
                    context.read<GetUserAdsCountCubit>().fGetNetWorkTypes();
                    sl<AppNavigator>().pushReplacement(screen: const Aquar());
                    showToast(tr("edit_annonce_text"));
                  }
                },
                builder: (context, state) {
                  final bloc = context.read<UpdateAnnoncementCubit>();
                  if (state is UpdateAnnoncementLoadingState) {
                    return const Loading();
                  }
                  return GradiantButton(
                      title:
                          _activeCurrentStep == 2 ? e.tr("save") : e.tr("next"),
                      tap: () {
                        FocusScope.of(context).unfocus();
                        if (_activeCurrentStep <= (stepList().length - 1)) {
                          if (_activeCurrentStep == 0) {
                            if (!bloc.formKey1.currentState!.validate()) {
                              return;
                            }
                            if (bloc.purpose.isEmpty) {
                              showToast(tr("add_poropse"));
                              return;
                            }
                            if (bloc.updateAnnoncementParams.buildingTypeId ==
                                null) {
                              showToast(tr("add_btype"));
                              return;
                            }
                            FocusScope.of(context).unfocus();

                            setState(() {
                              _activeCurrentStep = 1;
                            });
                          } else if (_activeCurrentStep == 1) {
                            // if (bloc.addAnnoncementParams.video ==
                            //     null) {
                            //   showToast(tr("رابط الفيديو مطلوب"));
                            //   return;
                            // }
                            if (bloc.updateAnnoncementParams.icon == null) {
                              showToast("يرجي إختيار صور للعقار");
                              return;
                            }
                            FocusScope.of(context).unfocus();

                            setState(() {
                              _activeCurrentStep = 2;
                            });
                          } else if (_activeCurrentStep == 2) {
                            if (!bloc.formKey3.currentState!.validate()) {
                              return;
                            }

                            if (bloc.netWorkType.isEmpty) {
                              showToast(tr("pick_cover_type"));
                              return;
                            }
                            FocusScope.of(context).unfocus();

                            context
                                .read<UpdateAnnoncementCubit>()
                                .fUpdateAnnoncement(
                                    // images: ,
                                    announceData: widget.data,
                                    formKey1: bloc.formKey1,
                                    formKey2: bloc.formKey2,
                                    formKey3: bloc.formKey3);
                          }
                        }
                      }

                      // AppNavigator.push(
                      //     context: context,
                      //     screen: const AddAnnoncementScreen());

                      );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
