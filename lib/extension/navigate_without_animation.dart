import 'package:flutter/material.dart';

class NavigateWithoutAnimation extends PageRouteBuilder {
  final Widget widget;

  NavigateWithoutAnimation({this.widget})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionDuration: Duration(seconds: 5),
        );
}
