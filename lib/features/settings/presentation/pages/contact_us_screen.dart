import 'package:aquar/core/util/validator.dart';
import 'package:aquar/core/widgets/gradiant_button.dart';
import 'package:aquar/core/widgets/master_textfield.dart';
import 'package:aquar/features/settings/domain/usecase/send_image.dart';
import 'package:aquar/features/settings/presentation/cubit/send_message/send_message_cubit.dart';
import 'package:easy_localization/easy_localization.dart' as e;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/dimenssions/screenutil.dart';
import '../../../../core/constant/icons.dart';
import '../../../../core/constant/images.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/util/app_navigator.dart';
import '../../../../core/widgets/default_app_bar.dart';
import '../../../../core/widgets/icon_button_card.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/space.dart';
import '../../../../core/widgets/toast.dart';
import '../../../../injection_container/injection_container.dart';
import '../cubit/social_links/cubit/social_links_cubit.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: blackColor,
        appBar: DefaultAppBar(
          title: e.tr("contact_us"),
          ontapLeading: () {
            sl<AppNavigator>().pop();
          },
            leadingIcon: const Icon(
              Icons.keyboard_arrow_right,
              color: Colors.black,
              size: 30,
            )
        ),
        body: const SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Divider(
                color: greyColor,
                height: 1,
              ),
              Space(height: 10),
              SendMessageWidget(),
              Space(height: 10),
              SocialLinksWidget(),
              Space(height: 10),
            ],
          ),
        ));
  }

  Future<void> launchPhoneDialer({required String contactNumber}) async {
    final Uri phoneUri = Uri(scheme: "tel", path: contactNumber);
    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      }
    } catch (error) {
      throw ("Cannot dial");
    }
  }
}

class SendMessageWidget extends StatefulWidget {
  const SendMessageWidget({super.key});

  @override
  State<SendMessageWidget> createState() => _SendMessageWidgetState();
}

class _SendMessageWidgetState extends State<SendMessageWidget> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          e.tr("send_complaint"),
          style: TextStyles.textViewMedium22.copyWith(
            color: mainColor,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          e.tr("name"),
          style: TextStyles.textViewMedium18.copyWith(
            color: white,
          ),
        ),
        const Space(
          height: 10,
        ),
        MasterTextField(
          controller: nameController,
          hintText: e.tr("name"),
          textDirection: TextDirection.ltr,
          keyboardType: TextInputType.text,
          validate: (value) => Validator.defaultValidator(value),
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
          onChanged: (String value) {},
        ),
        const Space(height: 10),
        Text(
          e.tr("phone_number"),
          style: TextStyles.textViewMedium18.copyWith(
            color: white,
          ),
        ),
        const Space(
          height: 10,
        ),
        MasterTextField(
          controller: phoneController,
          hintText: e.tr("enter_phone_number"),
          textDirection: TextDirection.ltr,
          keyboardType: TextInputType.phone,
          validate: (value) => Validator.phone(value),
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
          onChanged: (String value) {},
        ),
        const Space(
          height: 10,
        ),
        Text(
          e.tr("email"),
          style: TextStyles.textViewMedium18.copyWith(
            color: white,
          ),
        ),
        const Space(
          height: 10,
        ),
        MasterTextField(
          controller: emailController,
          hintText: e.tr("email"),
          textDirection: TextDirection.ltr,
          keyboardType: TextInputType.emailAddress,
          validate: (value) => Validator.email(value),
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
          onChanged: (String value) {},
        ),
        const Space(
          height: 10,
        ),
        Text(
          e.tr("your_message"),
          style: TextStyles.textViewMedium18.copyWith(
            color: white,
          ),
        ),
        const Space(
          height: 10,
        ),
        MasterTextField(
          controller: messageController,
          hintText: e.tr("your_message"),
          textDirection: TextDirection.ltr,
          keyboardType: TextInputType.text,
          maxLines: 3,
          minLines: 3,
          validate: (value) => Validator.defaultValidator(value),
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
          onChanged: (String value) {},
        ),
        const Space(height: 10),
        BlocConsumer<SendMessageCubit, SendMessageState>(
            listener: (context, state) {
          if (state is SendMessageSuccess) {
            sl<AppNavigator>().pop();
            showToast(e.tr("message_sent"));
          } else if (state is SendMessageError) {
            showToast(state.message);
          }
        }, builder: (context, state) {
          if (state is SendMessageLoading) {
            return const Center(child: Loading());
          }
          return GradiantButton(
            title: e.tr("send"),
            tap: () {
              if (!formKey.currentState!.validate()) {
                return;
              }
              sl<SendMessageCubit>().fSendMessage(
                params: SendMessageParams(
                    email: emailController.text,
                    name: nameController.text,
                    message: messageController.text,
                    phone: phoneController.text),
              );
            },
          );
        }),
      ]),
    );
  }
}

