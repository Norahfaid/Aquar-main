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
import '../../../home/domain/usecase/add_annonce.dart';
import '../../../home/presentation/cubit/add_annoncement/addannoncement_cubit.dart';
import '../../../home/presentation/cubit/get_user_ads_count/cubit/get_user_ads_count_cubit.dart';
import 'first_step_page.dart';
import 'second_step_page.dart';
import 'third_step_page.dart';

class AddAnnouncementScreen extends StatefulWidget {
  const AddAnnouncementScreen({super.key, required this.advType});
  final AdvType advType;
  @override
  State<AddAnnouncementScreen> createState() => _AddAnnouncementScreenState();
}

class _AddAnnouncementScreenState extends State<AddAnnouncementScreen> {
  int itemCount = 2;
  bool tappedCancel = false;
  bool isVisibile = true;
  bool isActive = false;
  bool canceledOrder = true;
  int _activeCurrentStep = 0;

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
          content: const FirstStepPage(),
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
          content: const SecondStepPage(),
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
            content: const ThirdStepScreen())
      ];

  @override
  void initState() {
    super.initState();
    context.read<AddAnnouncementCubit>().clearData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: DefaultAppBar(
        title: e.tr("add_announcement"),
        ontapLeading: () {
          sl<AppNavigator>().pop();
        },
      ),
      body: Stack(
        children: [
          Theme(
            data: ThemeData(
                canvasColor: blackColor,
                colorScheme: const ColorScheme.light(primary: mainColor)
                // .copyWith(secondary: Colors.red)
                // .copyWith(secondary: Colors.blueAccent)
                ),
            child: Stepper(
              controlsBuilder: ((context, details) => Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: BlocConsumer<AddAnnouncementCubit,
                          AddannoncementState>(
                        listener: (context, state) {
                          if (state is AddAnnoncementErrorState) {
                            showToast(state.mesage);
                          }
                          if (state is AddAnnoncementSuccessState) {
                            context
                                .read<AddAnnouncementCubit>()
                                .clearData(context);
                            context
                                .read<GetUserAdsCountCubit>()
                                .fGetNetWorkTypes();
                            showToast(tr("add_annonce_text"));
                            sl<AppNavigator>()
                                .pushReplacement(screen: const Aquar());
                          }
                        },
                        builder: (context, state) {
                          final bloc = context.read<AddAnnouncementCubit>();
                          if (state is AddAnnoncementLoadingState) {
                            return const Loading();
                          }
                          return GradiantButton(
                              title: _activeCurrentStep == 2
                                  ? e.tr("save")
                                  : e.tr("next"),
                              tap: () {
                                FocusScope.of(context).unfocus();
                                if (_activeCurrentStep <=
                                    (stepList().length - 1)) {
                                  if (_activeCurrentStep == 0) {
                                    if (!bloc.formKey1.currentState!
                                        .validate()) {
                                      return;
                                    }
                                    if (bloc.purpose.isEmpty) {
                                      showToast(tr("add_poropse"));
                                      return;
                                    }
                                    if (bloc.addAnnoncementParams
                                            .buildingTypeId ==
                                        null) {
                                      showToast(tr("add_btype"));
                                      return;
                                    }

                                    setState(() {
                                      _activeCurrentStep = 1;
                                    });
                                  } else if (_activeCurrentStep == 1) {
                                    // if (bloc.addAnnoncementParams.video ==
                                    //     null) {
                                    //   showToast(tr("رابط الفيديو مطلوب"));
                                    //   return;
                                    // }
                                    FocusScope.of(context).unfocus();
                                    if (bloc.addAnnoncementParams.icon ==
                                        null) {
                                      FocusScope.of(context).unfocus();
                                      showToast(tr("please_select_photo"));
                                      return;
                                    }
                                    setState(() {
                                      _activeCurrentStep = 2;
                                    });
                                  } else if (_activeCurrentStep == 2) {
                                    if (!bloc.formKey3.currentState!
                                        .validate()) {
                                      return;
                                    }

                                    if (bloc.netWorkType.isEmpty) {
                                      showToast(tr("pick_cover_type"));
                                      return;
                                    }
                                    FocusScope.of(context).unfocus();
                                    context
                                        .read<AddAnnouncementCubit>()
                                        .fAddAnnoncement(
                                            advType: widget.advType,
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
                  )),

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
          Divider(
            color: lightGrey,
            height: 4,
            thickness: 2,
          ),
        ],
      ),
    );
  }
}
