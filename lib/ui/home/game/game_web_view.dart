import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/leave_game_dialog.dart';
import 'package:tgp_flutter/entity/game_type.dart';
import 'package:tgp_flutter/environment_config.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/home/game/game_view_model.dart';

class GameWeb extends StatefulWidget {
  final int? gameId;
  final String? gamePlatformCode;
  final GameType? gameType;

  GameWeb({this.gameId, this.gameType, this.gamePlatformCode});

  @override
  _GameWebState createState() => _GameWebState();
}

class _GameWebState extends BaseState<GameWeb> {
  var _vm = GameViewModel();
  InAppWebViewController? _webViewController;
  var isLoading = false;
  String? url, lobbyUrl;
  var prefs;

  @override
  void initState() {
    lobbyUrl =
        "http://gci.aggdemo.com:81/forwardGame.do?params=4DJlwdGL1cWclbwxZFKgtr6rJmU8Mqe0y4VXswlHs8uWLV/LAwtfY9/SYLWTh/MBrOQNAdd/nZiuIaXx1/ZDX71ziYHXpHj9WeekhidF60CbLBd9VFlD9EYcWQOX7ALM/w3Ww5Yy86wEsd/IgnUTGwU7vX+3btJezXPCNriz+iYgg9d9jU6yEAXdEN0H7L/tkDdt8IWJGjAqQ2334aF5vlPc2f7DCzM7&key=8dc57f4377fc86da1d0d9e47495993e0";
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (widget.gameType == null || widget.gameId == 1800001 || widget.gameId == 1800002 || widget.gameId == 1800003)
        _vm.getGameUrl(widget.gamePlatformCode!, widget.gameId!, lobbyUrl!);
      else
        _vm.getLobbyGameUrl(widget.gamePlatformCode!, widget.gameType!, lobbyUrl!);
    });
    _getSharedPrefs();
    super.initState();
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _webViewController!.goBack();
        _webViewController!.goBack();
        return true;
      },
      child: ProviderWidget<GameViewModel>(
          model: _vm,
          builder: (ctx, vm, _) {
            _handleApiState();
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              appBar: _buildAppBar(),
              body: (_vm.url == null /*|| _vm.betConstructHtmlText == null*/)
                  ? buildProgressDialog(_vm.brandLogoUrl)
                  : _buildWebView(),
            );
          }),
    );
  }

  _buildAppBar() => AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: gradientDecoration,
        ),
        title: Text(
          getTranslatedText("game"),
          style: TextStyle(fontSize: 20.auto),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => _displayDialog(),
        ),
        actions: [
          Container(
            margin: EdgeInsets.all(10.auto),
            alignment: Alignment.center,
            child: IconButton(
              icon: Image.asset("images/ic_refresh.png"),
              onPressed: () {
                _loadWebView();
              },
            ),
          ),
        ],
      );

  _getSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  _buildWebView() {
    var apiUrl = EnvironmentConfig.url + "api/game/bc";
    return /* isHabaPPGamePlatform()
        ? WebviewScaffold(
            url: _getValidUrl(_vm.url!),
            withZoom: false,
            withLocalStorage: true,
            withJavascript: true,
            useWideViewPort: true,
            hidden: true,
          )
        : */
        InAppWebView(
      initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(javaScriptEnabled: true, useShouldOverrideUrlLoading: true),
          android: AndroidInAppWebViewOptions(
            useWideViewPort: true,
            domStorageEnabled: true,
            mixedContentMode: AndroidMixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW,
          ),
          ios: IOSInAppWebViewOptions(allowsInlineMediaPlayback: true)),
      onWebViewCreated: (InAppWebViewController controller) {
        _webViewController = controller;
        _webViewController!.loadUrl(
            urlRequest: widget.gamePlatformCode == "BC"
                ? //bet construct only
                URLRequest(
                    url: Uri.parse(/*widget.gamePlatformCode == "BC" ? apiUrl : */ _getValidUrl(_vm.url!)),
                    headers: {
                        "Authentication": "bearer " + prefs.getString("auth_token")!,
                        "token": prefs.getString("token")!
                      })
                : URLRequest(url: Uri.parse(_getValidUrl(_vm.url!))));
      },
      onExitFullscreen: (InAppWebViewController controller) {
        Navigator.pop(
          context,
        );
      },
      onLoadStart: (controller, url) {},
      onLoadStop: (controller, url) async {},
      shouldOverrideUrlLoading: (controller, navigationAction) async {
        var uri = navigationAction.request.url;
        if (uri == Uri.parse(lobbyUrl!)) {
          showDialog(
            context: context,
            builder: (BuildContext context) => LeaveGameDialog(),
          );
          return NavigationActionPolicy.CANCEL;
        } else {
          return NavigationActionPolicy.ALLOW;
        }
      },
    );
  }

  _getValidUrl(String? url) {
    if (url != null) {
      if ((url.contains("https://") || url.contains("http://"))) {
        return url;
      } else {
        return "https:" + url;
      }
    }
  }

  _displayDialog() {
    // if (isHabaPPGamePlatform()) webviewPlugin.close();
    /*Navigator.pushNamed(context, "home");
    print("111");*/
    showDialog(
      context: context,
      builder: (BuildContext context) => LeaveGameDialog(),
    );
  }

  _loadWebView() {
    isLoading = true;
    if (widget.gameType == null || widget.gameId == 1800001 || widget.gameId == 1800002 || widget.gameId == 1800003)
      _vm.getGameUrl(widget.gamePlatformCode!, widget.gameId!, lobbyUrl!);
    else
      _vm.getLobbyGameUrl(widget.gamePlatformCode!, widget.gameType!, lobbyUrl!);
  }

  isHabaPPGamePlatform() {
    return widget.gamePlatformCode == "PP" || widget.gamePlatformCode == "HABA" || widget.gamePlatformCode == "JILI";
  }

  _handleApiState() {
    handleApiState(_vm.getGameUrlApiState, isAutoHideLoading: false, onSuccess: () {});
    handleApiState(_vm.getLobbyGameUrlApiState, isAutoHideLoading: false, onSuccess: () {});
    handleApiState(_vm.getBetConstructHtmlApiState, isAutoHideLoading: false, onSuccess: () {});
  }
}
