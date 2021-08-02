import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:api_package/extension/screen_util.dart';
import 'package:tgp_flutter/environment_config.dart';
import 'package:api_package/extension/screen_util.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/login/login_tab.dart';
import 'package:api_package/extension/screen_apis.dart';
import 'package:tgp_flutter/ui/login/login_view_model.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends BaseState<Login> {
  var _vm = LoginViewModel();
  PackageInfo packageInfo;
  String version;

  @override
  void initState() {
    _getPackageInfo();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: version ==null?buildProgressDialog():Container(
        height: context.screenHeight,
        width: context.screenWidth,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("images/login_bg.png"), fit: BoxFit.fill),
        ),
        child: Column(
          children: [
            _buildLogoImage(),
            Expanded(
                child: Container(
              margin: EdgeInsets.symmetric(horizontal: 27.auto),
              child: LoginTab(),
            )),
            _buildVersionText(),
          ],
        ),
      ),
    );
  }

  _buildVersionText() {
    return Column(
    children: [
      VerticalDivider(
        color: CustomColor.grey_five,
        width: 0.5,
      ),
      Container(
        margin: EdgeInsets.only(right: 2.auto, bottom: 2.auto),
        alignment: Alignment.centerRight,
        child: Text("Version $version (${EnvironmentConfig.environmentStage})",
        style: TextStyle(
          fontSize: 8.auto
        ),),
      )
    ],
  );}

  _buildLogoImage() => Container(
      margin: EdgeInsets.only(top: ScreenUtil.getInstance().statusBarHeight),
      child: Image.asset(
        "images/login/${EnvironmentConfig.imageLogo}.png",
        height: 100.auto,
        fit: BoxFit.contain,
      ));

  _getPackageInfo() async{
    packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
    });
  }
}
