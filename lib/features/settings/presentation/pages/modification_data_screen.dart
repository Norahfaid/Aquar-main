import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart' as e;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/util/app_navigator.dart';
import '../../../../core/util/validator.dart';
import '../../../../core/widgets/default_app_bar.dart';
import '../../../../core/widgets/gradiant_button.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/master_textfield.dart';
import '../../../../core/widgets/password_text_feild.dart';
import '../../../../core/widgets/space.dart';
import '../../../../core/widgets/toast.dart';
import '../../../../injection_container/injection_container.dart';
import '../../../../main.dart';
import '../../../auth/domain/models/login.dart';
import '../../../auth/presentation/cubit/edit_profile/edit_profile_cubit.dart';

class ModificationDataScreen extends StatefulWidget {
  final User userProfile;

  const ModificationDataScreen({super.key, required this.userProfile});

  @override
  State<ModificationDataScreen> createState() => _ModificationDataScreenState();
}

class _ModificationDataScreenState extends State<ModificationDataScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  TextEditingController passwordHintController = TextEditingController();

  TextEditingController oldPasswordController = TextEditingController();

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  void initState() {
    nameController.text = widget.userProfile.name;
    phoneController.text = widget.userProfile.phone;
    passwordHintController.text = '* * * * * *';

    super.initState();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isChange = false;
  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<EditProfileCubit>();
    return Scaffold(
        backgroundColor: blackColor,
        appBar: DefaultAppBar(
          title: e.tr("edit_profile"),
          ontapLeading: () {
            sl<AppNavigator>().pop();
          },
          // leadingIcon: const Icon(
          //   Icons.keyboard_arrow_right,
          //   size: 30,
          // )
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                color: greyColor,
                height: 1,
              ),
              const Space(
                height: 20,
              ),
              SizedBox(
                child: Column(
                  children: <Widget>[
                    Stack(
                        fit: StackFit.loose,
                        alignment: AlignmentDirectional.center,
                        children: [
                          Material(
                            elevation: 3,
                            borderRadius: BorderRadius.circular(100),
                            child: bloc.editProfileParams.avatar == null
                                ? CircleAvatar(
                                    radius: 69,
                                    backgroundImage: CachedNetworkImageProvider(
                                        widget.userProfile.avatar),
                                  )
                                : CircleAvatar(
                                    radius: 69,
                                    backgroundImage: FileImage(
                                        bloc.editProfileParams.avatar!),
                                  ),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 90.0, right: 80.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            // color: Colors.grey.shade300,
                                            height: 250.h,
                                            padding: const EdgeInsets.all(20),
                                            child: Stack(
                                              alignment: Alignment.bottomLeft,
                                              // clipBehavior: Clip.none,
                                              children: [
                                                Container(
                                                  width: 50,
                                                  height: 6,
                                                  margin: const EdgeInsets.only(
                                                      bottom: 20),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.5),
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Column(children: [
                                                  SelectPhoto(
                                                    onTap: () {
                                                      bloc.getImage(
                                                        context,
                                                        ImageSource.gallery,
                                                      );
                                                      Navigator.pop(context);
                                                    },
                                                    icon: Icons.image,
                                                    textLabel:
                                                        e.tr('Browse_Gallery'),
                                                  ),
                                                  const SizedBox(height: 20),
                                                  SelectPhoto(
                                                    onTap: () {
                                                      bloc.getImage(context,
                                                          ImageSource.camera);
                                                      Navigator.pop(context);
                                                    },
                                                    icon: Icons
                                                        .camera_alt_outlined,
                                                    textLabel: e.tr('camera'),
                                                  ),
                                                ])
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Material(
                                      elevation: 3,
                                      borderRadius: BorderRadius.circular(50.r),
                                      child: const CircleAvatar(
                                        radius: 15,
                                        backgroundColor: mainColor,
                                        child: Center(
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.black,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ]),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        e.tr("name"),
                        style:
                            TextStyles.textViewMedium18.copyWith(color: white),
                      ),
                      const Space(
                        height: 10,
                      ),
                      MasterTextField(
                        hintText: "",
                        controller: nameController,
                        textDirection: TextDirection.ltr,
                        keyboardType: TextInputType.name,
                        fillColor: lightBlackColor,
                        filled: true,
                        onEditingComplete: () {
                          FocusScope.of(context).nextFocus();
                        },
                        onChanged: (String value) {
                          bloc.editProfileParams.name = value;
                        },
                      ),
                      const Space(
                        height: 20,
                      ),
                      isChange
                          ? const SizedBox()
                          : Text(
                              e.tr("password"),
                              style: TextStyles.textViewMedium18
                                  .copyWith(color: white),
                            ),
                      const Space(
                        height: 10,
                      ),
                      isChange
                          ? const SizedBox()
                          : Row(
                              children: [
                                Expanded(
                                  child: MasterTextField(
                                    hintText: "",
                                    controller: passwordHintController,
                                    // textDirection: TextDirection.ltr,
                                    enabled: false,
                                    keyboardType: TextInputType.phone,
                                    fillColor: lightBlackColor,
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
                                          setState(() {
                                            isChange = !isChange;
                                          });
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
                      isChange
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e.tr("old_password"),
                                  style: TextStyles.textViewMedium18
                                      .copyWith(color: white),
                                ),
                                const Space(
                                  height: 10,
                                ),
                                PasswordMasterTextField(
                                  hintText: "",
                                  isPassword: true,
                                  textFieldColor: lightBlackColor,
                                  filled: true,
                                  onChanged: (String value) {
                                    bloc.editProfileParams.oldPass = value;
                                  },
                                  controller: oldPasswordController,
                                  onEditingComplete: () {
                                    FocusScope.of(context).unfocus();
                                  },
                                  validationFunction: (value) =>
                                      Validator.defaultValidator(value),
                                ),
                                const Space(
                                  height: 20,
                                ),
                                Text(
                                  e.tr("password"),
                                  style: TextStyles.textViewMedium18
                                      .copyWith(color: white),
                                ),
                                const Space(
                                  height: 10,
                                ),
                                PasswordMasterTextField(
                                  hintText: "",
                                  isPassword: true,
                                  textFieldColor: lightBlackColor,
                                  filled: true,
                                  onChanged: (String value) {
                                    bloc.editProfileParams.pass = value;
                                  },
                                  controller: newPasswordController,
                                  onEditingComplete: () {
                                    FocusScope.of(context).unfocus();
                                  },
                                  validationFunction: (value) =>
                                      Validator.defaultValidator(value),
                                ),
                                const Space(
                                  height: 20,
                                ),
                                Text(
                                  e.tr("confirm_password"),
                                  style: TextStyles.textViewMedium18
                                      .copyWith(color: white),
                                ),
                                const Space(
                                  height: 10,
                                ),
                                PasswordMasterTextField(
                                  hintText: "",
                                  isPassword: true,
                                  textFieldColor: lightBlackColor,
                                  filled: true,
                                  controller: confirmPasswordController,
                                  onChanged: (String value) {
                                    bloc.editProfileParams.passConfirm = value;
                                  },
                                  onEditingComplete: () {
                                    // FocusScope.of(context).unfocus();
                                  },
                                  validationFunction: (value) =>
                                      Validator.confirmPassword(
                                          value, newPasswordController.text),
                                ),
                              ],
                            )
                          : const SizedBox(),
                      const Space(height: 25),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child:
                              BlocConsumer<EditProfileCubit, EditProfileState>(
                            listener: (context, state) {
                              if (state is EditProfileErrorState) {
                                showToast(state.message);
                              }
                              if (state is EditProfileSuccessState) {
                                showToast(e.tr("profile_has_been_edit"));
                                sl<AppNavigator>()
                                    .pushReplacement(screen: const Aquar());
                              }
                            },
                            builder: (context, state) {
                              if (state is EditProfileLoodingState) {
                                return const Loading();
                              }
                              return GradiantButton(
                                title: e.tr("save"),
                                tap: (() {
                                  // context.read<EditProfileCubit>().fEditProfile(profile:widget.userProfile );
                                  context.read<EditProfileCubit>().fEditProfile(
                                      phone: phoneController.text,
                                      oldPass: oldPasswordController.text,
                                      avtar: bloc.editProfileParams.avatar,
                                      name: nameController.text,
                                      newPass: newPasswordController.text,
                                      newPassConfirm:
                                          confirmPasswordController.text);
                                }),
                              );
                            },
                          ),
                        ),
                      ),
                      const Space(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class SelectPhoto extends StatelessWidget {
  final String textLabel;
  final IconData icon;

  final void Function()? onTap;

  const SelectPhoto({
    Key? key,
    required this.textLabel,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        elevation: 10,
        backgroundColor: Colors.grey.shade200,
        shape: const StadiumBorder(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 6,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              icon,
              color: mainColor,
            ),
            const SizedBox(
              width: 14,
            ),
            Text(
              textLabel,
              style: const TextStyle(
                fontSize: 18,
                color: mainColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
