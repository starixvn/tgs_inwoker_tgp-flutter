import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tgp_flutter/custom/custom_dialog.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/leave_game_dialog.dart';
import 'package:api_package/entity/brand_communication.dart';
import 'package:api_package/entity/game.dart';
import 'package:api_package/entity/game_type.dart';
import 'package:tgp_flutter/environment_config.dart';
import 'package:api_package/extension/screen_apis.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/customer_service/customer_service_view_model.dart';
import 'package:tgp_flutter/ui/home/game/game_view_model.dart';

class CustomerServiceQrCode extends StatefulWidget {
  @override
  _CustomerServiceQrCodeState createState() => _CustomerServiceQrCodeState();
}

class _CustomerServiceQrCodeState extends BaseState<CustomerServiceQrCode> {
  CustomerServiceViewModel _vm = CustomerServiceViewModel();

  @override
  void initState() {
    _vm.getBrandCommunication();
    super.initState();
  }

  Widget build(BuildContext context) {
    return ProviderWidget<CustomerServiceViewModel>(
        model: _vm,
        builder: (ctx, vm, _) {
          _handleApiState();
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
              margin: EdgeInsets.only(top: 20.auto),
              child: Column(
                children: List.generate(_vm.communicationList.length, (index) {
                  return _buildQrImage(_vm.communicationList[index]);
                }),
              ),
            ),
          );
        });
  }

  _buildQrImage(BrandCommunication brandCommunication) =>
      Container(
        width: context.screenWidth,
        margin: EdgeInsets.only(bottom: 20.auto),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          QrImage(
            data: brandCommunication.qrCodeUrl,
            version: QrVersions.auto,
            size: 200.0,
          ),
          Text(brandCommunication.type)
        ]),
      );

  _handleApiState() {
    handleApiState(_vm.getBrandCommunicationApiState, onSuccess: () {});
  }
}
