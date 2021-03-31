import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_tab_bar.dart';
import 'package:tgp_flutter/custom/custom_text_form_field.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/custom/outline_border_button.dart';
import 'package:tgp_flutter/data/provider/input_validation_provider.dart';
import 'package:tgp_flutter/entity/event_type.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/profile_info/email/base_email_phone_verification.dart';
import 'package:tgp_flutter/ui/profile_info/email/email_verification_view_model.dart';
import 'package:tgp_flutter/ui/profile_info/phone/phone_verification_view_model.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';

class EmailVerification extends StatefulWidget{
  @override
  _EmailVerificationState createState() => _EmailVerificationState();
}

class _EmailVerificationState extends BaseState<EmailVerification> {
  var _vm = EmailVerificationViewModel();
  TextEditingController _otpController = TextEditingController(),
      _emailController = TextEditingController();
  var phoneText;
  var isButtonEnabled = false, isPhoneVerified = false,  isCodeVisible = false;
  var name, cardNumber, buttonText;
  var userProfile;
  InputValidationProvider validate = new InputValidationProvider();


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        userProfile =  _vm.userProfile;
        if(_vm.userProfile.memberEmail.isNotEmpty){
          isPhoneVerified = true;
          _emailController.text = _vm.userProfile.memberEmail;
        }
      });
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return ProviderWidget<EmailVerificationViewModel>(
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
                title: Text("邮箱地址",
                  style: TextStyle(fontSize: 16.auto),
                ),
              ),
              body: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      )
                  ),
                  padding: EdgeInsets.only(
                      top: 10.auto, left: 10.auto, right: 10.auto),
                  child: _buildBaseEmailPhoneVerification()
              )
          );
        });
  }

  _buildBaseEmailPhoneVerification() => BaseEmailPhoneVerification(
    inputText:"邮箱地址",
    hintText:"请输入您的邮箱地址",
    footerText1: isPhoneVerified?"如需修改号码，请点击": "如有任何问题，请联系",
    footerText2:isPhoneVerified?"这里": "线上客服",
    navigatePath:"edit_email",
    isEmail:true,
    isVerified:isPhoneVerified,
    isInputCodeVisible:isCodeVisible,
    getSmsCode:()=>_getSmsCode(),
    onClick:()=>_onClick(),
    inputController:_emailController,
    otpController:_otpController,
  );

  _getSmsCode() {
    if (!validate.validateEmail(_emailController.text)) {
      setState(() {
        CustomToast.show("邮箱地址格式不正确");
      });
    } else {
      //_vm.emailVerify(_emailController.text, EventType.BIND);
    }
  }

  _onClick() async {
    /*CustomProgressDialog.show(context);
    _vm.emailVerify(_emailController.text, EventType.BIND);
    if (_vm.emailVerifyApiState.isSuccess) {
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
    /*if (_vm.emailVerifyApiState == null
        && _vm.getBasicInfoApiState == null) {
      return;
    }
    if ((_vm.emailVerifyApiState?.isError ?? false)) {
      CustomToast.show(_vm.emailVerifyApiState.error);
      CustomProgressDialog.hide();
      FocusScope.of(context).requestFocus(FocusNode());
      _vm.resetApiState(isVerifyCodeApiState: true);
    }*/
  }
}


