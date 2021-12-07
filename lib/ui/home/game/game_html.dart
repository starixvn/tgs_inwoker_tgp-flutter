import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tgp_flutter/entity/game_type.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'game_view_model.dart';

class GameHtml extends StatefulWidget {
  final String? htmlText;

  GameHtml({this.htmlText});

  @override
  _GameHtmlState createState() => _GameHtmlState();
}

class _GameHtmlState extends BaseState<GameHtml> {
  WebViewController? _controller;
  String text =
      '<html><body><div id="bcsportsbookcontainer"></div><script id="bcsportsbook" src="https://devmobile.srvttt.com/js/partnerinit.js?containerID=bcsportsbookcontainer&UserId=1877685&AuthToken=cZTomgocaIibAJpAUPiZmo&lang=eng&sport=1"></script></body></html>';
  
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      height: context.screenHeight,
      child: Builder(builder: (BuildContext context) {
        return WebView(
          onWebViewCreated: (WebViewController webViewController) {
            _controller = webViewController;
            _controller!.runJavascript(text);
          },
          javascriptMode: JavascriptMode.unrestricted,
         /* onPageFinished: (_){
            _controller!.runJavascript(text);
          },*/
        );
      }),
    );
  }

  _loadUrl() async {
    _controller!.loadUrl(
      Uri.dataFromString(
        '<html><body>'+widget.htmlText!+'</body></html>',
        mimeType: 'text/html',
      ).toString(),
    );
  }
}
