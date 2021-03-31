import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
//import 'package:webview_flutter/webview_flutter.dart';

class DepositWeb extends StatefulWidget{
  final String url;
  final String typeTitle;
  final String params;

  DepositWeb({Key key,
    this.url,
    this.typeTitle,
    this.params,
  }) : super(key: key);

  @override
  _DepositWebState createState() => _DepositWebState();
}

class _DepositWebState extends BaseState<DepositWeb> {
  //InAppWebViewController _webViewController;
  var _stackNum = 1;
  String url = "";
  double progress = 0;

  void _handleLoad(String value) {
    setState(() {
      _stackNum = 0;
    });
  }

  Widget build(BuildContext context) {
    print("url=${widget.url}");
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
            widget.typeTitle??"",
            style: TextStyle(fontSize: 20.auto),),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: widget.url==null?Center(child: CircularProgressIndicator()):
            Container()
        /*InAppWebView(
            initialUrl: widget.url,
            initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  debuggingEnabled: true,
                  javaScriptEnabled: true,
                ),
                android:  AndroidInAppWebViewOptions(
                  useWideViewPort: true,
                  mixedContentMode: AndroidMixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW,
                )
            ),
            onWebViewCreated: (InAppWebViewController controller) {
              _webViewController = controller;
              if(widget.params!=null) _webViewController.postUrl(url: widget.url, postData: utf8.encode(widget.params));
              else _webViewController.loadUrl(url: widget.url);
            },
            onLoadStart: (InAppWebViewController controller, String url) {
              setState(() {
                this.url = url;
              });
            },
            onLoadStop: (InAppWebViewController controller, String url) async {
              setState(() {
                this.url = url;
              });
            },
            onProgressChanged: (InAppWebViewController controller, int progress) {
              setState(() {
                this.progress = progress / 100;
              });
            },
          ),*/

    );
  }
}