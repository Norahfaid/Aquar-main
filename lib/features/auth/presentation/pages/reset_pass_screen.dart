import 'package:easy_localization/easy_localization.dart' as e;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/util/app_navigator.dart';
import '../../../../core/util/validator.dart';
import '../../../../core/widgets/gradiant_button.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/password_text_feild.dart';
import '../../../../core/widgets/space.dart';
import '../../../../core/widgets/toast.dart';
import '../../../../injection_container/injection_container.dart';
import '../cubit/reset_pass/cubit/reset_pass_cubit.dart';
import '../widgets/auth_body_decoration.dart';
import '../widgets/auth_logo.dart';
import '../widgets/auth_page_title.dart';
import '../widgets/auth_screen_background.dart';
import 'login_screen.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String resetToken;

  ResetPasswordScreen({
    required this.resetToken,
    Key? key,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Form(
        key: formKey,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            const AuthScreenBackground(),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Space(height: 100,),
                  const AuthLogo(),
                  const Space(height: 20,),
                  const AuthPageTitle(titleKey: 'create_new_pass'),
                  const Space(height: 30,),
                  AuthBodyDecoration(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Space(height: 10,),
                        Text(
                          e.tr("new_password"),
                          style: TextStyles.textViewMedium18.copyWith(color: white,),
                        ),
                        const Space(height: 10,),
                        PasswordMasterTextField(
                          hintText: e.tr("enter_password"),
                          isPassword: true,
                          onChanged: (String value) {},
                          controller: passwordController,
                          validationFunction: (value) => Validator.password(value),
                        ),
                        const Space(height: 20,),
                        Text(
                          e.tr("confirm_new_password"),
                          style: TextStyles.textViewMedium18.copyWith(color: white,),
                        ),
                        const Space(height: 10,),
                        PasswordMasterTextField(
                          hintText: e.tr("enter_password"),
                          isPassword: true,
                          controller: confirmPasswordController,
                          onChanged: (String value) {},
                          validationFunction: (value) => Validator.confirmPassword(value, passwordController.text),
                        ),
                        const Space(height: 25,),
                        const Space(height: 30,),
                        Center(
                          child: BlocConsumer<ResetPassCubit, ResetPassState>(
                            listener: (context, state) {
                              if (state is ResetPassErrorState) {
                                showToast(state.message);
                              }
                              if (state is ResetPassSuccessState) {
                                sl<AppNavigator>().push(screen: const LoginScreen());
                                showToast(state.response.message);
                              }
                            },
                            builder: (context, state) {
                              if (state is ResetPassLoadingState) {
                                return const Loading();
                              }
                              return GradiantButton(
                                title: e.tr("continue"),
                                tap: (() {
                                  context.read<ResetPassCubit>().fResetPass(
                                    formKey: formKey,
                                    pass: passwordController.text,
                                    passConfirm:
                                    confirmPasswordController.text,
                                    token: resetToken,
                                  );
                                }),
                              );
                            },
                          ),
                        ),
                        const Space(height: 20,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
