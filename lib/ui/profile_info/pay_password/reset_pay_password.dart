import 'dart:ui';

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
import 'package:tgp_flutter/ui/profile_info/email/email_verification_view_model.dart';
import 'package:tgp_flutter/ui/profile_info/pay_password/pay_password_view_model.dart';
import 'package:tgp_flutter/ui/profile_info/phone/phone_verification_view_model.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';

class ResetPayPassword extends StatefulWidget{
  @override
  _ResetPayPasswordState createState() => _ResetPayPasswordState();
}

class _ResetPayPasswordState  extends BaseState<ResetPayPassword> {
  var _vm = PayPasswordViewModel();
  TextEditingController _payPasswordController = TextEditingController(),
      _confirmPayPasswordController = TextEditingController(),
      _phoneController = TextEditingController(),
      _otpController = TextEditingController();
  var phoneText;
  var isButtonEnabled = false, isResetPassword = false,  isCodeVisible = false, isOtpEnabled = false;
  var name, cardNumber, buttonText;
  var userProfile;
  InputValidationProvider validate = new InputValidationProvider();


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
      });
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return ProviderWidget<PayPasswordViewModel>(
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
                title: Text(getTranslatedText("reset_pay_password"),
                  style: TextStyle(fontSize: 16.auto),
                ),
              ),
              body: Container(
                  padding: EdgeInsets.only(top: 10.auto, left: 10.auto, right: 10.auto),
                  child: Column(
                    children: [
                      _buildTextFormField("new_pay_password", "enter_new_pay_password", _payPasswordController, false),
                      _buildTextFormField("confirm_pay_password", "confirm_pay_password_hint", _confirmPayPasswordController, false),
                      _buildTextFormField("phone_number", "enter_phone_hint", _phoneController, false),
                      _buildOtpTextFormField(),
                      _buildButton()
                    ],
                  )
              )
          );
        });
  }

  _buildTextFormField(String title, String hint, TextEditingController controller, bool isLast)=> Container(
    margin: EdgeInsets.only(top: 15.auto),
    child: CustomTextFormField(
      title: getTranslatedText(title),
      hintText: getTranslatedText(hint),
      onChanged: (value) => _onTextChange(),
      onFieldSubmitted: (value){},
      controller: controller,
      focusNode: null,
      width: context.screenWidth-70.auto,
      textInputType: TextInputType.number,
      textInputAction: isLast?TextInputAction.done:TextInputAction.next,
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
      padding:  EdgeInsets.only(top: 50.auto,bottom: 20.auto),
      child: ColorButton(
        text: Text(
          getTranslatedText("confirm_edit"),
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: 16.auto
          ),
        ),
        onClick: (){
          _onClick();
        },
        isEnabled: isButtonEnabled,
        color: CustomColor.theme_bar_gradient_2,
        radius: 9.6 ,
      )
  );

  _getSmsCode() {
    /*if (!validate.validateChinaPhoneNumber(_phoneController.text)) {
      setState(() {
        CustomToast.show("手机号码格式不正确");
      });
    } else {
    CustomProgressDialog.show(context);
    _vm.getForgotPasswordCode(_phoneController.text);
    }*/
  }

  _onTextChange(){
    if(_payPasswordController.text.isNotEmpty && _confirmPayPasswordController.text.isNotEmpty){
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

  _onClick() async {
    /*CustomProgressDialog.show(context);
    _vm.updatePayPassword(_passwordController.text);
    if (_vm.updatePayPasswordApiState.isSuccess) {
      await _vm.getBasicInfo();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        CustomProgressDialog.hide();
        setState(() {
          userProfile = _vm.getBasicInfoApiState.result;
        });
        _vm.resetApiState(isGetBasicInfoApiState: true);
      });
    }*/
  }

  _handleApiState(){
    /*if (_vm.updatePayPasswordApiState == null
        && _vm.getBasicInfoApiState == null) {
      return;
    }
    if ((_vm.updatePayPasswordApiState?.isError ?? false)) {
      CustomToast.show(_vm.updatePayPasswordApiState.error);
      CustomProgressDialog.hide();
      FocusScope.of(context).requestFocus(FocusNode());
      _vm.resetApiState(isUpdatePayPasswordApiState: true);
    }*/
  }
}


