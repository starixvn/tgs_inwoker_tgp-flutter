import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:tgp_flutter/custom/color_button.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/environment_config.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/main.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/home/home.dart';
import 'package:tgp_flutter/ui/splash/splash_view_model.dart';

class Splash extends StatefulWidget {
  final String logoUrl;

  Splash({this.logoUrl});

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends BaseState<Splash> {
  var _vm = SplashViewModel();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _vm.getAuthToken();
      _vm.getApiError();
      _vm.getBrandLogo();
      _vm.getLanguageOption();
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return ProviderWidget<SplashViewModel>(
        model: _vm,
        builder: (ctx, vm, _) {
          _handleApiState();
          return Container(
            width: context.screenWidth,
            height: context.screenHeight,
            color: Colors.black,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Container(width: context.screenWidth / 1.5, child: Image.asset("images/login/${EnvironmentConfig.imageLogo}.png")),
                  widget.logoUrl?.isEmpty ?? true
                      ? Container()
                      : CachedNetworkImage(
                          placeholder: (context, url) => Container(),
                          imageUrl: widget.logoUrl,
                          //handling error
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => Container(),
                        ),
                  Container(
                    width: context.screenWidth / 2.5,
                    alignment: Alignment.bottomCenter,
                    child: Lottie.asset("loading/loading.json"),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _handleApiState() {
    handleApiState(_vm.getLanguageApiState, isAutoHideLoading: false, isSplashScreen: true, onSuccess: () {
      _navigateToHome();
    });
    handleApiState(_vm.getBrandLogoApiState, isAutoHideLoading: false, isSplashScreen: true, onSuccess: () {});
    handleApiState(_vm.authApiState, isAutoHideLoading: false, isSplashScreen: true, onSuccess: () {});
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
