import 'package:easy_localization/easy_localization.dart' as e;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/images.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/util/app_navigator.dart';
import '../../../../core/widgets/gradiant_button.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/pin_code_form_feild.dart';
import '../../../../core/widgets/side_padding.dart';
import '../../../../core/widgets/space.dart';
import '../../../../core/widgets/timer_cubit/timer_cubit.dart';
import '../../../../core/widgets/timer_cubit/timer_states.dart';
import '../../../../core/widgets/toast.dart';
import '../../../../injection_container/injection_container.dart';
import '../cubit/auto_login/auto_login_cubit.dart';
import '../cubit/resend_code/cubit/resend_code_cubit.dart';
import '../cubit/submit_register/cubit/submit_register_cubit.dart';

class VerifyRegisterScreen extends StatefulWidget {
  final String phone;
  const VerifyRegisterScreen({
    Key? key,
    required this.phone,
  }) : super(key: key);

  @override
  State<VerifyRegisterScreen> createState() => _VerifyRegisterScreenState();
}

class _VerifyRegisterScreenState extends State<VerifyRegisterScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController verFicationCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TimerCubit>(
      create: (BuildContext context) => TimerCubit()..startTimer(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: scaffoldKey,
        body: Form(
          key: formKey,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Image.asset(
                background,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.fill,
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Space(height: 50),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: BackButton(color: white)),
                    ),
                    const Space(height: 20),
                    Image.asset(
                      logoImage,
                      height: 150.h,
                    ),
                    const Space(height: 20),
                    Center(
                      child: Text(
                        e.tr("verfication_code"),
                        style: TextStyles.textViewBold25.copyWith(color: white),
                      ),
                    ),
                    const Space(height: 30),
                    SidePadding(
                      sidePadding: 35,
                      child: Material(
                        elevation: 0,
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(15.r),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.2),
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          padding: EdgeInsets.only(
                              top: 30.h, left: 20.w, right: 20.w, bottom: 25.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Space(height: 10),
                              PinCodeWidget(verificationCode: verFicationCode),

                              const Space(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  BlocConsumer<SendVerifyCodeRegisterCubit,
                                      ResendCodeState>(
                                    listener: (context, state) async {
                                      if (state is ResendCodeSuccessState) {
                                        context.read<TimerCubit>().startTimer();
                                        context
                                            .read<SubmitRegisterCubit>()
                                            .updateCode(
                                                state.response.code.toString());
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              e.tr("code_send_success"),
                                              style: TextStyles.textViewMedium18
                                                  .copyWith(
                                                color: Colors.greenAccent,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      if (state is ResendCodeErrorState) {
                                        showToast(state.message);
                                      }
                                    },
                                    builder: (context, state) {
                                      final timerBloc =
                                          context.watch<TimerCubit>();
                                      if (state is ResendCodeLoadingState) {
                                        return const Loading();
                                      }
                                      return BlocBuilder<TimerCubit,
                                              TimerState>(
                                          builder: (context, state) {
                                        return timerBloc.start != 0
                                            ? Text(
                                                e.tr("resend_code"),
                                                style: TextStyles
                                                    .textViewMedium18
                                                    .copyWith(
                                                        color: Colors.grey),
                                              )
                                            : GestureDetector(
                                                onTap: () {
                                                  context
                                                      .read<
                                                          SendVerifyCodeRegisterCubit>()
                                                      .fResendCode(
                                                        phone: widget.phone,
                                                      );
                                                },
                                                child: Text(
                                                  e.tr("resend_code"),
                                                  style: TextStyles
                                                      .textViewMedium18
                                                      .copyWith(
                                                          color: mainColor),
                                                ),
                                              );
                                      });
                                    },
                                  ),
                                  BlocConsumer<TimerCubit, TimerState>(
                                    listener: (context, state) {},
                                    builder: (context, state) {
                                      final bloc = TimerCubit.get(context);
                                      return Text(
                                        bloc.start > 9
                                            ? "00:${bloc.start.toString()}"
                                            : "00:0${bloc.start.toString()}",
                                        style: TextStyles.textViewMedium18
                                            .copyWith(color: mainColor),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const Space(
                                height: 30,
                              ),
                              // BlocBuilder<SubmitRegisterCubit,
                              //     SubmitRegisterState>(
                              //   builder: (context, state) {
                              //     return Center(
                              //       child: Text(
                              //         "code : ${context.watch<SubmitRegisterCubit>().code}",
                              //         style: TextStyles.textViewMedium15
                              //             .copyWith(color: white),
                              //       ),
                              //     );
                              //   },
                              // ),
                              const Space(
                                height: 30,
                              ),
                              BlocConsumer<SubmitRegisterCubit,
                                  SubmitRegisterState>(
                                listener: (context, state) {
                                  if (state is VerifyRegisterErrorState) {
                                    showToast(state.message);
                                  }
                                  if (state is VerifyRegisterSuccessState) {
                                    showToast(tr("register_sucess_messsage"));

                                    sl<AppNavigator>().popToFrist();

                                    sl<AutoLoginCubit>().emitLoading();
                                    sl<AutoLoginCubit>().emitNoUser();
                                  }
                                  if (state is EmptyCodeState) {
                                    showToast(state.message);
                                  }
                                  if (state is WrongCodeState) {
                                    showToast(state.message);
                                  }
                                },
                                builder: (context, state) {
                                  final bloc =
                                      context.read<SubmitRegisterCubit>();
                                  if (state is VerifyRegisterLoodingState) {
                                    return const Loading();
                                  }
                                  return Center(
                                    child: GradiantButton(
                                      title: e.tr("check"),
                                      tap: () {
                                        bloc.fVerifyRegister(
                                            phone: widget.phone,
                                            code: verFicationCode.text,
                                            formKey: formKey);
                                      },
                                    ),
                                  );
                                },
                              ),
                              // const Space(boxHeight: 20),
                              // Center(
                              //   child: Text(
                              //     e.tr("resend_code"),
                              //     style: TextStyles.textViewMedium18
                              //         .copyWith(color: mainColor),
                              //   ),
                              // ),
                              const Space(height: 20),
                            ],
                          ),
                        ),
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
