import 'package:flutter/material.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/base_state.dart';

import 'outline_border_button.dart';

class OtpTextFormField extends StatefulWidget{
  final String hintText;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final Function getOtpCode;
  final bool isEnabled;

  OtpTextFormField({Key key,
    this.hintText,
    this.onChanged,
    this.controller,
    this.textInputAction,
    this.getOtpCode,
    this.isEnabled
  }) : super(key: key);

  @override
  _OtpTextFormFieldState createState() => _OtpTextFormFieldState();
}

class _OtpTextFormFieldState extends BaseState<OtpTextFormField> {
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
                      width: context.screenWidth-145.auto,
                      alignment: Alignment.topLeft,
                      child: Text(
                        getTranslatedText("otp"),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 9.auto
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      width:context.screenWidth-145.auto,
                      child: TextFormField(
                        autofocus: false,
                        onChanged: (value) => widget.onChanged(value),
                        controller: widget.controller,
                        keyboardType: TextInputType.text,
                        textInputAction: widget.textInputAction,
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
                        enabled: widget.isEnabled,
                      ),
                    ),
                  ]
              ),
              OutlineBorderButton(
                  title: getTranslatedText("request_otp"),
                  onClick: ()=> widget.getOtpCode(),
                  isEnabled:true,
                  width: 60.auto,
                  color:CustomColor.theme_bar_gradient_2,
                  fontSize:10.auto
                //fontSize: 11.auto,
              )
            ],
          ),
        )
    );
  }
}