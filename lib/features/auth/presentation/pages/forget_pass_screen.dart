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
import '../../../../core/widgets/space.dart';
import '../../../../core/widgets/toast.dart';
import '../../../../injection_container/injection_container.dart';
import '../cubit/forget_pass.dart/cubit/forget_pass_cubit.dart';
import '../widgets/auth_body_decoration.dart';
import '../widgets/auth_logo.dart';
import '../widgets/auth_page_title.dart';
import '../widgets/auth_screen_background.dart';
import 'verify_forget_pass_screen.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      body: Form(
        key: formKey,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            const AuthScreenBackground(),
            SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Space(height: 50,),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: BackButton(
                        color: white,
                      ),
                    ),
                  ),
                  const AuthLogo(),
                  const Space(height: 20,),
                  const AuthPageTitle(titleKey: 'forget_password_l'),
                  const Space(height: 30,),
                  AuthBodyDecoration(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Space(height: 10,),
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
                        const Space(height: 30,),
                        Center(
                          child: BlocConsumer<ForgetPassCubit, ForgetPassState>(
                            listener: (context, state) {
                              if (state is ForgetPassErrorState) {
                                showToast(state.message);
                              }
                              if (state is ForgetPassSuccessState) {
                                sl<AppNavigator>().push(
                                  screen: VerifyForgetPasswordScreen(
                                    code: state.response.data.resetCode.toString(),
                                    phone: phoneController.text,
                                  ),
                                );
                              }
                            },
                            builder: (context, state) {
                              if (state is ForgetPassLoadingState) {
                                return const Loading();
                              }
                              return GradiantButton(
                                tap: () {
                                  if(formKey.currentState!.validate()){
                                    context.read<ForgetPassCubit>().fForgetPass(phone: phoneController.text);
                                  }
                                },
                                title: e.tr("continue"),
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
