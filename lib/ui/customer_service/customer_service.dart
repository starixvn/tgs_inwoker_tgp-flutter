import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tgp_flutter/custom/custom_picker_dialog.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/gradient_button.dart';
import 'package:tgp_flutter/environment_config.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/ui/customer_service/customer_service_view_model.dart';

class CustomerService extends StatefulWidget {
  @override
  _CustomerServiceState createState() => _CustomerServiceState();
}

class _CustomerServiceState extends BaseState<CustomerService> {
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: gradientDecoration,
          ),
          centerTitle: true,
          title: Text(
            getTranslatedText("customer_service"),
            style: TextStyle(fontSize: 20.auto),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Container(
          width: context.screenWidth,
          height: context.screenHeight,
          padding: EdgeInsets.only(top: 150.auto, left: 20.auto, right: 20.auto),
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("images/customer_service.png"), fit: BoxFit.fill),
          ),
          child: Column(children: [
            Container(
              margin: EdgeInsets.only(bottom: 10.auto),
              child: GradientButton(
                title: "立即联系",
                onClick: () => Navigator.of(context).pushNamed("/cs_web_view"),
                isEnabled: true,
                radius: 15,
                height: 40.auto,
                width: 150.auto,
              ),
            ),
            _buildCSRow("在线客服", "联系", "cs_web_view"),
            _buildCSRow("二维码客服", "加入", "cs_qr_code"),
          ]),
        ));
  }

  _buildCSRow(String title, String text, String routePath) => InkWell(
        onTap: () => Navigator.of(context).pushNamed("/$routePath"),
        child: Container(
          padding: EdgeInsets.only(left: 30.auto, right: 50.auto),
          margin: EdgeInsets.only(top: 15.auto),
          height: 40.auto,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
              ),
              Text(
                text,
                style: TextStyle(color: CustomColor.theme_bar_gradient_1),
              )
            ],
          ),
        ),
      );
}
