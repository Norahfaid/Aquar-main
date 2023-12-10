import 'package:easy_localization/easy_localization.dart' as e;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/util/app_navigator.dart';
import '../../../../core/widgets/default_app_bar.dart';
import '../../../../core/widgets/gradiant_button.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/master_textfield.dart';
import '../../../../core/widgets/space.dart';
import '../../../../core/widgets/toast.dart';
import '../../../../injection_container/injection_container.dart';
import '../../../auth/presentation/cubit/get_profile/get_profile_cubit.dart';
import '../../../auth/presentation/cubit/login_cubit/cubit/login_cubit_cubit.dart';
import 'change_phone_screen.dart';
import 'modification_data_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  void initState() {
    context.read<GetProfileCubit>().fGetProfile();
    final bloc = context.read<LoginCubit>().user;
    nameController.text = bloc.name;
    phoneController.text = bloc.phone;
    passController.text = '******';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: blackColor,
        appBar: DefaultAppBar(
          title: e.tr("profile"),
          ontapLeading: () {
            sl<AppNavigator>().pop();
          },
        ),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: BlocConsumer<GetProfileCubit, GetProfileState>(
                listener: (context, state) {
              if (state is GetProfileErrorState) {
                showToast(state.message);
              }
            }, builder: (context, state) {
              final bloc = context.read<GetProfileCubit>();
              if (state is GetProfileLoadingState) {
                return const Center(child: Loading());
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                    color: greyColor,
                    height: 1,
                  ),
                  const Space(
                    height: 20,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Material(
                        elevation: 3,
                        borderRadius: BorderRadius.circular(100),
                        child: CircleAvatar(
                          radius: 46,
                          backgroundColor: white,
                          child: CircleAvatar(
                            radius: 45,
                            backgroundImage: NetworkImage(bloc.user.avatar),
                          ),
                        ),
                        //"https://www.shutterstock.com/image-photo/portrait-handsome-caucasian-man-formal-600w-2142820441.jpg"
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e.tr("name"),
                          style: TextStyles.textViewMedium18
                              .copyWith(color: white),
                        ),
                        const Space(
                          height: 10,
                        ),
                        MasterTextField(
                          hintText: '',
                          enabled: false,
                          textDirection: TextDirection.ltr,
                          keyboardType: TextInputType.name,
                          fillColor: lightBlackColor,
                          filled: true,
                          controller: nameController,
                          onEditingComplete: () {
                            FocusScope.of(context).nextFocus();
                          },
                          onChanged: (String value) {},
                        ),
                        const Space(
                          height: 20,
                        ),
                        Text(
                          e.tr("phone_number"),
                          style: TextStyles.textViewMedium18
                              .copyWith(color: white),
                        ),
                        const Space(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: MasterTextField(
                                hintText: "",
                                enabled: false,
                                textDirection: TextDirection.ltr,
                                keyboardType: TextInputType.phone,
                                fillColor: lightBlackColor,
                                controller: phoneController,
                                filled: true,
                                onEditingComplete: () {
                                  FocusScope.of(context).nextFocus();
                                },
                                onChanged: (String value) {},
                              ),
                            ),
                            Container(width: 10),
                            Container(
                                height: 50,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: mainColor,
                                  borderRadius: BorderRadius.circular(10.0),
                                  // color: buttonColor,
                                ),
                                child: TextButton(
                                    onPressed: () {
                                      sl<AppNavigator>()
                                          .push(screen: ChangePhoneScreen());
                                    },
                                    child: FittedBox(
                                      child: Text(
                                          e.tr(
                                            "change",
                                          ),
                                          style: TextStyles.textViewMedium18
                                              .copyWith(color: blackColor)),
                                    ))),
                          ],
                        ),
                        const Space(
                          height: 20,
                        ),
                        // Text(
                        //   e.tr("password"),
                        //   style: TextStyles.textViewMedium18
                        //       .copyWith(color: white),
                        // ),
                        // const Space(
                        //   boxHeight: 10,
                        // ),
                        // MasterTextField(
                        //   hintText: "",
                        //   controller: passController,
                        //   textDirection: TextDirection.ltr,
                        //   enabled: false,
                        //   keyboardType: TextInputType.phone,
                        //   fillColor: lightBlackColor,
                        //   filled: true,
                        //   onEditingComplete: () {
                        //     FocusScope.of(context).nextFocus();
                        //   },
                        //   onChanged: (String value) {},
                        // ),
                        const Space(height: 40),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: GradiantButton(
                              title: e.tr("data_modification"),
                              tap: (() {
                                sl<AppNavigator>().push(
                                    screen: ModificationDataScreen(
                                  userProfile: bloc.user,
                                  // phone:bloc.user.phone ,
                                  // avtar:bloc.user.avatar ,
                                  // name: bloc.user.name,
                                ));
                              }),
                            ),
                          ),
                        ),
                        const Space(height: 20),
                      ],
                    ),
                  ),
                ],
              );
            })));
  }
}
