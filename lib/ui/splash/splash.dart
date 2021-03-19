import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/splash/splash_view_model.dart';


class Splash extends StatefulWidget{
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  var _vm = SplashViewModel();

  @override
  void initState() {
    _vm.getAuthToken();
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: context.screenWidth / 1.5,
                        child: Image.asset("images/ic_logo.png")
                    ),
                    Container(
                      margin: EdgeInsets.all(10.auto),
                      alignment: Alignment.bottomCenter,
                      child: CircularProgressIndicator(

                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
    );
  }

  _handleApiState() {
    if (_vm.authApiState == null) return;
    if ((_vm.authApiState?.isError ?? false)) {
      CustomToast.show(_vm.authApiState.error);
    }
    if (_vm.authApiState.isSuccess) {
      _navigateToHome();
    }
  }

  _navigateToHome() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          "/home", (Route<dynamic> route) => false);
    });
  }
}







