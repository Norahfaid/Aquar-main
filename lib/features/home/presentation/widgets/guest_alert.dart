import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/images.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/util/app_navigator.dart';
import '../../../../core/widgets/space.dart';
import '../../../../injection_container/injection_container.dart';
import '../../../auth/presentation/cubit/auto_login/auto_login_cubit.dart';

class GuestDialoug extends StatefulWidget {
  const GuestDialoug({
    super.key,
  });

  @override
  State<GuestDialoug> createState() => _GuestDialougState();
}

class _GuestDialougState extends State<GuestDialoug> {
  bool isLoading = false;
  void toggleIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: lightBlackColor,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: mainColor.withOpacity(.5)),
          borderRadius: const BorderRadius.all(Radius.circular(20.0))),
      title: SvgPicture.asset(
        logoutDialogImage,
        // color: mainColor,
      ),
      actions: [
        Column(
          children: [
            Text(
              tr("please_login"),
              style: TextStyles.textViewRegular16.copyWith(color: textColor),
            ),
            const Space(
              height: 10,
            ),
            isLoading
                ? const Center(
                    child: SizedBox(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator()),
                  )
                : FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                            onPressed: () async {
                              sl<AppNavigator>().pop();
                              //  sl<AppNavigator>().pop();
                            },
                            child: Container(
                              width: 130,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: brownColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: FittedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Text(
                                      tr("Continue_application"),
                                      style: TextStyles.textViewMedium18
                                          .copyWith(color: mainColor),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                        TextButton(
                            onPressed: () {
                              sl<AppNavigator>().popToFrist();
                              sl<AutoLoginCubit>().emitNoUser();
                            },
                            child: Container(
                              width: 130,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: mainColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                    tr("login"),
                                    style: TextStyles.textViewMedium18
                                        .copyWith(color: white),
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
            const Space(
              height: 20,
            )
          ],
        )
        // The "Yes" button
      ],
    );
  }
}
