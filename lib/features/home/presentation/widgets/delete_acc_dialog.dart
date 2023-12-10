import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/images.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/widgets/password_text_feild.dart';
import '../../../../core/widgets/space.dart';

class DeleteAccDialoug extends StatefulWidget {
  const DeleteAccDialoug(
      {super.key,
      required this.no,
      required this.yes,
      required this.passController});
  final Function no;
  final Function yes;
  final TextEditingController passController;
  @override
  State<DeleteAccDialoug> createState() => _DeleteAccDialougState();
}

class _DeleteAccDialougState extends State<DeleteAccDialoug> {
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
              tr("are_you_sure_to_delete_account"),
              style: TextStyles.textViewRegular16.copyWith(color: textColor),
            ),
            const Space(
              height: 10,
            ),
            PasswordMasterTextField(
              controller: widget.passController,
              hintText: tr("enter_password"),
              isPassword: true,
              onChanged: (String value) {},
              onEditingComplete: () {
                // FocusScope.of(context).unfocus();
              },
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
                              toggleIsLoading();
                              await widget.yes();
                              toggleIsLoading();
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
                                    tr("delete_account"),
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
