import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/color_button.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_tab_bar.dart';
import 'package:tgp_flutter/custom/custom_text_form_field.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/custom/otp_text_form_field.dart';
import 'package:tgp_flutter/custom/outline_border_button.dart';
import 'package:tgp_flutter/data/provider/input_validation_provider.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/profile_info/email/email_verification_view_model.dart';
import 'package:tgp_flutter/ui/profile_info/phone/phone_verification_view_model.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';

class EmailVerification extends StatefulWidget {
  final int popDirection;

  EmailVerification(this.popDirection);

  @override
  _EmailVerificationState createState() => _EmailVerificationState();
}

class _EmailVerificationState extends BaseState<EmailVerification> {
  var _vm = EmailVerificationViewModel();
  TextEditingController _emailController = TextEditingController(), _otpController = TextEditingController();
  var isButtonEnabled = false, isOtpEnabled = false, isTextFieldEnabled = false, isOtpCountdown = false;
  var buttonText;
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
              appBar: _buildAppBar(),
              body:
                  /*userProfile == null?
                  Center(child: CircularProgressIndicator(),):*/
                  Container(
                margin: EdgeInsets.only(left: 10.auto, right: 10.auto, top: 10.auto),
                child: Column(
                  children: [
                    //CustomTabBar(index:1),
                    _buildTextFormField(),
                    _buildOtpTextFormField(),
                    _buildButton()
                  ],
                ),
              ));
        });
  }

  _buildAppBar() => AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: gradientDecoration,
        ),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          getTranslatedText("email"),
          style: TextStyle(fontSize: 16.auto),
        ),
      );

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
          enabled: isTextFieldEnabled,
        ),
      );

  _buildOtpTextFormField() => Visibility(
        visible: _vm.userProfile.email == null,
        child: Opacity(
          opacity: isOtpEnabled ? 1 : 0.4,
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
              },
            ),
          ),
        ),
      );

  _buildButton() => Container(
      width: context.screenWidth,
      margin: EdgeInsets.only(top: 30.auto, bottom: 20.auto),
      child: ColorButton(
        text: Text(
          buttonText ?? "",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 16.auto),
        ),
        onClick: () {
          _onClick();
        },
        isEnabled: isButtonEnabled,
        color: CustomColor.theme_bar_gradient_2,
        radius: 9.6,
      ));

  _onTextChange() {
    setState(() {
      if (_otpController.text.isNotEmpty && _emailController.text.isNotEmpty) {
        isButtonEnabled = true;
      } else if (_emailController.text.isNotEmpty) {
        isOtpEnabled = true;
      } else {
        isButtonEnabled = false;
        isOtpEnabled = false;
      }
    });
  }

  _getUserProfile() {
    var _email = _vm.userProfile.email;
    setState(() {
      if (_email != null) {
        if (_email.isNotEmpty) {
          _emailController.text = _email;
          buttonText = getTranslatedText("verified");
          isButtonEnabled = false;
          isTextFieldEnabled = false;
        }
      } else {
        buttonText = getTranslatedText("done");
        isTextFieldEnabled = true;
      }
    });
  }

  _getSmsCode() {
    if (!validate.validateEmail(_emailController.text)) {
      setState(() {
        CustomToast.show(getTranslatedText("email_format_error_msg"));
      });
    } else {
      ProgressDialog.show(context);
      _vm.getEmailCode(_emailController.text);
    }
  }

  _onClick() async {
    ProgressDialog.show(context);
    _vm.emailVerify(_otpController.text);
  }

  _handleApiState() {
    handleApiState(_vm.getEmailCodeApiState, onSuccess: () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          isOtpCountdown = true;
        });
      });
    });
    handleApiState(_vm.emailVerifyApiState, onSuccess: () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        CustomToast.show(getTranslatedText("success"));
        _getUserProfile();
        if (widget.popDirection == 1) Navigator.of(context).pop(true);
      });
    });
  }
}
