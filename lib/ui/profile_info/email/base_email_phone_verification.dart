import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/color_button.dart';
import 'package:tgp_flutter/custom/custom_text_form_field.dart';
import 'package:tgp_flutter/custom/otp_text_form_field.dart';
import 'package:tgp_flutter/custom/outline_border_button.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/ui/base_state.dart';

class BaseEmailPhoneVerification extends StatefulWidget{
  final String inputText, hintText, footerText1, footerText2, navigatePath;
  final bool isEmail, isVerified, isInputCodeVisible;
  final Function getSmsCode, onClick;
  final inputController, otpController;

  BaseEmailPhoneVerification({
    this.inputText,
    this.hintText,
    this.footerText1,
    this.footerText2,
    this.navigatePath,
    this.isEmail,
    this.isVerified,
    this.isInputCodeVisible,
    this.getSmsCode,
    this.onClick,
    this.inputController,
    this.otpController
  });

  @override
  _BaseEmailPhoneVerificationState createState() => _BaseEmailPhoneVerificationState();
}

class _BaseEmailPhoneVerificationState extends BaseState<BaseEmailPhoneVerification> {
  bool isButtonEnabled = false;

  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(top: 15.auto),
            child: _buildTextFormField(
                widget.inputText,
                widget.hintText,
                widget.inputController,
                false
            )
        ),
        Visibility(
          visible: widget.isVerified,
          child: Opacity(
            opacity: widget.isInputCodeVisible? 1:0.5,
            child: OtpTextFormField(
                hintText: "请输入邮箱验证码",
                onChanged:(value) => _onTextChange(),
                controller: widget.otpController,
                textInputAction: TextInputAction.done,
                getOtpCode:() {
                  widget.getSmsCode();
                },
            )
          ),
        ),
        _buildButton(),
        _buildFooterText()
      ],
    );
  }

  _buildTextFormField(String title, String hint, TextEditingController controller, bool isLast) => CustomTextFormField(
    title: title,
    hintText: hint,
    onChanged: (value) => _onTextChange(),
    onFieldSubmitted: (value){},
    controller: controller,
    focusNode: null,
    width: context.screenWidth-70.auto,
    textInputType: TextInputType.number,
    textInputAction: isLast?TextInputAction.done:TextInputAction.next,
  );

  _buildButton()=> Container(
      padding:  EdgeInsets.only(top: 50.auto,bottom: 20.auto),
      child: ColorButton(
        text: Text(
          widget.isVerified?"已验证":"下一步",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: 16.auto
          ),
        ),
        onClick: widget.isVerified?null:(){
          widget.onClick();
        },
        isEnabled: isButtonEnabled,
        color: CustomColor.theme_bar_gradient_2,
        radius: 9.6 ,
      )
  );

  _buildFooterText()=> Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        widget.footerText1,
        style: TextStyle(
            fontSize: 12.auto,
            color: CustomColor.theme_title_text_color
        ),
      ),
      InkWell(
        onTap: widget.isVerified?(){
          Navigator.of(context).pushNamed("/${widget.navigatePath}");
        }:(){
          //customer service
        },
        child: Text(
          widget.footerText2,
          style: TextStyle(
              fontSize: 12.auto,
              color: CustomColor.theme_bar_gradient_2
          ),
        ),
      )
    ],
  );


  _onTextChange(){
    if(widget.inputController.text.isNotEmpty && widget.otpController.text.isNotEmpty){
      setState(() {
        isButtonEnabled = true;
      });
    }
    else{
      setState(() {
        isButtonEnabled = false;
      });
    }
  }
}


