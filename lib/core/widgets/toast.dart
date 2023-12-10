import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast(String? message) {
  Fluttertoast.showToast(
      backgroundColor: Colors.black,
      textColor: Colors.white,
      msg: message.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 2);
}
