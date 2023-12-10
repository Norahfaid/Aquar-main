import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/presentation/cubit/auto_login/auto_login_cubit.dart';

class HideFromGuestWidget extends StatelessWidget {
  const HideFromGuestWidget({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AutoLoginCubit, AutoLoginState>(
      builder: (context, state) {
        if (state is AutoLoginGuest) {
          return const SizedBox();
        }
        return child;
      },
    );
  }
}
