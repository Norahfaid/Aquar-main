import 'package:aquar/features/auth/presentation/widgets/auth_body_decoration.dart';
import 'package:easy_localization/easy_localization.dart' as e;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/util/app_navigator.dart';
import '../../../../core/widgets/default_app_bar.dart';
import '../../../../core/widgets/gradiant_button.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/pin_code_form_feild.dart';
import '../../../../core/widgets/space.dart';
import '../../../../core/widgets/timer_cubit/timer_cubit.dart';
import '../../../../core/widgets/timer_cubit/timer_states.dart';
import '../../../../core/widgets/toast.dart';
import '../../../../injection_container/injection_container.dart';
import '../../../settings/presentation/pages/profile_screen.dart';
import '../cubit/change_phone/cubit/change_phone_cubit.dart';
import '../cubit/get_profile/get_profile_cubit.dart';
import '../cubit/verify_change_phone/cubit/verify_change_phone_cubit.dart';
import '../widgets/auth_logo.dart';

class ChangePhoneVerificationScreen extends StatefulWidget {
  final String phone;

  const ChangePhoneVerificationScreen({
    required this.phone,
    super.key,
  });

  @override
  State<ChangePhoneVerificationScreen> createState() => _ChangePhoneVerificationScreenState();
}

class _ChangePhoneVerificationScreenState extends State<ChangePhoneVerificationScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController verificationCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<TimerCubit>().startTimer());
    context.read<TimerCubit>().start = 59;
  }

  bool tapped = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        sl<AppNavigator>().pop();
        return true;
      },
      child: BlocProvider<TimerCubit>(
        create: (BuildContext context) => TimerCubit()..startTimer(),
        child: Scaffold(
          backgroundColor: blackColor,
          appBar: DefaultAppBar(
            title: e.tr("change_phone"),
            ontapLeading: () {
              sl<AppNavigator>().pop();
            },
            // leadingIcon: const Icon(
            //   Icons.keyboard_arrow_right,
            // )
          ),
          body: Form(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Space(height: 50,),
                  const AuthLogo(),
                  // const Space(boxHeight: 20),
                  // Center(
                  //   child: Text(
                  //     e.tr("change_phone"),
                  //     style: TextStyles.textViewBold25.copyWith(color: white),
                  //   ),
                  // ),
                  const Space(height: 30,),
                  AuthBodyDecoration(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Space(height: 10,),
                        PinCodeWidget(verificationCode: verificationCodeController),
                        const Space(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BlocConsumer<ChangePhoneCubit, ChangePhoneState>(
                              listener: (context, state) async {
                                if (state is ChangePhoneSuccessState && tapped == true) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        e.tr("code_resend_success"),
                                        style: TextStyles.textViewMedium18
                                            .copyWith(
                                          color: Colors.greenAccent,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                if (state is ChangePhoneErrorState) {
                                  showToast(state.message);
                                }
                              },
                              builder: (context, state) {
                                if (state is ChangePhoneLoadingState) {
                                  return const Loading();
                                }
                                return BlocBuilder<TimerCubit, TimerState>(
                                  builder: (context, state) {
                                    final timerBloc = BlocProvider.of<TimerCubit>(context);
                                    if(state is TimerStart){
                                      return Text(
                                        e.tr("resend_code"),
                                        style: TextStyles.textViewMedium18.copyWith(color: Colors.grey,),
                                      );
                                    }
                                    return TextButton(
                                      onPressed: () {
                                        if (timerBloc.start == 00) {
                                          context.read<ChangePhoneCubit>().fChangePhone(
                                            phone: widget.phone,
                                          );
                                          timerBloc.startTimer();
                                          tapped = true;
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
                          child: BlocConsumer<VerifyChangePhoneCubit, VerifyChangePhoneState>(
                            listener: (context, state) {
                              if (state is VerifyChangePhoneSuccessState) {
                                context.read<GetProfileCubit>().fGetProfile();
                                sl<AppNavigator>().pushReplacement(screen: const ProfileScreen());
                              }
                              if (state is VerifyChangePhoneErrorState) {
                                showToast(state.message);
                              }
                            },
                            builder: (context, state) {
                              if (state is VerifyChangePhoneLoadingState) {
                                return const Loading();
                              }
                              return GradiantButton(
                                title: e.tr("check"),
                                tap: () {
                                  context.read<VerifyChangePhoneCubit>().fChangePhone(
                                    phone: widget.phone,
                                    code: verificationCodeController.text,
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
          ),
        ),
      ),
    );
  }
}
