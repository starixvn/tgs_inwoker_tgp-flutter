import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/color_button.dart';
import 'package:tgp_flutter/custom/custom_picker.dart';
import 'package:tgp_flutter/custom/custom_picker_dialog.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_tab_bar.dart';
import 'package:tgp_flutter/custom/custom_text_form_field.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/custom/otp_text_form_field.dart';
import 'package:tgp_flutter/data/provider/input_validation_provider.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/ui/profile_info/Email/Email_verification_view_model.dart';

class EditEmail extends StatefulWidget {
  @override
  _EditEmailState createState() => _EditEmailState();
}

class _EditEmailState extends BaseState<EditEmail> {
  var _vm = EmailVerificationViewModel();
  TextEditingController _emailController = TextEditingController(), _otpController = TextEditingController();
  var isButtonEnabled = false, isOtpEnabled = false, isTextFieldEnabled = false, isOtpCountdown = false;
  InputValidationProvider validate = new InputValidationProvider();
  int currIndex = 0;
  String? display;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
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
              body: Container(
                  padding: EdgeInsets.only(top: 10.auto, left: 10.auto, right: 10.auto),
                  child: Column(
                    children: [
                      CustomTabBar(
                        index: currIndex,
                        step1Text: "verify_current_email",
                        step2Text: "set_new_email",
                      ),
                      _buildVerifyOldEmailNumber()
                      // currIndex == 0 ? _buildVerifyOldEmailNumber() : _buildResetPayPassword()
                    ],
                  )));
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
            onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/profile_info'))),
        title: Text(
          getTranslatedText("edit_email"),
          style: TextStyle(fontSize: 16.auto),
        ),
      );

  _buildVerifyOldEmailNumber() => Column(
        children: [_buildEmailTextFormField(), _buildOtpTextFormField(), _buildButton()],
      );

  _buildEmailTextFormField() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
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
          ),
        ],
      );

  _onAreaCodeClicked(String area) {
    setState(() {
      display = area;
      Navigator.of(context).pop();
    });
  }

  _buildOtpTextFormField() => Opacity(
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
              isCountdown: isOtpCountdown,
              isEnabled: isOtpEnabled,
              onCountDownEnd: () => {
                    setState(() {
                      isOtpCountdown = false;
                    })
                  }),
        ),
      );

  _buildButton() => Container(
      width: context.screenWidth,
      margin: EdgeInsets.only(top: 30.auto, bottom: 20.auto),
      child: ColorButton(
        text: Text(
          currIndex == 0 ? getTranslatedText("next") : getTranslatedText("done"),
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
      if (_otpController.text.isNotEmpty) {
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

  _getUserProfile() {
    var email = _vm.userProfile.email;
    setState(() {
      if (email != null) {
        if (email.isNotEmpty) {
          _emailController.text = email;
          isOtpEnabled = true;
        }
      }
    });
  }

  _getSmsCode() {
    if (!validate.validateEmail(_emailController.text)) {
      setState(() {
        CustomToast.show(getTranslatedText("email_format_error_msg"));
      });
    } else {
      ProgressDialog.show(context, _vm.brandLogoUrl);
      _vm.getEmailCode(_emailController.text);
    }
  }

  _onClick() async {
    ProgressDialog.show(context, _vm.brandLogoUrl);
    _vm.emailVerify(_otpController.text);
  }

  _handleApiState() {
    handleApiState(_vm.getEmailCodeApiState, onSuccess: () {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        setState(() {
          isOtpCountdown = true;
        });
      });
    });
    handleApiState(_vm.emailVerifyApiState, onSuccess: () {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        CustomToast.show(getTranslatedText("success"));
        _getUserProfile();
        //if (widget.popDirection == 1) Navigator.of(context).pop(true);
      });
    }, onError: (_) {
      if (_vm.emailVerifyApiState.errorCode == 409) {
        CustomToast.show(getTranslatedText("email_duplicate"));
      } else
        showApiErrorMessage(_vm.emailVerifyApiState);
    });
  }
}
