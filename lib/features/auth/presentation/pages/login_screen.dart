import 'package:easy_localization/easy_localization.dart' as e;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/widgets/space.dart';
import '../widgets/auth_body_decoration.dart';
import '../widgets/auth_logo.dart';
import '../widgets/auth_page_title.dart';
import '../widgets/auth_screen_background.dart';
import '../widgets/login_screen_body.dart';

DateTime currentBackPressTime = DateTime(1);
Future<bool> onWillPop() {
  DateTime now = DateTime.now();
  if (now.difference(currentBackPressTime) > const Duration(seconds: 3)) {
    currentBackPressTime = now;
    Fluttertoast.showToast(msg: e.tr("app_will_closed"));

    return Future.value(false);
  }
  return Future.value(true);
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      // onWillPop: ()async{
      //   SystemNavigator.pop();
      //   return true;
      // },

      child: Scaffold(
        // resizeToAvoidBottomInset: false,

        key: scaffoldKey,
        body: const Stack(
          alignment: Alignment.center,
          children: [
            AuthScreenBackground(),
            SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                children: [
                  AuthLogo(),
                  Space(height: 20),
                  AuthPageTitle(titleKey: 'login'),
                  Space(height: 30),
                  AuthBodyDecoration(
                    child: LoginScreenBody(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
