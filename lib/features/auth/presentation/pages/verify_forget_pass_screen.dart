import 'package:easy_localization/easy_localization.dart' as e;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/util/app_navigator.dart';
import '../../../../core/widgets/gradiant_button.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/pin_code_form_feild.dart';
import '../../../../core/widgets/space.dart';
import '../../../../core/widgets/timer_cubit/timer_cubit.dart';
import '../../../../core/widgets/timer_cubit/timer_states.dart';
import '../../../../core/widgets/toast.dart';
import '../../../../injection_container/injection_container.dart';
import '../cubit/check_code/cubit/check_code_cubit.dart';
import '../cubit/forget_pass.dart/cubit/forget_pass_cubit.dart';
import '../widgets/auth_body_decoration.dart';
import '../widgets/auth_logo.dart';
import '../widgets/auth_page_title.dart';
import '../widgets/auth_screen_background.dart';
import 'reset_pass_screen.dart';

class VerifyForgetPasswordScreen extends StatefulWidget {
  final String code;
  final String phone;

  const VerifyForgetPasswordScreen({
    required this.code,
    required this.phone,
    Key? key,
  }) : super(key: key);

  @override
  State<VerifyForgetPasswordScreen> createState() => _VerifyForgetPasswordScreenState();
}

class _VerifyForgetPasswordScreenState extends State<VerifyForgetPasswordScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController verificationCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TimerCubit>(
      create: (BuildContext context) => TimerCubit()..startTimer(),
      child: Scaffold(
        key: scaffoldKey,
        body: Form(
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
                    const AuthPageTitle(titleKey: 'forget_password_l'),
                    const Space(height: 30,),
                    AuthBodyDecoration(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Space(height: 10,),
                          PinCodeWidget(verificationCode: verificationCode),
                          const Space(height: 10,),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              BlocConsumer<ForgetPassCubit, ForgetPassState>(
                                listener: (context, state) async {
                                  if (state is ForgetPassSuccessState) {
                                    // widget.model = state.response;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          e.tr("code_resend_success"),
                                          style: TextStyles.textViewMedium18.copyWith(
                                            color: Colors.greenAccent,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  if (state is ForgetPassErrorState) {
                                    showToast(state.message);
                                  }
                                },
                                builder: (context, state) {
                                  if (state is ForgetPassLoadingState) {
                                    return const Loading();
                                  }
                                  return BlocBuilder<TimerCubit, TimerState>(
                                    builder: (context, state) {
                                      final timerBloc = BlocProvider.of<TimerCubit>(context);
                                      if(state is TimerStart){
                                        return Text(
                                          e.tr("resend_code"),
                                          style: TextStyles
                                              .textViewMedium18
                                              .copyWith(
                                              color: Colors.grey),
                                        );
                                      }
                                      return TextButton(
                                        onPressed: () {
                                          if (timerBloc.start == 59) {
                                            timerBloc.startTimer();
                                            context
                                                .read<ForgetPassCubit>()
                                                .fForgetPass(
                                              phone: widget.phone,
                                            );
                                          }
                                        },
                                        child: Text(
                                          e.tr("resend_code"),
                                          style: TextStyles.textViewMedium18.copyWith(color: mainColor,),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                              BlocConsumer<TimerCubit, TimerState>(
                                listener: (context, state) {},
                                builder: (context, state) {
                                  final bloc = context.watch<TimerCubit>();
                                  return Text(
                                    bloc.start > 9
                                        ? "00:${bloc.start.toString()}"
                                        : "00:0${bloc.start.toString()}",
                                    style: TextStyles.textViewMedium18.copyWith(color: mainColor,),
                                  );
                                },
                              ),
                            ],
                          ),
                          const Space(height: 20,),
                          // Center(
                          //     child: Text(
                          //   "code: ${widget.code} ",
                          //   style: TextStyles.textViewMedium18
                          //       .copyWith(color: white),
                          // )),
                          const Space(height: 30,),
                          Center(
                            child: BlocConsumer<CheckCodeCubit, CheckCodeState>(
                              listener: (context, state) {
                                if (state is CheckCodeSuccessState) {
                                  sl<AppNavigator>().push(
                                    screen: ResetPasswordScreen(
                                      resetToken: state.response.data.resetToken,
                                    ),
                                  );
                                }
                                if (state is CheckCodeErrorState) {
                                  showToast(state.message);
                                }
                              },
                              builder: (context, state) {
                                if (state is CheckCodeLoadingState) {
                                  return const Loading();
                                }
                                return GradiantButton(
                                  title: e.tr("check"),
                                  tap: () {
                                    context.read<CheckCodeCubit>().fCheckCode(
                                      phone: widget.phone,
                                      code: verificationCode.text,
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          // const Space(boxHeight: 20),
                          // Center(
                          //   child: Text(
                          //     e.tr("change_phone_number"),
                          //     style: TextStyles.textViewBold18
                          //         .copyWith(color: mainColor),
                          //   ),
                          // ),
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
      ),
    );
  }
}
