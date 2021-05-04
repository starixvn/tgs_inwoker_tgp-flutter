import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:tgp_flutter/custom/color_button.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/main.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/home/home.dart';
import 'package:tgp_flutter/ui/splash/splash_view_model.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends BaseState<Splash> {
  var _vm = SplashViewModel();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _vm.getAuthToken();
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return ProviderWidget<SplashViewModel>(
        model: _vm,
        builder: (ctx, vm, _) {
          _handleApiState();
          return Scaffold(
              resizeToAvoidBottomInset: false,
              body: Container(
                width: context.screenWidth,
                height: context.screenHeight,
                color: Colors.black,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(width: context.screenWidth / 1.5, child: Image.asset("images/ic_logo.png")),
                      Container(
                        width: context.screenWidth / 2.5,
                        alignment: Alignment.bottomCenter,
                        child: Lottie.asset("loading/loading.json"),
                      ),
                    ],
                  ),
                ),
              ));
        });
  }

  _handleApiState() {
    handleApiState(_vm.authApiState, onSuccess: () {
      _navigateToHome();
    }, isAutoHideLoading: false, onError: (_) {});
  }

  _navigateToHome() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => MyHomePage(
                    isFirstRun: true,
                  )),
          (Route<dynamic> route) => false);
    });
  }
}
