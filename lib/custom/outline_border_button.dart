import 'package:flutter/material.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/custom_color.dart';

class OutlineBorderButton extends StatelessWidget {
  final String title;
  final Function onClick;
  final bool isEnabled;
  final double width;
  final Color color;
  final double fontSize;

  OutlineBorderButton({Key key,
    this.title,
    this.onClick,
    this.isEnabled,
    this.width,
    this.color,
    this.fontSize
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: width,
      height: 30,
      child: OutlineButton(
        onPressed: () {
          this.onClick();
        },
        borderSide: BorderSide(
            color: color,
            width: 0.5
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: fontSize
          ),
        ),
      ),
    );
  }
}