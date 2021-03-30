import 'package:flutter/material.dart';
import 'package:tgp_flutter/extension/screen_util.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/login/login_tab.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/ui/login/login_view_model.dart';


class Login extends StatefulWidget{
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends BaseState<Login>{
  var _vm = LoginViewModel();

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: context.screenHeight,
        width: context.screenWidth,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/login_bg.png"),
              fit: BoxFit.fill
          ),
        ),
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: ScreenUtil
                    .getInstance()
                    .statusBarHeight),
                child: Image.asset(
                  "images/ic_logo.png",
                  height: 100.auto,
                  fit: BoxFit.contain,
                )
            ),
            Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 27.auto),
                  child: LoginTab(),
                )
            )
          ],
        ),
      ),
    );
  }
}







