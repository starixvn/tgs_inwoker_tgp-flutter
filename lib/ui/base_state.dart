import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tgp_flutter/custom/custom_dialog.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/entity/language.dart';
import 'package:tgp_flutter/environment_config.dart';
import 'package:tgp_flutter/localizations/language_provider.dart';
import 'package:tgp_flutter/network/event_result.dart';
import 'package:tgp_flutter/repository/user_repository.dart';
import 'package:tgp_flutter/route_path.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/login/login.dart';
import 'package:html/parser.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/ui/maintenance/maintenance.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  final userRepo = UserRepository.getSingleton();

  get apiError => userRepo.apiError;

  getTranslatedText(String? key) => LanguageProvider().getTranslated(context, key);

  handleApiState(
    EventResult? eventResult, {
    required Function onSuccess,
    Function? onError,
    bool isAutoHideLoading = true,
    bool isRequireResult = false,
    bool isCheckSessionExpired = true,
    bool isSplashScreen = false,
    Function? onLogout,
    int? maintenanceAction,
  }) async {
    if (eventResult == null) return;
    if (!eventResult.isHandled) {
      if (onLogout != null) {
        //force user to logout even api return error or maintenance
        onLogout();
      } else if (eventResult.isError) {
        if (isAutoHideLoading) ProgressDialog.hide();
        if (eventResult.errorCode == 210) {
          UserRepository.getSingleton().clearSession();
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            Navigator.of(context).pushNamedAndRemoveUntil(RoutePath.empty, (Route<dynamic> route) => false);
            Navigator.of(context).pushNamed(RoutePath.blacklistedUser);
          });
        } else if (eventResult.errorMsgId != null) {
          if (eventResult.errorMsgId == 'UnderMaintenance') {
            _getMaintenanceAction(maintenanceAction ?? 0);
          } else if (onError != null) {
            onError(eventResult.error);
          } else
            showApiErrorMessage(eventResult);
        } else {
          _showErrorMessage(eventResult);
        }
      } else if (eventResult.isMaintenance) {
        _getMaintenanceAction(maintenanceAction ?? 0);
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

  _getMaintenanceAction(int index) {
    switch (index) {
      case 0:
        //push maintenance page
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          Navigator.of(context).pushReplacementNamed(RoutePath.maintenance);
          Navigator.of(context).popAndPushNamed(RoutePath.maintenance);
        });
        break;
      case 1:
        //remove all routes
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => Maintenance(
                        isShowCS: true,
                        isShowsAppBar: false,
                      )),
              (Route<dynamic> route) => false);
        });
        break;
      case 2:
        //pop dialog
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          showDialog(
            context: context,
            builder: (BuildContext context) => CustomDialog(
              description: "维护中：该终公司/公司。平台/游戏商/游戏正在维护中。",
              buttonText1: getTranslatedText("confirm"),
              onClick: () {
                Navigator.of(context).pop();
              },
            ),
          );
        });
        break;
      default:
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          Navigator.of(context).pushReplacementNamed(RoutePath.maintenance);
          Navigator.of(context).popAndPushNamed(RoutePath.maintenance);
        });
        break;
    }
  }

  buildProgressDialog(String? url) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            url == null
                ? Container()
                : CachedNetworkImage(
                    placeholder: (context, url) => Container(),
                    imageUrl: url,
                    //handling error
                    width: 200.auto,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Container(),
                  ),
            //: Container(),
            //Container(width: 100, height: 100, child: Image.asset("images/login/${EnvironmentConfig.imageLogo}.png")),
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
    final errorMap = {
      101: "invalid_credentials",
      201: "player_not_found",
      206: "invalid_invitation_code",
      207: "turnover_required",
      208: "transfer_failed",
      209: "transfer_failed",
      401: "enter_username_error_message",
      405: "invalid_otp",
      407: "failed_participate_promotion",
      900: "request_failed",
      901: "operation_not_allow"
    };
    final errorKey = errorMap[eventResult.errorCode];
    if (errorKey != null) {
      errorMessage = getTranslatedText(errorKey);
    }
    CustomToast.show(errorMessage!);
  }

  showApiErrorMessage(EventResult eventResult) {
    if (userRepo.apiError != null) {
      String error = userRepo.apiError![eventResult.errorMsgId] ?? "";
      CustomToast.show(error);
    }
  }

  String? parseHtmlString(String? htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body?.text).documentElement!.text;
    return parsedString;
  }

  getCurrentLanguage() {
    var list = LanguageProvider().list;
    Language? deviceLanguage;
    if (list.length == 1) {
      return list.first;
    } else {
      deviceLanguage = list.singleWhere((e) => e.locale == Localizations.localeOf(context));
      return deviceLanguage;
    }
  }
}
