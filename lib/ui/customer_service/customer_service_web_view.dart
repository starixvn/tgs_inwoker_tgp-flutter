import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:tgp_flutter/custom/custom_dialog.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/leave_game_dialog.dart';
import 'package:tgp_flutter/entity/game.dart';
import 'package:tgp_flutter/entity/game_type.dart';
import 'package:tgp_flutter/environment_config.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/customer_service/customer_service_view_model.dart';
import 'package:tgp_flutter/ui/home/game/game_view_model.dart';

class CustomerServiceWebView extends StatefulWidget {
  final String url;
  final String brandLogoUrl;

  CustomerServiceWebView({
    Key key,
    this.url,
    this.brandLogoUrl
  }) : super(key: key);

  @override
  _CustomerServiceWebViewState createState() => _CustomerServiceWebViewState();
}

class _CustomerServiceWebViewState extends BaseState<CustomerServiceWebView> {
  InAppWebViewController _webViewController;
  var url = EnvironmentConfig.csUrl;
//  CustomerServiceViewModel _vm = CustomerServiceViewModel();

  @override
  void initState() {
    super.initState();
  }

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
      body: widget.url == null
          ? buildProgressDialog(widget.brandLogoUrl)
          : InAppWebView(
        initialUrl: widget.url,
        initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              debuggingEnabled: true,
              javaScriptEnabled: true,
            ),
            android: AndroidInAppWebViewOptions(
              useWideViewPort: true,
              mixedContentMode: AndroidMixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW,
            )),
        onWebViewCreated: (InAppWebViewController controller) {
          _webViewController = controller;
          _webViewController.loadUrl(url: widget.url);
        },
        onLoadStart: (InAppWebViewController controller, String url) {
          ProgressDialog.show(context, widget.brandLogoUrl);
        },
        onLoadStop: (InAppWebViewController controller, String url) async {
          ProgressDialog.hide();
        },
      ),
    );
  }
}
