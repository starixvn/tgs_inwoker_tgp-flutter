import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/color_button.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_text_form_field.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/custom/otp_text_form_field.dart';
import 'package:tgp_flutter/custom/phone_text_form_field.dart';
import 'package:tgp_flutter/data/provider/input_validation_provider.dart';
import 'package:tgp_flutter/environment_config.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/forgot_password/forgot_password_view_model.dart';
import 'package:tgp_flutter/ui/forgot_password/update_forgot_password.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends BaseState<ForgotPassword> {
  var _vm = ForgotPasswordViewModel();
  TextEditingController _emailController = TextEditingController(),
      _otpController = TextEditingController(),
      _phoneController = TextEditingController();
  var isButtonEnabled = false, isOtpEnabled = false, isOtpCountdown = false;
  InputValidationProvider validate = new InputValidationProvider();
  String display = "+852";

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
                title: Text(
                  getTranslatedText("forgot_password"),
                  style: TextStyle(fontSize: 16.auto),
                ),
              ),
              body: Container(
                  child: /*userProfile == null?
                  Center(child: CircularProgressIndicator(),):*/
                      Container(
                margin: EdgeInsets.only(left: 10.auto, right: 10.auto, top: 10.auto),
                child: Column(
                  children: [
                    //CustomTabBar(index:1),
                    (EnvironmentConfig.appTitleName == "HKJP" || EnvironmentConfig.isShowSmsVerification)
                        ? _buildPhoneTextFormField()
                        : _buildTextFormField(),
                    _buildOtpTextFormField(),
                    _buildButton()
                  ],
                ),
              )));
        });
  }

  _buildTextFormField() => Container(
        margin: EdgeInsets.only(top: 15.auto),
        child: CustomTextFormField(
          title: getTranslatedText("email"),
          hintText: getTranslatedText("email_hint"),
          onChanged: (value) => _onTextChange(),
          onFieldSubmitted: (value) {},
          controller: _emailController,
          focusNode: null,
          width: context.screenWidth - 70.auto,
          textInputType: TextInputType.text,
          textInputAction: TextInputAction.next,
        ),
      );

  _buildPhoneTextFormField() => Container(
        margin: EdgeInsets.only(top: 15.auto),
        child: PhoneTextFormField(
          onChanged: (value) => _onTextChange(),
          onFieldSubmitted: (value) {},
          controller: _emailController,
          width: context.screenWidth - 70.auto,
          textInputAction: TextInputAction.next,
          enabled: true,
          onAreaCodeClicked: (value) => _onAreaCodeClicked(value),
          displayedAreaCode: display,
        ),
      );

  _onAreaCodeClicked(String area) {
    setState(() {
      display = area;
      Navigator.of(context).pop();
    });
  }

  _buildOtpTextFormField() => Opacity(
        opacity: isOtpEnabled ? 1 : 0.3,
        child: Container(
          margin: EdgeInsets.only(top: 15.auto),
          child: OtpTextFormField(
              hintText: getTranslatedText("enter_email_otp_hint"),
              onChanged: (value) => _onTextChange(),
              controller: _otpController,
              textInputAction: TextInputAction.done,
              getOtpCode: () {
                _getSmsCode();
              },
              isEnabled: isOtpEnabled,
              isCountdown: isOtpCountdown,
              onCountDownEnd: () => {
                    setState(() {
                      isOtpCountdown = false;
                    })
                  }),
        ),
      );

  _buildButton() => Container(
      margin: EdgeInsets.only(top: 30.auto, bottom: 20.auto),
      child: ColorButton(
        text: Text(
          getTranslatedText("next"),
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 16.auto),
        ),
        onClick: () {
          _checkValidation();
        },
        isEnabled: isButtonEnabled ,
        color: CustomColor.theme_bar_gradient_2,
        radius: 9.6,
      ));

  _checkValidation() {
    _navigateToUpdatePassword();
  }

  _onTextChange() {
    setState(() {
      if (_otpController.text.isNotEmpty && _emailController.text.isNotEmpty) {
        isOtpEnabled = true;
        isButtonEnabled = true;
      } else if (_emailController.text.isNotEmpty) {
        isOtpEnabled = true;
        isButtonEnabled = false;
      } else {
        isOtpEnabled = false;
        isButtonEnabled = false;
      }
    });
  }

  _getSmsCode() {
    if (EnvironmentConfig.appTitleName == "HKJP" || EnvironmentConfig.isShowSmsVerification) {
      if (!validate.validateAreaCodeAndPhone(display, _emailController.text)) {
        setState(() {
          CustomToast.show(getTranslatedText("phone_format_error_msg"));
        });
      } else {
        ProgressDialog.show(context, _vm.brandLogoUrl);
        _vm.getForgotPasswordCode(phone: _emailController.text, areaCode: display);
      }
    } else {
      if (!validate.validateEmail(_emailController.text)) {
        setState(() {
          CustomToast.show(getTranslatedText("email_format_error_msg"));
        });
      } else {
        ProgressDialog.show(context, _vm.brandLogoUrl);
        _vm.getForgotPasswordCode(email: _emailController.text);
      }
    }
  }

  _handleApiState() {
    handleApiState(_vm.getForgotPasswordCodeApiState, onSuccess: () {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        setState(() {
          isOtpCountdown = true;
        });
      });
    });
  }

  _navigateToUpdatePassword() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UpdateForgotPassword(code: _otpController.text, securityKey: _vm.securityKey)));
  }
}
