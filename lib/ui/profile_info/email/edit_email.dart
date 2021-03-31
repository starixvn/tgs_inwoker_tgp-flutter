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
import 'package:tgp_flutter/ui/profile_info/phone/phone_verification_view_model.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';

class EditEmail extends StatefulWidget{
  @override
  _EditEmailState createState() => _EditEmailState();
}

class _EditEmailState extends BaseState<EditEmail> {
  var _vm = EmailVerificationViewModel();
  TextEditingController _emailController = TextEditingController(),
      _otpController = TextEditingController();
  var isButtonEnabled = false;
  var name, cardNumber, buttonText;
  var userProfile;
  InputValidationProvider validate = new InputValidationProvider();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        userProfile =  _vm.userProfile;
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
                title: Text("修改邮箱",
                  style: TextStyle(fontSize: 16.auto),
                ),
              ),
              body: /*userProfile == null?
                  Center(child: CircularProgressIndicator(),):*/
              Container(
                margin: EdgeInsets.only(
                    left: 10.auto, right: 10.auto, top: 10.auto),
                child: Column(
                  children: [
                    CustomTabBar(index:1),
                    _buildTextFormField(),
                    _buildOtpTextFormField(),
                    _buildButton()
                  ],
                ),
              )
          );
        });
  }

  _buildTextFormField() =>  Container(
    margin: EdgeInsets.only(top: 15.auto),
    child: CustomTextFormField(
      title: "邮箱地址",
      hintText: "请输入您的邮箱地址",
      onChanged: (value) => _onTextChange(),
      onFieldSubmitted: (value){},
      controller: _emailController,
      focusNode: null,
      width: context.screenWidth-70.auto,
      textInputType: TextInputType.number,
      textInputAction: TextInputAction.next,
    ),
  );

  _buildOtpTextFormField() => OtpTextFormField(
    hintText: "请输入邮箱验证码",
    onChanged:(value) => _onTextChange(),
    controller: _otpController,
    textInputAction: TextInputAction.done,
    getOtpCode:() {
      _getSmsCode();
    },
  );

  _buildButton() => Container(
      margin: EdgeInsets.only(top: 30.auto, bottom: 20.auto),
      child: ColorButton(
        text: Text(
          "完成",
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

  _onTextChange(){
    if(_otpController.text.isNotEmpty && _emailController.text.isNotEmpty){
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

