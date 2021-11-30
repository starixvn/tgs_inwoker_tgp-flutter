import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/color_button.dart';
import 'package:tgp_flutter/custom/outline_border_button.dart';

import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';

class CustomDialog extends StatelessWidget {
  final String? title;
  final String description;
  final String buttonText1;
  final String? buttonText2;
  final Function onClick;
  final Function? onClick2;

  CustomDialog({
    this.title,
    required this.description,
    required this.buttonText1,
    this.buttonText2,
    required this.onClick,
    this.onClick2,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: context.screenHeight / 30,
            horizontal: context.screenWidth / 20,
          ),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              title == null
                  ? Container()
                  : Container(
                      padding: EdgeInsets.only(bottom: 13.auto, left: 10.auto),
                      alignment: Alignment.topLeft,
                      child: Text(
                        title!,
                        style: TextStyle(
                          fontSize: 18.auto,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
              Container(
                width: context.screenWidth,
                padding: EdgeInsets.only(bottom: 20.auto, left: 10.auto, right: 10.auto),
                child: AutoSizeText(
                  description,
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                  textAlign: title == null ? TextAlign.center : TextAlign.start,
                  minFontSize: 5,
                  maxFontSize: 13,
                  stepGranularity: 1,
                ),
              ),
              buttonText2 == null
                  ? _buildDoneButton(context)
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(flex: 1, child: _buildDoneButton(context)),
                        Expanded(flex: 1, child: _buildBackButton(context))
                      ],
                    )
            ],
          ),
        ),
      ],
    );
  }

  _buildDoneButton(BuildContext context) => ColorButton(
        onClick: () => this.onClick(),
        text: AutoSizeText(
          buttonText1,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
          minFontSize: 5,
          maxFontSize: 13,
          stepGranularity: 1,
        ),
        isEnabled: true,
        radius: 45.auto,
        width: context.screenWidth / 3.5,
        height: context.screenHeight / 18,
        color: CustomColor.theme_bar_gradient_2,
      );

  _buildBackButton(BuildContext context) => Container(
        margin: EdgeInsets.only(left: 10.auto),
        child: OutlineBorderButton(
          onClick: () => this.onClick2!(),
          title: buttonText2!,
          isEnabled: true,
          width: context.screenWidth / 3.5,
          height: context.screenHeight / 18,
          fontSize: 13.auto,
          color: Colors.white,
        ),
      );
}
