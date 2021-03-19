import 'package:flutter/material.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/custom_color.dart';

class CustomTextFormField extends StatefulWidget{
  final Icon icon;
  final String hintText;
  final ValueChanged<String> onFieldSubmitted;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final FocusNode focusNode;
  final double width;
  final Widget button;
  final TextInputType textInputType;
  final TextInputAction textInputAction;

  CustomTextFormField({Key key,
    this.icon,
    this.hintText,
    this.onChanged,
    this.onFieldSubmitted,
    this.controller,
    this.focusNode,
    this.width,
    this.button,
    this.textInputType,
    this.textInputAction,
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          widget.icon,
          Container(
            width: 100.auto,
            child: TextFormField(
              autofocus: false,
              onChanged: (value) => widget.onChanged(value),
              focusNode: widget.focusNode,
              controller: widget.controller,
              onFieldSubmitted: (value) => widget.onChanged(value),
              keyboardType: widget.textInputType,
              textInputAction: widget.textInputAction,
              obscureText: (widget.textInputType == TextInputType.visiblePassword)? true: false,
              style: TextStyle(
                  color: CustomColor.theme_value_text_color,
                  fontSize: 13.auto
              ),
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: TextStyle(
                    color: CustomColor.very_light_pink_two,
                    fontSize: 13.auto
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}