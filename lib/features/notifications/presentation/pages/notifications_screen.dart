import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/util/app_navigator.dart';
import '../../../../core/widgets/default_app_bar.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/space.dart';
import '../../../../injection_container/injection_container.dart';
import '../cubit/notifications_cubit.dart';
import '../widgets/notification_card.dart';

class NotificationsScereen extends StatefulWidget {
  const NotificationsScereen({super.key});

  @override
  State<NotificationsScereen> createState() => _NotificationsScereenState();
}

class _NotificationsScereenState extends State<NotificationsScereen> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationsCubit>().fGetNotifications();
    log("${context.read<NotificationsCubit>().data.length};lllllll");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: blackColor,
        appBar: DefaultAppBar(
          title: tr("notifications"),
          ontapLeading: () {
            sl<AppNavigator>().pop();
          },
          leadingIcon: const Icon(
            Icons.keyboard_arrow_right,
            color: Colors.black,
            size: 30,
          )
        ),
        body: BlocConsumer<NotificationsCubit, NotificationsState>(
          listener: (context, state) {
            // if (state is GetNotificationsErrorState) {
            //   return showToast(state.message);
            // }
          },
          builder: (context, state) {
            if (state is GetNotificationsLoadingState) {
              return const Loading();
            }

            final notificationList = context.watch<NotificationsCubit>().data;
            return Column(
              children: [
                const Divider(
                  color: greyColor,
                  height: 1,
                ),
                const Space(
                  height: 20,
                ),
                if (notificationList.isEmpty)
                  Expanded(
                    child: Center(
                      child: Text(
                        tr("have_no_notifications"),
                        style:
                            TextStyles.textViewMedium20.copyWith(color: white),
                      ),
                    ),
                  ),
                if (notificationList.isNotEmpty)
                  Expanded(
                    child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: List.generate(
                              notificationList.length,
                              (index) => NotificationsCard(
                                  isRead: true,
                                  message: notificationList[index].message,
                                  title: notificationList[index].title,
                                  time: notificationList[index]
                                      .createTime
                                      .split(' ')[0])),
                        )),
                  ),
              ],
            );
          },
        ));
  }
}
