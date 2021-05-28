import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tgp_flutter/custom/custom_dialog.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/localizations/language_provider.dart';
import 'package:tgp_flutter/network/event_result.dart';
import 'package:tgp_flutter/repository/user_repository.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/login/login.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  getTranslatedText(String key) => LanguageProvider().getTranslated(context, key);

  handleApiState(EventResult eventResult,
      {Function onSuccess, Function onError, bool isAutoHideLoading = true, bool isRequireResult = false, bool isCheckSessionExpired = true}) async {
    if (eventResult == null) return;
    if (!eventResult.isHandled) {
      if (eventResult.isError) {
        if (isAutoHideLoading) ProgressDialog.hide();
        if (onError != null) {
          onError(eventResult.error);
        } else {
          if ((eventResult.errorCode == 102 || eventResult.errorCode == 101) && isCheckSessionExpired) {
            UserRepository.getSingleton().clearSession();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) => WillPopScope(
                        onWillPop: () async => false,
                        child: CustomDialog(
                          title: "登录已超时",
                          description: "请再登录",
                          buttonText1: "登录",
                          buttonText2: "不了",
                          onClick: () {
                            Navigator.of(context).pushReplacementNamed("/home");
                            Navigator.of(context).pushNamed("/login");
                          },
                          onClick2: () {
                            Navigator.of(context).pushReplacementNamed("/home");
                          },
                        ),
                      ));
            });
          } else
            _showErrorMessage(eventResult);
        }
      } else if (eventResult.isSuccess) {
        if (isAutoHideLoading) ProgressDialog.hide();
        if (isRequireResult) {
          onSuccess(eventResult.result);
        } else
          onSuccess();
      }
    }
    eventResult.isHandled = true;
  }

  buildProgressDialog() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 100, height: 100, child: Image.asset("images/ic_logo.png")),
            //CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(CustomColor.theme_bar_gradient_2))
            Lottie.asset(
              "loading/loading.json",
              width: 150,
              height: 150,
            ),
          ],
        ),
      );

  _showErrorMessage(EventResult eventResult) {
    var errorMessage = eventResult.error;
    final errorMap = {101: "invalid_credentials",201: "player_not_found", 405: "invalid_otp", 901:"operation_not_allow"};
    final errorKey = errorMap[eventResult.errorCode];
    if (errorKey != null) {
      errorMessage = getTranslatedText(errorKey);
    }
    CustomToast.show(errorMessage);
  }
}
