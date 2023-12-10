import '../constant/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant/colors/colors.dart';

class MainDropDown<T> extends StatelessWidget {
  const MainDropDown(
      {super.key,
      required this.hint,
      this.prefixIcon,
      required this.items,
      this.value,
      this.onChange,
      this.filled = false,
      this.fillColor = Colors.transparent});
  final String hint;
  final List<DropdownMenuItem<T>> items;
  final IconData? prefixIcon;
  final dynamic value;
  final dynamic onChange;
  final bool? filled;
  final Color? fillColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: DropdownButtonFormField<T>(
        isExpanded: false,
        icon: const Icon(Icons.keyboard_arrow_down, color: white, size: 25),
        style: TextStyles.textViewMedium15.copyWith(color: greyColor),
        dropdownColor: greyDarkColor,
        decoration: InputDecoration(
          filled: filled,
          fillColor: fillColor,
          contentPadding: const EdgeInsets.symmetric(horizontal: 5),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: greyColor.withOpacity(.5)),
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: hint,
          hintStyle: TextStyle(color: greyColor.withOpacity(.8), fontSize: 13),
          prefixIcon: Icon(
            prefixIcon,
            // size: 40.h,
            color: white,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(width: 1.w, color: greyColor.withOpacity(.3)),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        items: items,
        value: value,
        onChanged: onChange,
      ),
    );
  }
}
/*
<String>[
          'المملكة العربية السعودية', 'مصر ', 'الامارات', 'الكويت'
          ].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value,style: TextStyles.textViewSemiBold15.copyWith(color: hintTextColor)),
          );
        }).toList(),
*/