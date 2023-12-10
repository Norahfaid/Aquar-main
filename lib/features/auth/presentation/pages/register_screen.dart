import 'package:aquar/features/auth/presentation/widgets/register_screen_body.dart';
import 'package:flutter/material.dart';


import '../../../../core/widgets/space.dart';
import '../widgets/auth_body_decoration.dart';
import '../widgets/auth_logo.dart';
import '../widgets/auth_screen_background.dart';
import '../widgets/auth_page_title.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      body: const Stack(
        alignment: Alignment.center,
        children: [
          AuthScreenBackground(),
          SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                //region:: AppLogo
                Padding(
                  padding: EdgeInsets.only(top: 60, bottom: 10,),
                  child: AuthLogo(),
                ),
                Space(height: 20,),
                //endregion

                //region:: Register title
                AuthPageTitle(titleKey: 'register'),
                Space(height: 30,),
                //endregion

                AuthBodyDecoration(
                  child: RegisterScreenBody(),
                ),
                Space(height: 40,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
