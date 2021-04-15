import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/color_button.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_tab_bar.dart';
import 'package:tgp_flutter/custom/custom_text_form_field.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/custom/otp_text_form_field.dart';
import 'package:tgp_flutter/custom/outline_border_button.dart';
import 'package:tgp_flutter/data/provider/input_validation_provider.dart';
import 'package:tgp_flutter/entity/event_type.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/forgot_password/forgot_password_view_model.dart';
import 'package:tgp_flutter/ui/forgot_password/update_forgot_password.dart';
import 'package:tgp_flutter/ui/profile_info/phone/phone_verification_view_model.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';

class ForgotPassword extends StatefulWidget{
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends BaseState<ForgotPassword> {
  var _vm = ForgotPasswordViewModel();
  TextEditingController _phoneController = TextEditingController(),
      _otpController = TextEditingController();
  var isButtonEnabled = false, isOtpEnabled = false;
  InputValidationProvider validate = new InputValidationProvider();

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return ProviderWidget<ForgotPasswordViewModel>(
        model: _vm,
        builder: (ctx, vm, _) {
          _handleApiState();
          return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                flexibleSpace: Container(
                  decoration: gradientDecoration,
                ),
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text(getTranslatedText("forgot_password"),
                  style: TextStyle(fontSize: 16.auto),
                ),
              ),
              body: Container(
                  child: /*userProfile == null?
                  Center(child: CircularProgressIndicator(),):*/
                  Container(
                    margin: EdgeInsets.only(
                        left: 10.auto, right: 10.auto, top: 10.auto),
                    child: Column(
                      children: [
                        //CustomTabBar(index:1),
                        _buildTextFormField(),
                        _buildOtpTextFormField(),
                        _buildButton()
                      ],
                    ),
                  )
              )
          );
        });
  }

  _buildTextFormField()=>  Container(
    margin: EdgeInsets.only(top: 15.auto),
    child: CustomTextFormField(
      title: getTranslatedText("phone_number"),
      hintText: getTranslatedText("enter_phone_hint"),
      onChanged: (value) => _onTextChange(),
      onFieldSubmitted: (value){},
      controller: _phoneController,
      focusNode: null,
      width: context.screenWidth-70.auto,
      textInputType: TextInputType.number,
      textInputAction: TextInputAction.next,
    ),
  );

  _buildOtpTextFormField() =>  Opacity(
    opacity: isOtpEnabled?1:0.3,
    child: Container(
      margin: EdgeInsets.only(top: 15.auto),
      child: OtpTextFormField(
        hintText: getTranslatedText("enter_phone_otp_hint"),
        onChanged:(value) => _onTextChange(),
        controller: _otpController,
        textInputAction: TextInputAction.done,
        getOtpCode:() {
          _getSmsCode();
        },
      ),
    ),
  );

  _buildButton() => Container(
      width: context.screenWidth,
      margin: EdgeInsets.only(top: 30.auto, bottom: 20.auto),
      child: ColorButton(
        text: Text(
          getTranslatedText("next"),
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: 16.auto
          ),
        ),
        onClick: (){
          _navigateToUpdatePassword();
        },
        isEnabled: isButtonEnabled??false,
        color: CustomColor.theme_bar_gradient_2,
        radius: 9.6 ,
      )
  );

  _onTextChange(){
    setState(() {
      if(_otpController.text.isNotEmpty && _phoneController.text.isNotEmpty){
        isButtonEnabled = true;
      }else if(_phoneController.text.isNotEmpty){
        isOtpEnabled = true;
      }
      else{
        isOtpEnabled = false;
        isButtonEnabled = false;
      }
    });
  }

  _getSmsCode() {
    if (!validate.validateChinaPhoneNumber(_phoneController.text)) {
      setState(() {
        CustomToast.show("手机号码格式不正确");
      });
    } else {
      CustomProgressDialog.show(context);
      _vm.getForgotPasswordCode(_phoneController.text);
    }
  }

  _handleApiState(){
    handleApiState(_vm.getForgotPasswordCodeApiState, onSuccess: (){

    });
  }

  _navigateToUpdatePassword(){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                UpdateForgotPassword(
                  code: _otpController.text,
                  securityKey: _vm.securityKey
                )
        ));
  }
}

