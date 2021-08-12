import 'package:flutter/material.dart';
import 'package:api/extension/screen_apis.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';

class ColorButton extends StatelessWidget {
  final Widget text;
  final Function onClick;
  final bool isEnabled;
  final Color color;
  final double radius;
  final double width;
  final double height;
  final BorderSide border;
  final MaterialStateProperty<EdgeInsetsGeometry> padding;

  ColorButton(
      {Key key,
      @required this.text,
      @required this.onClick,
      @required this.isEnabled,
      @required this.color,
      @required this.radius,
      this.width,
      this.height,
      this.border,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: isEnabled ? () => {this.onClick()} : null,
        style: ButtonStyle(
            padding: padding ?? MaterialStateProperty.all(EdgeInsets.all(8)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular((radius).auto),
              side: border ?? BorderSide(color: Colors.transparent),
            )),
            backgroundColor: MaterialStateProperty.all(isEnabled ? color : Colors.grey),
            minimumSize: MaterialStateProperty.all(Size(width ?? context.screenWidth, height ?? 45.auto))),
        child: text);
  }
}
