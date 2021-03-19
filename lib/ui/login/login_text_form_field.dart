import 'package:flutter/material.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/custom_color.dart';

class LoginTextFormField extends StatefulWidget{
  final Widget icon;
  final String hintText;
  final ValueChanged<String> onFieldSubmitted;
  final ValueChanged<String> onChanged;
  final Function onShowPassword;
  final TextEditingController controller;
  final double width;
  final Widget button;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final bool obscurePassword;

  LoginTextFormField({Key key,
    this.icon,
    this.hintText,
    this.onChanged,
    this.onFieldSubmitted,
    this.onShowPassword,
    this.controller,
    this.width,
    this.button,
    this.textInputType,
    this.textInputAction,
    this.obscurePassword,
  }) : super(key: key);

  @override
  _LoginTextFormFieldState createState() => _LoginTextFormFieldState();
}

class _LoginTextFormFieldState extends State<LoginTextFormField> {
  Widget build(BuildContext context) {
    return Container(
      height: 40.auto,
      padding: EdgeInsets.symmetric(horizontal: 10.auto, vertical: 5.auto),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: CustomColor.very_light_pink_two,
              width: 2
          )
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 5.auto),
            child: widget.icon,
          ),
          Container(
            width: 255.auto,
            child: TextFormField(
              autofocus: false,
              onChanged: (value) => widget.onChanged(value),
              controller: widget.controller,
              onFieldSubmitted: (value) => widget.onChanged(value),
              keyboardType: widget.textInputType,
              textInputAction: widget.textInputAction,
              obscureText: widget.obscurePassword ?? false,
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
                    fontSize: 10.auto
                ),
                suffixIcon: widget.textInputType == TextInputType.visiblePassword
                    ? IconButton(
                  iconSize: 18.auto,
                  padding: EdgeInsets.only(bottom: 0),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: Icon(
                      widget.obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: CustomColor.very_light_pink_two
                  ),
                  onPressed:()=> widget.onShowPassword(),
                ):Container(
                  width: 0,
                  height: 0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}