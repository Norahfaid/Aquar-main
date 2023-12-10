import 'dart:async';

import 'package:aquar/features/annoncements/presentation/cubit/register_nafaz/register_nafaz_cubit.dart';
import 'package:aquar/features/annoncements/presentation/widgets/nafaz_dialog.dart';
import 'package:aquar/features/auth/presentation/cubit/login_cubit/cubit/login_cubit_cubit.dart';
import 'package:aquar/features/home/domain/usecase/add_annonce.dart';
import 'package:easy_localization/easy_localization.dart' as e;
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/images.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/util/app_navigator.dart';
import '../../../../core/util/validator.dart';
import '../../../../core/widgets/default_app_bar.dart';
import '../../../../core/widgets/gradiant_button.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/master_textfield.dart';
import '../../../../core/widgets/space.dart';
import '../../../../core/widgets/toast.dart';
import '../../../../injection_container/injection_container.dart';
import '../../../auth/presentation/cubit/get_profile/get_profile_cubit.dart';
import '../../../home/presentation/cubit/get_mine_filter_data/get_mine_filter_data_cubit.dart';
import '../../../home/presentation/cubit/get_user_ads_count/cubit/get_user_ads_count_cubit.dart';
import '../../../settings/presentation/cubit/terms_annonce/cubit/terms_annonce_cubit.dart';
import '../../../settings/presentation/cubit/terms_annonce/cubit/terms_annonce_state.dart';
import '../../../settings/presentation/pages/terms_adv_screen.sart.dart';
import '../widgets/advertiser_header.dart';
import '../widgets/annonce_types.dart';
import '../widgets/announce_tap_item.dart';
import 'add_annoncement_screen.dart';
import 'under_review_screen.dart';

class AnnoncementScreen extends StatefulWidget {
  const AnnoncementScreen({super.key});

  @override
  State<AnnoncementScreen> createState() => _AnnoncementScreenState();
}

