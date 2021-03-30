import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/localizations/language_provider.dart';
import 'package:tgp_flutter/network/event_result.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  getTranslatedText(String key) =>
      LanguageProvider().getTranslated(context, key);

  handleApiState(EventResult eventResult,{ Function onSuccess,
      Function onError, bool isAutoHideLoading = true, bool isRequireResult = false}) {
    if (eventResult == null) return;
    if (!eventResult.isHandled) {
      if (eventResult.isError) {
        if (isAutoHideLoading) CustomProgressDialog.hide();
        if (onError != null) {
          onError(eventResult.error);
        } else {
          CustomToast.show(eventResult.error);
        }
      } else if (eventResult.isSuccess) {
        if (isAutoHideLoading) CustomProgressDialog.hide();
        if(isRequireResult){
          onSuccess(eventResult.result);
        }
        else onSuccess();
      }
    }
    eventResult.isHandled = true;
  }
}