import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:tgp_flutter/custom/custom_picker_dialog.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

class CustomerService extends StatefulWidget {
  @override
  _CustomerServiceState createState() => _CustomerServiceState();
}

class _CustomerServiceState extends BaseState<CustomerService> {
  InAppWebViewController _webViewController;
  var url = DotEnv.env["csUrl"];

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
        body: InAppWebView(
          initialUrl: url,
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
            _webViewController.loadUrl(url: url);
          },
          onLoadStart: (InAppWebViewController controller, String url) {
            ProgressDialog.show(context);
          },
          onLoadStop: (InAppWebViewController controller, String url) async {
            ProgressDialog.hide();
          },
        ));
  }
}
