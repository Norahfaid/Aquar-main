import 'package:aquar/core/util/validator.dart';
import 'package:aquar/core/widgets/loading_widget.dart';
import 'package:aquar/core/widgets/toast.dart';
import 'package:easy_localization/easy_localization.dart' as e;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/images.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/util/app_navigator.dart';
import '../../../../core/widgets/default_app_bar.dart';
import '../../../../core/widgets/gradiant_button.dart';
import '../../../../core/widgets/master_textfield.dart';
import '../../../../core/widgets/space.dart';
import '../../../../injection_container/injection_container.dart';
import '../../../auth/presentation/cubit/change_phone/cubit/change_phone_cubit.dart';
import '../../../auth/presentation/pages/verify_change_phone.dart';

class ChangePhoneScreen extends StatelessWidget {
  ChangePhoneScreen({super.key});

  final TextEditingController phoneController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: DefaultAppBar(
        title: e.tr("change_phone"),
        ontapLeading: () {
          sl<AppNavigator>().pop();
        },
          leadingIcon: const Icon(
            Icons.keyboard_arrow_right,
            color: Colors.black,
            size: 30,
          )
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Space(height: 10),
            Center(
              child: Image.asset(
                logoImage,
                height: 150.h,
              ),
            ),
            const Space(height: 70),
            Text(
              e.tr("phone_number"),
              style: TextStyles.textViewMedium18.copyWith(color: white),
            ),
            const Space(
              height: 10,
            ),
            MasterTextField(
              hintText: "",
              enabled: true,
              textDirection: TextDirection.ltr,
              keyboardType: TextInputType.phone,
              fillColor: lightBlackColor,
              controller: phoneController,
              validate: (value) => Validator.phone(value),
              filled: true,
              onEditingComplete: () {
                FocusScope.of(context).nextFocus();
              },
              onChanged: (String value) {},
            ),
            const Space(
              height: 80,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: BlocConsumer<ChangePhoneCubit, ChangePhoneState>(
                  listener: (context, state) {
                    if (state is ChangePhoneErrorState) {
                      showToast(state.message);
                    }
                    if (state is ChangePhoneSuccessState) {
                      sl<AppNavigator>().pop();
                      sl<AppNavigator>().push(
                          screen: ChangePhoneVerificationScreen(
                        phone: phoneController.text,
                      ));
                    }
                  },
                  builder: (context, state) {
                    if (state is ChangePhoneLoadingState) {
                      return const Loading();
                    }
                    return GradiantButton(
                      title: e.tr("data_modification"),
                      tap: (() {
                        context.read<ChangePhoneCubit>().fChangePhone(
                              phone: phoneController.text,
                            );
                      }),
                    );
                  },
                ),
              ),
            ),
            const Space(height: 20),
          ]),
        ),
      )),
    );
  }
}
