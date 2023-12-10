import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../auth/presentation/cubit/get_profile/get_profile_cubit.dart';

class NafazRegistrationDialog extends StatelessWidget {
  const NafazRegistrationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        backgroundColor: lightBlackColor,
        title: Text(
          'nafaz_register'.tr(),
        ),
        titleTextStyle: TextStyles.textViewBold20.copyWith(
          color: mainColor,
        ),
        content: Text(
          'nafaz_register_is_completed'.tr(),
        ),
        contentTextStyle: TextStyles.textViewRegular16.copyWith(
          color: white,
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.read<GetProfileCubit>().fGetProfile();
              Navigator.pop(context);
            },
            child: Text(
              'ok'.tr(),
              style: TextStyles.textViewBold16.copyWith(
                color: mainColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
