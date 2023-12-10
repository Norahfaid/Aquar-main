import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/dimenssions/screenutil.dart';
import '../../../../core/constant/lottie.dart';
import '../../../../core/widgets/main_button.dart';
import '../cubit/auto_login/auto_login_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: SizedBox(
        height: screenHeight,
        width: double.infinity,
        child: BlocBuilder<AutoLoginCubit, AutoLoginState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Lottie.asset(
                    newLogo,
                    frameRate: FrameRate.max,
                    width:screenWidth,
                    height: screenHeight,
                    repeat: true

                  ),
                ),
                // if (state is AutoLoginInternetError)
                //   Text(
                //     tr('there_are_no_internet_please_try_again'),
                //     style: const TextStyle(color: white),
                //   ),
                // if (state is AutoAuthInternetError)
                //   Text(
                //     tr('there_are_no_internet_please_try_again2'),
                //     style: const TextStyle(color: white),
                //   ),
                // const SizedBox(height: 20),
                // if (state is AutoLoginInternetError ||
                //     state is AutoAuthInternetError)
                //   MainButton(
                //     text: tr("try_again"),
                //     buttonWidth: screenWidth - 120,
                //     onPressed: () {
                //       context.read<AutoLoginCubit>().fAutoLogin();
                //     },
                //   ),
                // const SizedBox(
                //   height: 20,
                // ),
                // if (state is AutoLoginInternetError ||
                //     state is AutoAuthInternetError)
                //   MainButton(
                //     text: tr("login"),
                //     buttonWidth: screenWidth - 120,
                //     onPressed: () {
                //       context.read<AutoLoginCubit>().emitNoUser();
                //     },
                //   ),
              ],
            );
          },
        ),
      ),
    );
  }
}
