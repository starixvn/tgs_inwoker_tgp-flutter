import 'package:flutter/material.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';

class ColorButton extends StatelessWidget {
  final Widget text;
  final Function onClick;
  final bool isEnabled;
  final Color color;
  final double radius;
  final double width;
  final BorderSide border;
  final MaterialStateProperty<EdgeInsetsGeometry> padding;

  ColorButton({Key key,
    @required this.text,
    @required this.onClick,
    @required this.isEnabled,
    @required this.color,
    @required this.radius,
    this.width,
    this.border,
    this.padding
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isEnabled ? TextButton(
      onPressed: () => {
        this.onClick()
      },
      style: ButtonStyle(
        padding: padding?? MaterialStateProperty.all(EdgeInsets.all(8)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular((radius).auto),
              side: border??BorderSide(
                  color: Colors.transparent
              ),
            )
        ),
        backgroundColor: MaterialStateProperty.all(
            color
        ),
      ),
      child: Container(
          alignment: Alignment.center,
          width: width??context.screenWidth,
          height: 20.auto,
          child: text
      ),
    ) :TextButton(
        onPressed: null,
        style:ButtonStyle(
          //padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular((radius).auto),
              )
          ),
          backgroundColor: MaterialStateProperty.all(
             Colors.grey
          ),
        ),
        child: text
    );
  }
}