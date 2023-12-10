import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant/colors/colors.dart';
import 'arabic_input.dart';

// ignore: must_be_immutable
class GenericPasswordfield extends StatefulWidget {
  final TextEditingController? controller;
  String? Function(String?)? validator;
  final FocusNode? focusnode;
  final TextInputType textinputtype;
  final String? labeltext;
  final String? hinttext;
  final Widget? prefixIcon;
  final void Function(String)? onFieldSubmitted;
  final double? borderRaduis;
  final bool? isFilled;
  final bool? enable;
  final List<TextInputFormatter>? inputFormatters;
  final Color? colorStyle;
  final int? maxLines;
  final Function(String)? onChanged;
  GenericPasswordfield({
    super.key,
    this.controller,
    this.labeltext,
    this.textinputtype = TextInputType.text,
    this.focusnode,
    this.onFieldSubmitted,
    this.validator,
    this.hinttext,
    this.borderRaduis = 25,
    this.prefixIcon,
    this.isFilled = false,
    this.colorStyle = white,
    this.enable = true,
    this.maxLines = 1,
    this.onChanged,
    this.inputFormatters,
  });

  @override
  GenericPasswordfieldState createState() => GenericPasswordfieldState();
}

class GenericPasswordfieldState extends State<GenericPasswordfield> {
  bool _issecuire = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: widget.onFieldSubmitted,
      controller: widget.controller,
      obscureText: _issecuire,
      keyboardType: widget.textinputtype,
      focusNode: widget.focusnode,
      onChanged: widget.onChanged,
      inputFormatters:
          widget.inputFormatters ?? [ArabicNumberTextInputFormatter()],
      autocorrect: true,
      validator: widget.validator,
      style: TextStyle(
        fontSize: 14,
        color: widget.colorStyle!,
      ),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        prefixIcon: widget.prefixIcon,
        hintText: widget.hinttext,
        labelText: widget.labeltext,
        hintStyle: TextStyle(fontSize: 14.sp, color: widget.colorStyle),
        labelStyle: TextStyle(fontSize: 14.sp, color: widget.colorStyle),
        border: OutlineInputBorder(
            borderSide: BorderSide(
              width: .5,
              color: widget.isFilled == true ? transparent : widget.colorStyle!,
            ),
            borderRadius: BorderRadius.circular(widget.borderRaduis!.sp)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color:
                    widget.isFilled == true ? transparent : widget.colorStyle!,
                width: .5),
            borderRadius: BorderRadius.circular(widget.borderRaduis!.sp)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: widget.isFilled == true ? transparent : widget.colorStyle!,
              width: .5),
          borderRadius: BorderRadius.circular(widget.borderRaduis!.sp),
        ),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: redColor, width: .5),
            borderRadius: BorderRadius.circular(widget.borderRaduis!.sp)),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _issecuire = !_issecuire;
            });
          },
          icon: Icon(
            _issecuire == false ? Icons.visibility : Icons.visibility_off,
            // color:
            // _issecuire == true ? Color(0xFFE0E0E0) : AppColors.subColor,
            size: 25,
            color: const Color(0xffCCCCCC),
          ),
        ),
      ),
    );
  }
}