class SocialLinksWidget extends StatelessWidget {
  const SocialLinksWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLinksCubit, SocialLinksState>(
      listener: (context, state) {
        if (state is SocialLinksErrorState) {
          showToast(state.message);
        }
      },
      builder: (context, state) {
        return Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              // height: screenHeight / 2.5,
              width: screenWidth,
              decoration: BoxDecoration(
                color: lightBlackColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: SvgPicture.asset(contact),
                    ),
                    Text(
                      e.tr("text1"),
                      style: TextStyles.textViewMedium16
                          .copyWith(color: textColor),
                    ),
                    const Space(
                      height: 10,
                    ),
                    state is SocialLinksSuccessState
                        ? Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (state.response.data.whatsApp != null)
                                    InkWell(
                                        onTap: () async {
                                          final Uri whatsUri = Uri.parse(
                                              "whatsapp://send?phone=${state.response.data.whatsApp}");
                                          await launchUrl(whatsUri);
                                        },
                                        child: SvgPicture.asset(whats)),
                                  if (state.response.data.whatsApp != null)
                                    const Space(
                                      width: 10,
                                    ),
                                  if (state.response.data.instagram != null)
                                    InkWell(
                                        onTap: () async {
                                          final Uri instaUri = Uri.parse(
                                              state.response.data.instagram!);
                                          await launchUrl(instaUri);
                                        },
                                        child: SvgPicture.asset(insta)),
                                  if (state.response.data.instagram != null)
                                    const Space(
                                      width: 10,
                                    ),
                                  if (state.response.data.youtube != null)
                                    InkWell(
                                        onTap: () async {
                                          final Uri youtypeUri = Uri.parse(
                                              state.response.data.youtube!);
                                          await launchUrl(youtypeUri);
                                        },
                                        child: SvgPicture.asset(youtube1)),
                                  if (state.response.data.facebook != null)
                                    const Space(
                                      width: 10,
                                    ),
                                  if (state.response.data.facebook != null)
                                    InkWell(
                                        onTap: () async {
                                          final Uri facebookUri = Uri.parse(
                                              state.response.data.facebook!);
                                          await launchUrl(facebookUri);
                                        },
                                        child: const Icon(
                                          Icons.facebook_rounded,
                                          color: white,
                                          size: 35,
                                        )),
                                  if (state.response.data.snapchat != null)
                                    const Space(
                                      width: 10,
                                    ),
                                  if (state.response.data.snapchat != null)
                                    InkWell(
                                        onTap: () async {
                                          final Uri snapchatUri = Uri.parse(
                                              state.response.data.snapchat!);
                                          await launchUrl(snapchatUri);
                                        },
                                        child: SvgPicture.asset(snap)),
                                  if (state.response.data.twitter != null)
                                    const Space(
                                      width: 10,
                                    ),
                                  if (state.response.data.twitter != null)
                                    InkWell(
                                        onTap: () async {
                                          final Uri twitterUri = Uri.parse(
                                              state.response.data.twitter!);
                                          await launchUrl(twitterUri);
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: SvgPicture.asset(
                                            twitter,
                                          ),
                                        )),
                                ],
                              ),
                              const Space(
                                height: 30,
                              ),
                              if (state.response.data.phones!.isNotEmpty)
                                Column(
                                  children: List.generate(
                                    state.response.data.phones!.length,
                                    (index) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2),
                                      child: GestureDetector(
                                        onTap: () async {
                                          final Uri phoneUri = Uri(
                                              scheme: "tel",
                                              path: state.response.data
                                                  .phones![index]);
                                          try {
                                            if (await canLaunchUrl(phoneUri)) {
                                              await launchUrl(phoneUri);
                                            }
                                          } catch (error) {
                                            throw ("Cannot dial");
                                          }
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const IconButtonCard(
                                              radiusSize: 12,
                                              image: call2,
                                              paddingImage: 7,
                                              isImage: true,
                                            ),
                                            const Space(
                                              width: 5,
                                            ),
                                            Text(
                                              state
                                                  .response.data.phones![index],
                                              style: TextStyles
                                                  .textViewRegular17
                                                  .copyWith(color: textColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              const Space(
                                height: 10,
                              ),
                            ],
                          )
                        : const Loading(),
                  ]),
            ));
      },
    );
  }
}
