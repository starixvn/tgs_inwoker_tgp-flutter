import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tgp_flutter/custom/custom_picker_dialog.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/environment_config.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/ui/customer_service/customer_service_view_model.dart';

class BlacklistedUser extends StatefulWidget {
  @override
  _BlacklistedUserState createState() => _BlacklistedUserState();
}

class _BlacklistedUserState extends BaseState<BlacklistedUser> {
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[100],
      body: Container(
        padding: EdgeInsets.only(top: 100.auto),
        width: context.screenWidth,
        height: context.screenHeight,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("images/blacklisted.png"), fit: BoxFit.fill),
        ),
        child: Column(
          children: [
            _buildText("您的账号已被封锁\n请联系客服"),
            _buildText("Your account has been locked,\n please contact with customer service."),

          ],
        ),
      ),
    );
  }

  _buildText(String text) =>
      Container(
        margin: EdgeInsets.only(bottom: 20.auto),
        child: Text(
          text,
          style: TextStyle(color: Colors.white,
              fontSize: 16.auto,),
          textAlign: TextAlign.center,
        ),
      );

  _buildCSText(String text) => InkWell(
    onTap: (){
      Navigator.pushNamed(context, "/cs_web_view");
    },
    child: Text(
      text,
      style: TextStyle(
          color: Colors.white,
          fontSize: 12.auto,
          decoration:  TextDecoration.underline ),
      textAlign: TextAlign.center,
    ),
  );
}
