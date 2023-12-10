import 'package:flutter/material.dart';

SnackBar appSnackBar(String snackText, {Color color = Colors.red}) => SnackBar(
      content: Text(
        snackText,
        textAlign: TextAlign.center,
      ),
      duration: const Duration(seconds: 1),
      backgroundColor: color,
      // action: [SnackBarAction(label: tr("ok"), onPressed: (){})],
    );
