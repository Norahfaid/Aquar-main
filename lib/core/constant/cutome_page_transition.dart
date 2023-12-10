import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomePageTransition extends PageTransitionsBuilder {
  static bool chatOrNotification = false;
  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return CupertinoPageTransition(
      primaryRouteAnimation: animation,
      secondaryRouteAnimation: secondaryAnimation,
      linearTransition: true,
      child: child,
    );
  }
}
