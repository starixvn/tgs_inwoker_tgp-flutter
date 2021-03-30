import 'package:flutter/material.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/base_state.dart';

class CustomTextFormField extends StatefulWidget{
  final String title;
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
    this.title,
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

class _CustomTextFormFieldState extends BaseState<CustomTextFormField> {
  Widget build(BuildContext context) {
    return Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 5,
        //margin:EdgeInsets.only(top:15.auto,),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child:  Row(
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: widget.width,
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.title,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 9.auto
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      width: widget.width,
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
                    ),
                  ]
              ),
              widget.button==null?Container():widget.button
            ],
          ),
        )
    );
  }
}