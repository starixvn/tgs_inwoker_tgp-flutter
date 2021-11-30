import 'package:flutter/material.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/base_state.dart';

class LoginTextFormField extends StatefulWidget {
  final Widget? icon;
  final String hintText;
  final ValueChanged<String?>? onChanged;
  final ValueChanged<String?>? onFieldSubmitted;
  final TextEditingController controller;
  final double width;
  final TextInputType textInputType;
  final TextInputAction textInputAction;

  LoginTextFormField({
    this.icon,
    required this.hintText,
    this.onChanged,
    required this.controller,
    required this.width,
    required this.textInputType,
    required this.textInputAction,
    this.onFieldSubmitted,
  });

  @override
  _LoginTextFormFieldState createState() => _LoginTextFormFieldState();
}

class _LoginTextFormFieldState extends BaseState<LoginTextFormField> {
  Widget build(BuildContext context) {
    return Container(
      height: 40.auto,
      padding: EdgeInsets.symmetric(horizontal: 10.auto),
      decoration:
          BoxDecoration(color: Colors.white, border: Border.all(color: CustomColor.very_light_pink_two, width: 2)),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10.auto),
            child: widget.icon,
          ),
          Expanded(
            child: TextFormField(
              autofocus: false,
              onChanged: (value) => widget.onChanged!(value),
              controller: widget.controller,
              onFieldSubmitted: (value) => widget.onChanged!(value),
              keyboardType: widget.textInputType,
              textInputAction: widget.textInputAction,
              style: TextStyle(color: CustomColor.theme_value_text_color, fontSize: 13.auto),
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: TextStyle(color: CustomColor.very_light_pink_two, fontSize: 13.auto),
              ),
            ),
          )
        ],
      ),
    );
  }
}
