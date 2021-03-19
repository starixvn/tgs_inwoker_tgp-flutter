import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

ProgressDialog _progressDialog;

class CustomProgressDialog{

  CustomProgressDialog.show(BuildContext context){
    create(context);
    _progressDialog.show();
  }

  CustomProgressDialog.hide(){
    _progressDialog.hide();
  }

  create(BuildContext context){
    _progressDialog = ProgressDialog(context,isDismissible: false);
    _progressDialog.style(
      message: 'Loading...',
      borderRadius: 10.0,
      backgroundColor: Colors.transparent,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.auto, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.white, fontSize: 19.auto, fontWeight: FontWeight.w600),
    );
  }
}