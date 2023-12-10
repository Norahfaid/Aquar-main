import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/dimenssions/screenutil.dart';
import '../../../auth/presentation/cubit/login_cubit/cubit/login_cubit_cubit.dart';
import '../../../home/presentation/widgets/details_container.dart';

class AdvertiserHeader extends StatelessWidget {
  const AdvertiserHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final userBloc = context.watch<LoginCubit>().user;
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: screenHeight / 5.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: lightBlackColor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Details2(
                      title: tr("advertiser_no"),
                      data: userBloc.licenseNumber,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 45,
                        width: 2,
                        color: lightGrey,
                      ),
                    ),
                    Details2(
                      title: tr("advertiser_status"),
                      data: userBloc.userType.kindTrans,
                      dataColor: iconBackground,
                    ),
                  ]),
            ),
          ),
          Positioned(
            top: -25,
            child: Material(
              elevation: 3,
              borderRadius: BorderRadius.circular(100),
              child: CircleAvatar(
                radius: 39,
                backgroundColor: greyColor,
                child: CircleAvatar(
                  radius: 37,
                  backgroundImage: NetworkImage(userBloc.avatar),
                ),
              ),
              // CachedNetworkImageProvider(
              //     user.avatar))),
            ),
          ),
        ],
      ),
    );
  }
}
