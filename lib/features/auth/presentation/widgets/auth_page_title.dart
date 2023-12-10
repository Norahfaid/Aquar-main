import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/styles/styles.dart';

class AuthPageTitle extends StatelessWidget {
  final String titleKey;
  const AuthPageTitle({
    required this.titleKey,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        titleKey.tr(),
        style: TextStyles.textViewBold25.copyWith(color: white,),
      ),
    );
  }
}
