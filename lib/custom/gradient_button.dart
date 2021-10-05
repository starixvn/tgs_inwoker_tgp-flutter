import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';

class GradientButton extends StatelessWidget {
  final String title;
  final Function onClick;
  final bool isEnabled;
  final double radius;
  final double height;
  final double fontSize;
  final double width;
  final double padding;

  GradientButton(
      {Key key,
      @required this.title,
      @required this.onClick,
      @required this.isEnabled,
      @required this.radius,
      @required this.height,
      this.fontSize,
        this.width,
        this.padding
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isEnabled
        ? TextButton(
            onPressed: () => this.onClick(),
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.all(0)),
            ),
            child: Container(
              alignment: Alignment.center,
              height: height.auto,
              width: width??context.screenWidth,
              padding: EdgeInsets.all(padding??0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [CustomColor.theme_bar_gradient_1, CustomColor.theme_bar_gradient_2],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                borderRadius: BorderRadius.circular((radius).auto),
              ),
              child: AutoSizeText(
                title,
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
                minFontSize: fontSize ?? 16.auto,
                stepGranularity: 1,
              ),
            ),
          )
        : TextButton(
            onPressed: null,
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular((radius).auto),
              )),
              backgroundColor: MaterialStateProperty.all(Colors.grey),
            ),
            child: Container(
              alignment: Alignment.center,
              height: height.auto,
              width: width??context.screenWidth,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
  }
}
