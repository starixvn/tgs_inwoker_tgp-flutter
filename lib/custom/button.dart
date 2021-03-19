import 'package:flutter/material.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';

class Button extends StatelessWidget {
  final String title;
  final Function onClick;
  final bool isEnabled;
  final bool isGrey;

  Button({Key key,
    this.title,
    this.onClick,
    this.isEnabled,
    this.isGrey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.auto,
      width: context.screenWidth,
      child:isEnabled?RaisedButton(
        onPressed: () => {
          this.onClick()
        },
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: isGrey?BoxDecoration(
            color: CustomColor.theme_button_disable_bg
          ):gradientDecoration,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                fontSize: 16.auto
              ),
            ),
          ),
        ),
      ):RaisedButton(
        onPressed: null,
        color: Colors.black,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(45)),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white),
        ),
      ),
    );
  }
}