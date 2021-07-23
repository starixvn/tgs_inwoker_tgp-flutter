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

class Maintenance extends StatefulWidget {
  @override
  _MaintenanceState createState() => _MaintenanceState();
}

class _MaintenanceState extends BaseState<Maintenance> {
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 100.auto),
      width: context.screenWidth,
      height: context.screenHeight,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("images/maintenance.png"), fit: BoxFit.fill),
      ),
      child: Column(
        children: [
          _buildText("我们正在维护中，请稍后再试。"),
          _buildText("如您有任何问题，请联系客服。"),
          _buildText("We are currently under maintenance,\n"
              "please try again later.\n"),
          _buildText(
            "If you have any questions,\n"
            "please contact our customer service.",
          ),
        ],
      ),
    );
  }

  _buildText(String text) => Container(
        margin: EdgeInsets.only(bottom: 20.auto),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      );
}