class _AnnoncementScreenState extends State<AnnoncementScreen> {
  bool adsTap = true;
  bool requestMarketingAqarTap = false;
  bool addAuthorizedAdTap = false;
  bool isAddAdvertisementTermsAndConditionsSelected = false;
  final TextEditingController nationalIdTextController =
      TextEditingController();
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TermsAnnonceCubit>().fGetTermsAnnonce();
      context.read<GetUserAdsCountCubit>().fGetNetWorkTypes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: DefaultAppBar(
        title: e.tr("annoncement"),
        ontapLeading: () {
          sl<AppNavigator>().pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AdvertiserHeader(),
              const Space(height: 16),
              SizedBox(
                //height: screenHeight / 8,
                //width: screenWidth,
                child: FittedBox(
                  child: Column(
                    children: [
                      ///AdsTapItem
                      AnnounceTapItem(
                        onTap: () {
                          setState(() {
                            adsTap = true;
                            requestMarketingAqarTap = false;
                            addAuthorizedAdTap = false;
                          });
                        },
                        imageColor: adsTap ? mainColor : white,
                        image: annonce,
                        borderColor: adsTap ? mainColor : lightBlackColor,
                        title: e.tr("annoncement"),
                        titleColor: adsTap ? mainColor : white,
                      ),
                      const Space(
                        height: 10,
                      ),

                      ///MarketingAqarTapItem
                      AnnounceTapItem(
                        onTap: () {
                          setState(() {
                            requestMarketingAqarTap = true;
                            adsTap = false;
                            addAuthorizedAdTap = false;
                          });
                        },
                        borderColor: requestMarketingAqarTap
                            ? mainColor
                            : lightBlackColor,
                        imageColor: requestMarketingAqarTap ? mainColor : white,
                        image: plusCircle,
                        title: e.tr("real_estate_marketing_request"),
                        subtitle:
                            e.tr("real_estate_marketed_by_mohamed_alusaifer"),
                        titleColor: requestMarketingAqarTap ? mainColor : white,
                      ),
                      const Space(
                        height: 10,
                      ),

                      ///AuthorizedAdTapItem
                      AnnounceTapItem(
                        onTap: () {
                          setState(() {
                            addAuthorizedAdTap = true;
                            adsTap = false;
                            requestMarketingAqarTap = false;
                          });
                          final user = sl<LoginCubit>().user;
                          if (user.nafazComplete != null &&
                              user.nafazComplete == 0) {
                            showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (c) => Padding(
                                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                  child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12)),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(12),
                                                topRight: Radius.circular(12)),
                                          ),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Space(
                                                  height: 20,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(12),
                                                  child: Text(
                                                    e.tr("nafaz_note"),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyles.textViewMedium18
                                                        .copyWith(
                                                      color: white,
                                                    ),
                                                  ),
                                                ),
                                                const Space(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(10),
                                                  child: MasterTextField(
                                                    hintText:
                                                        e.tr("enter_national_id"),
                                                    textDirection: TextDirection.ltr,
                                                    controller:
                                                        nationalIdTextController,
                                                    keyboardType: TextInputType.text,
                                                    validate: (value) =>
                                                        Validator.defaultValidator(
                                                            value),
                                                    onEditingComplete: () =>
                                                        FocusScope.of(context)
                                                            .nextFocus(),
                                                  ),
                                                ),
                                                const Space(
                                                  height: 10,
                                                ),
                                                Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(16),
                                                    child: GradiantButton(
                                                      title: e.tr("check"),
                                                      tap: (() {
                                                        sl<AppNavigator>().pop();
                                                        context
                                                            .read<
                                                                RegisterNafazCubit>()
                                                            .registerNafaz(
                                                              nationalId:
                                                                  nationalIdTextController
                                                                      .text,
                                                            );
                                                      }),
                                                    ),
                                                  ),
                                                ),
                                                const Space(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                ),
                            );
                            return;
                          }
                          if (user.nafazComplete != null &&
                              user.nafazComplete == 1) {
                            sl<AppNavigator>().push(
                                screen: const AddAnnouncementScreen(
                              advType: AdvType.nafaz,
                            ));
                          }
                        },
                        borderColor:
                            addAuthorizedAdTap ? mainColor : lightBlackColor,
                        imageColor: addAuthorizedAdTap ? mainColor : white,
                        image: plusCircle,
                        title: e.tr("add_authorized_announcement"),
                        subtitle: e.tr("i_have_a_license_number"),
                        titleColor: addAuthorizedAdTap ? mainColor : white,
                      ),
                    ],
                  ),
                ),
              ),
              const Space(
                height: 48,
              ),

              ///TabBodySection
              Builder(
                builder: (context) {
                  if (requestMarketingAqarTap) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(e.tr("conditions_for_adding_an_ad"),
                            style: TextStyles.textViewBold20
                                .copyWith(color: white)),
                        // const Space(
                        //   boxHeight: 10,
                        // ),
                        // Text(e.tr("annonce_data"),
                        //     style: TextStyles.textViewRegular15
                        //         .copyWith(color: textColor)),
                        BlocConsumer<TermsAnnonceCubit, TermsAnnonceState>(
                          listener: (context, state) {
                            if (state is TermsAnnonceErrorState) {
                              showToast(state.message);
                            }
                          },
                          builder: (context, state) {
                            if (state is TermsAnnonceLoadingState) {
                              return const Loading();
                            }

                            if (state is TermsAnnonceSuccessState) {
                              return state.response.data.content == null
                                  ? Center(
                                      child: Text(e.tr("there_are_no_data")))
                                  : Column(children: [
                                      const Space(height: 8),
                                      Html(
                                        data: state.response.data.content,
                                        style: {
                                          "body": Style(
                                            fontSize: FontSize(16.0),
                                            color: white,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        },
                                      ),
                                    ]);
                            }

                            return const SizedBox();
                          },
                        ),
                        CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            checkColor: blackColor,
                            title: InkWell(
                              onTap: () {
                                context
                                    .read<TermsAnnonceCubit>()
                                    .fGetTermsAnnonce();
                                sl<AppNavigator>()
                                    .push(screen: const TermsAdvScreen());
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(e.tr("accept_terms"),
                                    style: TextStyles.textViewMedium15Underline
                                        .copyWith(color: mainColor)),
                              ),
                            ),
                            activeColor: mainColor,
                            value: isAddAdvertisementTermsAndConditionsSelected,
                            checkboxShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            side: const BorderSide(
                              color: mainColor,
                              width: 2,
                            ),
                            onChanged: (t) {
                              setState(() {
                                isAddAdvertisementTermsAndConditionsSelected =
                                    !isAddAdvertisementTermsAndConditionsSelected;
                              });
                            }),
                        const Space(height: 8),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: GradiantButton(
                              title: e.tr("add_announcement"),
                              tap: (() {
                                isAddAdvertisementTermsAndConditionsSelected ==
                                        true
                                    ? sl<AppNavigator>().push(
                                        screen: const AddAnnouncementScreen(
                                        advType: AdvType.markting,
                                      ))
                                    : showToast(e.tr("terms_required"));
                              }),
                            ),
                          ),
                        ),
                        const Space(height: 16),
                      ],
                    );
                  }
                  if (addAuthorizedAdTap) {
                    return BlocConsumer<RegisterNafazCubit, RegisterNafazState>(
                      listener: (context, state) {
                        if (state is RegisterNafazErrorState) {
                          showToast(state.message);
                        }
                      },
                      builder: (context, state) {
                        if (state is RegisterNafazLoadingState) {
                          return const Loading();
                        }
                        if (state is RegisterNafazLoadedState) {
                          return Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'nafaz_register_number'.tr(),
                                    style: TextStyles.textViewMedium16.copyWith(
                                      color: white,
                                    ),
                                  ),
                                  const Space(
                                    width: 16,
                                  ),
                                  const Space(
                                    height: 16,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(16.r),
                                    decoration: const BoxDecoration(
                                      color: mainColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: FittedBox(
                                      fit: BoxFit.fill,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          top: 8.r,
                                        ),
                                        child: Text(
                                          state.registerNafazUser
                                                  ?.nafazRandom ??
                                              '',
                                          style: TextStyles.textViewRegular20
                                              .copyWith(
                                            color: white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Space(
                                height: 16,
                              ),
                              BlocConsumer<GetProfileCubit, GetProfileState>(
                                listener: (BuildContext context, state) {
                                  if (state is GetProfileLoadedState) {
                                    if (state.profileData.nafazComplete == 0) {
                                      showToast(
                                          'please_complete_nafath_registration'
                                              .tr());
                                      return;
                                    }
                                    if (state.profileData.nafazComplete == 1) {
                                      sl<AppNavigator>().push(
                                          screen: const AddAnnouncementScreen(
                                        advType: AdvType.nafaz,
                                      ));
                                    }
                                  }
                                },
                                builder: (context, state) {
                                  if (state is GetProfileLoadingState) {
                                    return const Column(
                                      children: [
                                        Loading(),
                                        Space(
                                          height: 8,
                                        ),
                                      ],
                                    );
                                  }
                                  return GradiantButton(
                                    title: e.tr("go_now"),
                                    tap: () async {
                                      await LaunchApp.openApp(
                                        androidPackageName: 'sa.gov.nic.myid',
                                        iosUrlScheme: 'nafath://home',
                                        appStoreLink:
                                            "https://apps.apple.com/eg/app/%D9%86%D9%81%D8%A7%D8%B0-nafath/id1598909871",
                                      ).whenComplete(() {
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) {
                                            return const NafazRegistrationDialog();
                                          },
                                        );
                                      });
                                    },
                                  );
                                },
                              ),
                            ],
                          );
                        }
                        return const SizedBox();
                      },
                    );
                  }
                  //AdsTap
                  return BlocConsumer<GetUserAdsCountCubit,
                      GetUserAdsCountState>(
                    listener: (context, state) {
                      if (state is UserAdsCountsErrorState) {
                        showToast(state.message);
                      }
                    },
                    builder: (context, state) {
                      return state is UserAdsCountsSuccessState
                          ? Column(children: [
                              InkWell(
                                onTap: (() {
                                  context
                                      .read<GetMineFilterDataCubit>()
                                      .fGetMineFilter(
                                          isFirst: true, status: "pending");
                                  sl<AppNavigator>().push(
                                      screen: const UnderReviewScreen(
                                          status: "pending"));
                                }),
                                child: AnnonceTypes(
                                  amount:
                                      state.adsCount.data.pending.toString(),
                                  image: loading,
                                  title: e.tr("under_review"),
                                ),
                              ),
                              const Space(
                                height: 10,
                              ),
                              InkWell(
                                onTap: (() {
                                  context
                                      .read<GetMineFilterDataCubit>()
                                      .fGetMineFilter(
                                          isFirst: true, status: "published");
                                  sl<AppNavigator>().push(
                                      screen: const UnderReviewScreen(
                                          status: "published"));
                                }),
                                child: AnnonceTypes(
                                  amount:
                                      state.adsCount.data.published.toString(),
                                  image: check,
                                  title: e.tr("published"),
                                ),
                              ),
                              const Space(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  context
                                      .read<GetMineFilterDataCubit>()
                                      .fGetMineFilter(
                                          isFirst: true, status: "rejected");
                                  sl<AppNavigator>().push(
                                      screen: const UnderReviewScreen(
                                    status: "rejected",
                                  ));
                                },
                                child: AnnonceTypes(
                                  amount:
                                      state.adsCount.data.rejected.toString(),
                                  image: cross,
                                  title: e.tr("canceled"),
                                ),
                              ),
                              const Space(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  context
                                      .read<GetMineFilterDataCubit>()
                                      .fGetMineFilter(
                                          isFirst: true, status: "sold");
                                  sl<AppNavigator>().push(
                                      screen: const UnderReviewScreen(
                                          status: "sold"));
                                },
                                child: AnnonceTypes(
                                  amount: state.adsCount.data.sold.toString(),
                                  image: dolar,
                                  title: e.tr("sold"),
                                ),
                              ),
                            ])
                          : const Loading();
                    },
                  );
                },
              ),

              const Space(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
