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

  GradientButton({Key key,
    @required this.title,
    @required this.onClick,
    @required this.isEnabled,
    @required this.radius,
    @required this.height,
    this.fontSize

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isEnabled ? TextButton(
      onPressed: () => this.onClick(),
        child: Container(
          alignment: Alignment.center,
          height: height.auto,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  CustomColor.theme_bar_gradient_1,
                  CustomColor.theme_bar_gradient_2
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            borderRadius: BorderRadius.circular((radius).auto),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.auto),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: fontSize??16.auto
            ),
          ),

      ),
    ) :TextButton(
      onPressed: null,
      style:ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular((radius).auto),
            )
        ),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white),
      ),
    );
  }
}