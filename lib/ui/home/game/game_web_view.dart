import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/custom_dialog.dart';
import 'package:tgp_flutter/entity/game.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/home/game/game_view_model.dart';
//import 'package:webview_flutter/webview_flutter.dart';

class GameWeb extends StatefulWidget{
  final Game game;

  GameWeb({Key key,
    this.game,
  }) : super(key: key);

  @override
  _GameWebState createState() => _GameWebState();
}

class _GameWebState extends BaseState<GameWeb> {
  var _vm = GameViewModel();
  InAppWebViewController _webViewController;
  String url = "";
  String initialUrl;
  var isLoading = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _vm.getGameUrl(widget.game.gamePlatformCode, widget.game.id);
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return ProviderWidget<GameViewModel>(
        model: _vm,
        builder: (ctx, vm, _) {
          _handleApiState();
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              flexibleSpace: Container(
                decoration: gradientDecoration,
              ),
              title: Text(
                widget.game.name ?? "",
                style: TextStyle(fontSize: 20.auto),),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => _displayDialog(),
              ),
              actions: [
                Container(
                  margin: EdgeInsets.all(10.auto),
                  alignment: Alignment.center,
                  child:IconButton(
                    icon: Image.asset("images/ic_refresh.png"),
                    onPressed: () {
                      _loadWebView();
                    },
                  ),
                ),
              ],
            ),
            body: isLoading || _vm.url == null
                ? Center(child: CircularProgressIndicator())
                : _buildWebView(),
          );
        });
  }

  _buildWebView(){
    return InAppWebView(
      initialUrl: _getValidUrl(),
      initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            debuggingEnabled: true,
            javaScriptEnabled: true,
          ),
          android: AndroidInAppWebViewOptions(
            useWideViewPort: true,
            mixedContentMode: AndroidMixedContentMode
                .MIXED_CONTENT_ALWAYS_ALLOW,
          )
      ),
      onWebViewCreated: (InAppWebViewController controller) {
        _webViewController = controller;
        _webViewController.loadUrl(url: _getValidUrl());
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
    );
  }

  _getValidUrl(){
    if(_vm.url!=null) {
      if(_vm.url.contains("https://") || _vm.url.contains("http://")){
        return _vm.url;
      }
      else{
        return "https:"+_vm.url;
      }
    }
  }

  _displayDialog(){
    showDialog(context: context,
      builder: (BuildContext context) => CustomDialog(
        description: "确定离开游戏吗？",
        buttonText1: "离开",
        buttonText2: "再玩一会",
        onClick: ()=> Navigator.of(context).popUntil(ModalRoute.withName('/home')),
      ),
    );
  }

  _loadWebView(){
    isLoading = true;
    _vm.getGameUrl(widget.game.gamePlatformCode, widget.game.id);
  }

  _handleApiState(){
    handleApiState(_vm.getGameUrlApiState, isAutoHideLoading: false, onSuccess: (){
      if(isLoading){
          isLoading=!isLoading;
      }
    });
  }
}