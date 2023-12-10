import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/widgets/space.dart';

class DeleteAdvDialoug extends StatefulWidget {
  const DeleteAdvDialoug({super.key, required this.no, required this.yes});
  final Function no;
  final Function yes;

  @override
  State<DeleteAdvDialoug> createState() => _DeleteAdvDialougState();
}

class _DeleteAdvDialougState extends State<DeleteAdvDialoug> {
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
      // title: SvgPicture.asset(
      //   logoutDialogImage,
      //   // color: mainColor,
      // ),
      actions: [
        Column(
          children: [
            const Space(
              height: 30,
            ),
            Text(
              tr("are_you_sure_to_delete_adv"),
              style: TextStyles.textViewRegular16.copyWith(color: textColor),
            ),
            const Space(
              height: 30,
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
                              toggleIsLoading();
                              await widget.yes();
                              toggleIsLoading();
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
                                      tr("no"),
                                      style: TextStyles.textViewMedium18
                                          .copyWith(color: mainColor),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                        TextButton(
                            onPressed: () => widget.no(),
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
                                    tr("delete"),
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
