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

class EmailVerification extends StatefulWidget{
  @override
  _EmailVerificationState createState() => _EmailVerificationState();
}

class _EmailVerificationState extends BaseState<EmailVerification> {
  var _vm = EmailVerificationViewModel();
  TextEditingController _emailController = TextEditingController(),
      _otpController = TextEditingController();
  var isButtonEnabled = false, isOtpEnabled = false, isTextFieldEnabled = false;
  var buttonText;
  var userProfile;
  InputValidationProvider validate = new InputValidationProvider();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getUserProfile();
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
                title: Text(getTranslatedText("email"),
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
                    //CustomTabBar(index:1),
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
      title: getTranslatedText("email"),
      hintText: getTranslatedText("email_hint"),
      onChanged: (value) => _onTextChange(),
      onFieldSubmitted: (value){},
      controller: _emailController,
      focusNode: null,
      width: context.screenWidth-70.auto,
      textInputType: TextInputType.number,
      textInputAction: TextInputAction.next,
      enabled: isTextFieldEnabled,
    ),
  );

  _buildOtpTextFormField() =>  Visibility(
    visible:_vm.userProfile.email==null,
    child: Opacity(
      opacity: isOtpEnabled?1:0.4,
      child: Container(
        margin: EdgeInsets.only(top: 15.auto),
        child: OtpTextFormField(
          hintText: getTranslatedText("email_otp_hint"),
          onChanged:(value) => _onTextChange(),
          controller: _otpController,
          textInputAction: TextInputAction.done,
          getOtpCode:() {
            _getSmsCode();
          },
          isEnabled: isOtpEnabled,
        ),
      ),
    ),
  );

  _buildButton() => Container(
      width: context.screenWidth,
      margin: EdgeInsets.only(top: 30.auto, bottom: 20.auto),
      child: ColorButton(
        text: Text(
          buttonText??"",
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
    setState(() {
      if(_otpController.text.isNotEmpty && _emailController.text.isNotEmpty){
        isButtonEnabled = true;
      }else if(_emailController.text.isNotEmpty){
        isOtpEnabled = true;
      } else{
        isButtonEnabled = false;
        isOtpEnabled = false;
      }
    });
  }

  _getUserProfile(){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        userProfile =  _vm.userProfile;
        if(userProfile.email !=null){
          if(userProfile.email.isNotEmpty){
            _emailController.text = userProfile.email;
            buttonText = getTranslatedText("verified");
            isButtonEnabled = false;
            isTextFieldEnabled = false;
          }
        }
        else{
          buttonText = getTranslatedText("done");
          isTextFieldEnabled = true;
        }
      });
    });
  }

  _getSmsCode() {
    if (!validate.validateEmail(_emailController.text)) {
      setState(() {
        CustomToast.show("邮箱地址格式不正确");
      });
    } else {
      CustomProgressDialog.show(context);
      _vm.getEmailCode(_emailController.text);
    }
  }

  _onClick() async {
    CustomProgressDialog.show(context);
    _vm.emailVerify(_otpController.text);
  }

  _handleApiState(){
    handleApiState(_vm.getEmailCodeApiState, onSuccess: (){

    });
    handleApiState(_vm.emailVerifyApiState, onSuccess: (){
      _getUserProfile();
    });
  }
}

