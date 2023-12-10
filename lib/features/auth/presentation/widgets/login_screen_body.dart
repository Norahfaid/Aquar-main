import 'package:easy_localization/easy_localization.dart' as e;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/util/app_navigator.dart';
import '../../../../core/util/validator.dart';
import '../../../../core/widgets/gradiant_button.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/master_textfield.dart';
import '../../../../core/widgets/password_text_feild.dart';
import '../../../../core/widgets/space.dart';
import '../../../../core/widgets/toast.dart';
import '../../../../injection_container/injection_container.dart';
import '../cubit/auto_login/auto_login_cubit.dart';
import '../cubit/login_cubit/cubit/login_cubit_cubit.dart';
import '../cubit/submit_register/cubit/submit_register_cubit.dart';
import '../pages/forget_pass_screen.dart';
import '../pages/register_screen.dart';
import '../pages/verify_register_screen.dart';

class LoginScreenBody extends StatefulWidget {
  const LoginScreenBody({super.key});

  @override
  State<LoginScreenBody> createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Space(height: 10,),

          //region:: Phone Number TextField
          Text(
            e.tr("phone_number"),
            style: TextStyles.textViewMedium18.copyWith(color: white,),
          ),
          const Space(height: 10,),
          MasterTextField(
            controller: phoneController,
            hintText: e.tr("enter_phone_number"),
            textDirection: TextDirection.ltr,
            keyboardType: TextInputType.phone,
            validate: (value) => Validator.phone(value),
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
            onChanged: (String value) {},
          ),
          const Space(height: 10,),
          //endregion

          //region:: Password TextField
          Text(
            e.tr("password"),
            style: TextStyles.textViewMedium18.copyWith(color: textColor,),
          ),
          const Space(height: 10,),
          PasswordMasterTextField(
            controller: passController,
            hintText: e.tr("enter_password"),
            isPassword: true,
            validationFunction: (value) => Validator.password(value),
            onEditingComplete: () => FocusScope.of(context).unfocus(),
            onChanged: (String value) {},
          ),
          const Space(height: 10,),
          //endregion

          //region:: Forget Password Section
          TextButton(
            onPressed: () {
              sl<AppNavigator>().push(screen: ForgetPasswordScreen());
            },
            child: Text(
              e.tr("forget_password"),
              style: TextStyles.textViewRegular16.copyWith(color: textColor,),
            ),
          ),
          const Space(height: 15,),
          //endregion

          //region:: Login Button
          Center(
            child: BlocConsumer<LoginCubit, LoginCubitState>(
              listener: (context, state) {
                if (state is LoginErrorState) {
                  showToast(state.message);
                } else if (state is LoginSuccessState) {
                  if (state.user.verified) {
                    context.read<AutoLoginCubit>().emitHasUser(user: state.user);
                  } else {
                    context.read<SubmitRegisterCubit>().updateCode(state.user.code);
                    sl<AppNavigator>().push(screen: VerifyRegisterScreen(phone: state.user.phone,));
                  }
                }
              },
              builder: (context, state) {
                if (state is LoginLoadingState) {
                  return const Loading();
                }
                return GradiantButton(
                  title: e.tr("login"),
                  tap: () {
                    FocusScope.of(context).unfocus();
                    context.read<LoginCubit>().fUserLogin(
                      formKey: formKey,
                      phone: phoneController.text,
                      password: passController.text,
                    );
                  },
                );
              },
            ),
          ),
          const Space(height: 20,),
          //endregion

          //region:: Don't Have Account Section
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                e.tr("don't_have_account"),
                style: TextStyles.textViewRegular15.copyWith(color: textColor,),
              ),
              TextButton(
                onPressed: () {
                  sl<AppNavigator>().push(screen: const RegisterScreen());
                },
                child: Text(
                  e.tr("create_a_new_account"),
                  style: TextStyles.textViewBold15.copyWith(
                    color: mainColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          const Space(height: 5,),
          //endregion

          //region:: Guest Login
          Center(
            child: TextButton(
              onPressed: () {
                sl<AutoLoginCubit>().emitGuest();
              },
              child: Text(
                e.tr("login_guest"),
                style: TextStyles.textViewBold15.copyWith(
                  color: mainColor,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          //endregion
        ],
      ),
    );
  }
}
