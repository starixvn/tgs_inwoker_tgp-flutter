import 'package:ndialog/ndialog.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:flutter/material.dart';
import 'package:tgp_flutter/src/custom_color.dart';
//import 'package:progress_dialog/progress_dialog.dart';

CustomProgressDialog _progressDialog;

class ProgressDialog {
  ProgressDialog.show(BuildContext context) {
    create(context);
    _progressDialog.show();
  }

  ProgressDialog.hide() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _progressDialog.dismiss();
    });
  }

  create(BuildContext context) {
    _progressDialog = CustomProgressDialog(context, blur: 2, dismissable: false);
    _progressDialog.setLoadingWidget(Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width: 100, height: 100, child: Image.asset("images/ic_logo.png")),
        CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(CustomColor.theme_bar_gradient_2))
      ],
    ));
  }
}
