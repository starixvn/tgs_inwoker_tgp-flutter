import 'package:flutter/material.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';

class CustomToast{

  CustomToast.show(String errorMsg) {
    Fluttertoast.showToast(
        msg: errorMsg,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        fontSize: 13.auto,
        textColor: Colors.white
    );
  }
}