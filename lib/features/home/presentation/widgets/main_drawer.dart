import 'package:aquar/features/settings/presentation/cubit/privacy_policy/privacy_policy_cubit.dart';
import 'package:aquar/features/settings/presentation/cubit/terms/terms_cubit.dart';
import 'package:aquar/features/settings/presentation/pages/privcay_policy_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/flutter_share.dart' as sh;
import 'package:flutter_svg/svg.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/dimenssions/screenutil.dart';
import '../../../../core/constant/images.dart';
import '../../../../core/constant/styles/sized_box.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/util/app_navigator.dart';
import '../../../../core/util/new_navigator/navigator.dart';
import '../../../../core/util/new_navigator/page_transiation.dart';
import '../../../../core/widgets/darwer_widget.dart';
import '../../../../core/widgets/guest_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/password_text_feild.dart';
import '../../../../core/widgets/space.dart';
import '../../../../core/widgets/toast.dart';
import '../../../../injection_container/injection_container.dart';
import '../../../annoncements/presentation/pages/annoncement_screen.dart';
import '../../../auth/presentation/cubit/auto_login/auto_login_cubit.dart';
import '../../../auth/presentation/cubit/delete_account/cubit/delete_cubit.dart';
import '../../../auth/presentation/cubit/get_profile/get_profile_cubit.dart';
import '../../../auth/presentation/cubit/login_cubit/cubit/login_cubit_cubit.dart';
import '../../../auth/presentation/cubit/logout/cubit/logot_cubit.dart';
import '../../../auth/presentation/cubit/logout/cubit/logot_state.dart';
import '../../../favourite/presentation/pages/favourities_screen.dart';
import '../../../settings/presentation/cubit/about_us/cubit/about_us_cubit.dart';
import '../../../settings/presentation/cubit/social_links/cubit/social_links_cubit.dart';
import '../../../settings/presentation/pages/contact_us_screen.dart';
import '../../../settings/presentation/pages/profile_screen.dart';
import '../../../settings/presentation/pages/terms_screen.dart';
import '../../../settings/presentation/pages/who_us_screen.dart';
import 'lang_modal_sheet.dart';
import 'logout_dialog.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  final ScrollController controller = ScrollController();
  bool isLoading = false;
  void toggleIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // final userBloc = context.watch<LoginCubit>().user;
    return Drawer(
      backgroundColor: blackColor,
      width: screenWidth,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<AutoLoginCubit, AutoLoginState>(
                    builder: (context, state) {
                  if (state is AutoLoginGuest) {
                    return const SizedBox(height: 80);
                  }
                  return const SizedBox();
                }),
                HideFromGuestWidget(
                    child: BlocBuilder<LoginCubit, LoginCubitState>(
                  builder: (context, state) {
                    final userBloc = context.watch<LoginCubit>().user;
                    return Padding(
                      padding: const EdgeInsets.only(
                          top: 50, bottom: 20, left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Material(
                            elevation: 3,
                            borderRadius: BorderRadius.circular(100),
                            child: CircleAvatar(
                              radius: 31,
                              backgroundColor: white,
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(userBloc.avatar),
                              ),
                              // CachedNetworkImageProvider(
                              //     user.avatar))),
                            ),
                            // CachedNetworkImageProvider(
                            //     user.avatar))),
                          ),
                          sizedBoxw10,
                          Text(
                            userBloc.name,
                            style: TextStyles.textViewBold20
                                .copyWith(color: textColor),
                          ),
                          const Space(
                            width: 10,
                          ),
                        ],
                      ),
                    );
                  },
                )),
                const Divider(
                  color: greyColor,
                  height: 1,
                ),
                Expanded(
                  child: Theme(
                    data: ThemeData(
                        primaryColor: white,
                        scrollbarTheme: ScrollbarThemeData(
                            thumbColor: MaterialStateProperty.resolveWith(
                          (states) {
                            if (states.contains(MaterialState.dragged)) {
                              return mainColor;
                            } else {
                              return mainColor;
                            }
                          },
                        ), trackColor:
                                MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.dragged)) {
                            return mainColor;
                          } else {
                            return mainColor;
                          }
                        }))),
                    child: Scrollbar(
                      trackVisibility: true,
                      controller: controller,
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        controller: controller,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BlocBuilder<AutoLoginCubit, AutoLoginState>(
                                builder: (context, state) {
                              if (state is AutoLoginGuest) {
                                return const SizedBox(height: 80);
                              }
                              return const SizedBox();
                            }),
                            HideFromGuestWidget(
                              child: DrawerWidget(
                                onTap: () {
                                  context.read<GetProfileCubit>().fGetProfile();
                                  Navigation.push(
                                    context,
                                    customPageTransition: PageTransition(
                                      child: const ProfileScreen(),
                                      type: PageTransitionType.fromBottom,
                                    ),
                                  );
                                },
                                image: user,
                                title: tr("profile"),
                              ),
                            ),
                            BlocBuilder<LoginCubit, LoginCubitState>(
                                builder: (context, state) {
                              if (sl<AutoLoginCubit>().isGuest) {
                                return DrawerWidget(
                                  onTap: () {
                                    sl<AutoLoginCubit>().loginOrFunction(
                                        context: context, function: () {});
                                  },
                                  image: annoncement,
                                  title: tr("annoncement"),
                                );
                              }
                              final userBloc = context.watch<LoginCubit>().user;
                              return userBloc.userType.kind == 'advertiser'
                                  ? DrawerWidget(
                                      onTap: () {
                                        Navigation.push(
                                          context,
                                          customPageTransition: PageTransition(
                                            child: const AnnoncementScreen(),
                                            type: PageTransitionType.fromBottom,
                                          ),
                                        );
                                      },
                                      image: annoncement,
                                      title: tr("annoncement"),
                                    )
                                  : const SizedBox();
                            }),
                            DrawerWidget(
                              onTap: () {
                                context.read<AboutUsCubit>().fGetAboutUs();
                                Navigation.push(
                                  context,
                                  customPageTransition: PageTransition(
                                    child: const WhoUsScreen(),
                                    type: PageTransitionType.fromBottom,
                                  ),
                                );
                              },
                              image: users,
                              title: tr("who_us"),
                            ),

                            HideFromGuestWidget(
                              child: DrawerWidget(
                                onTap: () {
                                  Navigation.push(
                                    context,
                                    customPageTransition: PageTransition(
                                      child: const FavouritesScreen(),
                                      type: PageTransitionType.fromBottom,
                                    ),
                                  );
                                },
                                image: like,
                                title: tr("favourities"),
                              ),
                            ),

                            //
                            DrawerWidget(
                              onTap: () {
                                final locale = context.locale;
                                showModalBottomSheet(
                                  // enableDrag: false,
                                  isDismissible: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  backgroundColor: blackColor,
                                  builder: (BuildContext context) {
                                    return LangModalSheet(
                                      locale: locale,
                                    );
                                  },
                                  context: context,
                                );
                              },
                              image: lang,
                              title: tr("language"),
                            ),

                            DrawerWidget(
                              onTap: () {
                                context
                                    .read<PrivacyPolicyCubit>()
                                    .fGetPrivacyPolicy();
                                Navigation.push(
                                  context,
                                  customPageTransition: PageTransition(
                                    child: const PrivacyPolicyScreen(),
                                    type: PageTransitionType.fromBottom,
                                  ),
                                );
                              },
                              image: terms,
                              title: tr("privacy_policy"),
                            ),
                            DrawerWidget(
                              onTap: () {
                                context.read<TermsCubit>().fGetTerms();
                                Navigation.push(
                                  context,
                                  customPageTransition: PageTransition(
                                    child: const TermsAndConditionsScreen(),
                                    type: PageTransitionType.fromBottom,
                                  ),
                                );
                              },
                              image: terms,
                              title: tr("terms_and_conditions"),
                            ),

                            DrawerWidget(
                              onTap: () {
                                context.read<SocialLinksCubit>().fSocialLinks();
                                Navigation.push(
                                  context,
                                  customPageTransition: PageTransition(
                                    child: const ContactUsScreen(),
                                    type: PageTransitionType.fromBottom,
                                  ),
                                );
                              },
                              image: call2,
                              title: tr("contact_us"),
                            ),
                            DrawerWidget(
                              onTap: () async {
                                await sh.FlutterShare.share(
                                  title: 'عقار محمد الأصيفر',
                                  text:
                                      'قم بتحميل تطبيق عقار محمد الأصيفر من : \n App Store : https://apps.apple.com/us/app/id6445955617 \n Google Play : https://play.google.com/store/apps/details?id=com.moltaqa.aquar',
                                );
                              },
                              image: share,
                              title: tr("share_app"),
                            ),
                            sizedBoxh20,

                            BlocBuilder<AutoLoginCubit, AutoLoginState>(
                                builder: (context, state) {
                              if (state is AutoLoginGuest) {
                                return DrawerWidget(
                                  onTap: () async {
                                    sl<AutoLoginCubit>().emitNoUser();
                                  },
                                  image: user,
                                  title: tr("login"),
                                );
                              }
                              return const SizedBox();
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                HideFromGuestWidget(
                  child: DrawerWidget(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return BlocConsumer<LogoutCubit, LogoutState>(
                              listener: (context, state) {
                                if (state is LogoutErrorState) {
                                  showToast(state.message);
                                }
                                if (state is LogoutSuccessState) {
                                  context.read<AutoLoginCubit>().emitNoUser();
                                  sl<AppNavigator>().pop();
                                  sl<AppNavigator>().popToFrist();
                                }
                              },
                              builder: (context, state) {
                                if (state is LogoutLoadingState) {
                                  return const Loading();
                                }
                                return LogoutDialoug(
                                  yes: () {
                                    sl<AppNavigator>().pop();
                                  },
                                  no: () async {
                                    context.read<LogoutCubit>().fLogout();
                                  },
                                );
                              },
                            );
                          });
                    },
                    textColor2: mainColor,
                    image: logout,
                    title: tr("log_out"),
                  ),
                ),
                HideFromGuestWidget(
                  child: DrawerWidget(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return BlocConsumer<DeleteCubit, DeleteState>(
                              listener: (context, state) {
                                if (state is DeleteAccountError) {
                                  showToast(state.message);
                                }
                                if (state is DeleteAccountSuccess) {
                                  context.read<AutoLoginCubit>().emitNoUser();
                                  sl<AppNavigator>().popToFrist();
                                  // sl<Au>().pushReplacement(
                                  //     screen: const LoginScreen());
                                }
                              },
                              builder: (context, state) {
                                if (state is DeleteAccountLoading) {
                                  return const Loading();
                                }
                                return AlertDialog(
                                  backgroundColor: lightBlackColor,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: mainColor.withOpacity(.5)),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20.0))),
                                  title: SvgPicture.asset(
                                    logoutDialogImage,
                                    // color: mainColor,
                                  ),
                                  actions: [
                                    Column(
                                      children: [
                                        Text(
                                          tr("are_you_sure_to_delete_account"),
                                          style: TextStyles.textViewRegular16
                                              .copyWith(color: textColor),
                                        ),
                                        const Space(
                                          height: 10,
                                        ),
                                        PasswordMasterTextField(
                                          controller: passController,
                                          hintText: tr("enter_password"),
                                          isPassword: true,
                                          onChanged: (String value) {},
                                          onEditingComplete: () {
                                            // FocusScope.of(context).unfocus();
                                          },
                                        ),
                                        const Space(
                                          height: 10,
                                        ),
                                        isLoading
                                            ? const Center(
                                                child: SizedBox(
                                                    width: 30,
                                                    height: 30,
                                                    child:
                                                        CircularProgressIndicator()),
                                              )
                                            : FittedBox(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    TextButton(
                                                        onPressed: () async {
                                                          toggleIsLoading();
                                                          await sl<
                                                                  AppNavigator>()
                                                              .pop();
                                                          toggleIsLoading();
                                                        },
                                                        child: Container(
                                                          width: 130,
                                                          height: 40,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .transparent,
                                                            border: Border.all(
                                                                color:
                                                                    brownColor),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: Center(
                                                            child: FittedBox(
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        5),
                                                                child: Text(
                                                                  tr("Continue_application"),
                                                                  style: TextStyles
                                                                      .textViewMedium18
                                                                      .copyWith(
                                                                          color:
                                                                              mainColor),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )),
                                                    TextButton(
                                                        onPressed: () {
                                                          context
                                                              .read<
                                                                  DeleteCubit>()
                                                              .fDeleteAccount(
                                                                  password:
                                                                      passController
                                                                          .text);
                                                        },
                                                        child: Container(
                                                          width: 130,
                                                          height: 40,
                                                          decoration: BoxDecoration(
                                                              color: mainColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          child: Center(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          5),
                                                              child: Text(
                                                                tr("delete_account"),
                                                                style: TextStyles
                                                                    .textViewMedium18
                                                                    .copyWith(
                                                                        color:
                                                                            white),
                                                              ),
                                                            ),
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                        const Space(
                                          height: 20,
                                        )
                                      ],
                                    )
                                    // The "Yes" button
                                  ],
                                );
                                //   DeleteAccDialoug(
                                //   yes: () {
                                //     sl<AppNavigator>().pop();
                                //   },
                                //   no: () async {
                                //     context
                                //         .read<DeleteCubit>()
                                //         .fDeleteAccount(password: );
                                //   },
                                // );
                              },
                            );
                          });
                    },
                    textColor2: mainColor,
                    image: logout,
                    title: tr("delete_account"),
                  ),
                ),
                sizedBoxh20,
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
                color: lightBlackColor.withOpacity(.3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: IconButton(
                          onPressed: () {
                            sl<AppNavigator>().pop();
                          },
                          icon: const Icon(
                            Icons.close,
                            size: 30,
                            color: textColor,
                          )),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
