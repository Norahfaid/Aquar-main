import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/dimenssions/screenutil.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/util/api_basehelper.dart';
import '../../../../core/util/app_navigator.dart';
import '../../../../core/widgets/space.dart';
import '../../../../injection_container/injection_container.dart';
import '../../../auth/presentation/cubit/auto_login/auto_login_cubit.dart';

class LangModalSheet extends StatefulWidget {
  const LangModalSheet({super.key, required this.locale});
  final Locale locale;
  @override
  State<LangModalSheet> createState() => _LangModalSheetState();
}

class _LangModalSheetState extends State<LangModalSheet> {
  String _groupValue = '';

  void checkRadio(String value) {
    setState(() {
      _groupValue = value;
    });
    sl<AppNavigator>().popToFrist();
    sl<ApiBaseHelper>().updateLocalInHeaders(_groupValue);
    EasyLocalization.of(context)!.setLocale(Locale(_groupValue));
    setState(() {});
    sl<AutoLoginCubit>().emitChangeLang();
  }

  @override
  void initState() {
    super.initState();
    _groupValue = widget.locale.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        width: screenWidth,
        margin: const EdgeInsets.only(top: 6.0),
        decoration: const BoxDecoration(
          color: blackColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              color: mainColor,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 3,
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tr("language"),
                    style: TextStyles.textViewBold20.copyWith(color: white),
                  ),
                  IconButton(
                      onPressed: () {
                        sl<AppNavigator>().pop();
                      },
                      icon: const Icon(
                        Icons.close,
                        color: white,
                        size: 25,
                      ))
                ],
              ),
            ),
            const Divider(
              color: greyColor,
              height: 1,
            ),
            const Space(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                height: 55,
                width: screenWidth,
                decoration: BoxDecoration(
                  color: lightBlackColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Radio(
                        fillColor:
                            MaterialStateProperty.all(const Color(0xFFCBA588)),
                        activeColor: const Color(0xFFCBA588),
                        value: 'ar',
                        groupValue: _groupValue,
                        onChanged: (value) {
                          checkRadio(value!);
                        }),
                    Text(
                      tr("arabic"),
                      style: const TextStyle(fontSize: 15, color: white),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                height: 55,
                width: screenWidth,
                decoration: BoxDecoration(
                  color: lightBlackColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Radio(
                        fillColor:
                            MaterialStateProperty.all(const Color(0xFFCBA588)),
                        activeColor: const Color(0xFFCBA588),
                        value: 'en',
                        groupValue: _groupValue,
                        onChanged: (value) {
                          checkRadio(value!);
                        }),
                    Text(
                      tr("english"),
                      style: const TextStyle(fontSize: 15, color: white),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
