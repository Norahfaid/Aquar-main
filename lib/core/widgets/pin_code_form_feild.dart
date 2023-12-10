import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../core/util/validator.dart';
import '../constant/colors/colors.dart';
import 'arabic_input.dart';

class PinCodeWidget extends StatelessWidget {
  const PinCodeWidget({
    Key? key,
    required this.verificationCode,
  }) : super(key: key);

  final TextEditingController verificationCode;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PinCodeTextField(
          cursorColor: mainColor,
          length: 4,
          inputFormatters: [ArabicNumberTextInputFormatter()],
          // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          keyboardAppearance: Brightness.dark,
          appContext: context,
          animationType: AnimationType.fade,
          keyboardType: TextInputType.number,
          backgroundColor: Colors.transparent,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(10),
            fieldHeight: 85.h,
            fieldWidth: 75.w,
            activeColor: greyColor,
            disabledColor: greyColor,
            borderWidth: 1,
            selectedColor: greyColor,
            inactiveColor: greyColor,
          ),
          textStyle: const TextStyle(
            color: mainColor,
            fontWeight: FontWeight.bold,
          ),
          controller: verificationCode,
          onChanged: (String value) {},
          onCompleted: (value) {},
          validator: (val) => Validator.defaultValidator(val)),
    );
  }
}
