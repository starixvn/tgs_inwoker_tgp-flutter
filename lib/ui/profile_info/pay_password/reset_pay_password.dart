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
import 'package:tgp_flutter/entity/user_profile.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/profile_info/email/email_verification_view_model.dart';
import 'package:tgp_flutter/ui/profile_info/pay_password/pay_password_view_model.dart';
import 'package:tgp_flutter/ui/profile_info/phone/phone_verification_view_model.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';

class ResetPayPassword extends StatefulWidget {
  @override
  _ResetPayPasswordState createState() => _ResetPayPasswordState();
}

class _ResetPayPasswordState extends BaseState<ResetPayPassword> {
  var _vm = PayPasswordViewModel();
  TextEditingController _payPasswordController = TextEditingController(),
      _confirmPayPasswordController = TextEditingController(),
      _phoneController = TextEditingController(),
      _otpController = TextEditingController();
  var isButtonEnabled = false, isResetPassword = false, isCodeVisible = false, isOtpEnabled = false;
  InputValidationProvider validate = new InputValidationProvider();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_vm.userProfile.phone != null && _vm.userProfile.phone.isNotEmpty) {
        setState(() {
          _phoneController.text = _vm.userProfile.phone;
        });
      } else {
        Navigator.of(context).pushNamed("/phone_verification");
      }
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
              appBar: _buildAppBar(),
              body: Container(
                  padding: EdgeInsets.only(top: 10.auto, left: 10.auto, right: 10.auto),
                  child: Column(
                    children: [
                      _buildPasswordTextFormField("new_pay_password", "enter_new_pay_password", _payPasswordController),
                      _buildPasswordTextFormField(
                          "confirm_pay_password", "confirm_pay_password_hint", _confirmPayPasswordController),
                      _buildTextFormField("phone_number", "enter_phone_hint", _phoneController),
                      _buildOtpTextFormField(),
                      _buildButton()
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
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          getTranslatedText("reset_pay_password"),
          style: TextStyle(fontSize: 16.auto),
        ),
      );

  _buildTextFormField(String title, String hint, TextEditingController controller) => Container(
        margin: EdgeInsets.only(top: 15.auto),
        child: CustomTextFormField(
          title: getTranslatedText(title),
          hintText: getTranslatedText(hint),
          onChanged: (value) => _onTextChange(),
          onFieldSubmitted: (value) {},
          controller: controller,
          focusNode: null,
          width: context.screenWidth - 70.auto,
          textInputType: TextInputType.number,
          textInputAction: TextInputAction.next,
          enabled: false,
        ),
      );

  _buildPasswordTextFormField(String title, String hint, TextEditingController controller) => Container(
        margin: EdgeInsets.only(top: 15.auto),
        child: CustomTextFormField(
          title: getTranslatedText(title),
          hintText: getTranslatedText(hint),
          onChanged: (value) => _onTextChange(),
          onFieldSubmitted: (value) {},
          controller: controller,
          focusNode: null,
          width: context.screenWidth - 70.auto,
          textInputType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
        ),
      );

  _buildOtpTextFormField() => Opacity(
        opacity: isOtpEnabled ? 1 : 0.3,
        child: Container(
          margin: EdgeInsets.only(top: 15.auto),
          child: OtpTextFormField(
            hintText: getTranslatedText("enter_phone_otp_hint"),
            onChanged: (value) => _onTextChange(),
            controller: _otpController,
            textInputAction: TextInputAction.done,
            getOtpCode: () {
              _getSmsCode();
            },
          ),
        ),
      );

  _buildButton() => Container(
      width: context.screenWidth,
      padding: EdgeInsets.only(top: 50.auto, bottom: 20.auto),
      child: ColorButton(
        text: Text(
          getTranslatedText("confirm_edit"),
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

  _getSmsCode() {
    CustomProgressDialog.show(context);
    _vm.getPayPasswordCode();
  }

  _onTextChange() {
    if (_payPasswordController.text.isNotEmpty && _confirmPayPasswordController.text.isNotEmpty) {
      setState(() {
        isButtonEnabled = true;
      });
    } else {
      setState(() {
        isButtonEnabled = false;
      });
    }
  }

  _onClick() async {
    if (_payPasswordController.text != _confirmPayPasswordController.text) {
      setState(() {
        CustomToast.show("确认提款密码与提款密码不一致");
      });
    } else {
      CustomProgressDialog.show(context);
      _vm.payPasswordVerify(_payPasswordController.text, _otpController.text);
    }
  }

  _handleApiState() {
    handleApiState(_vm.getPayPasswordCodeApiState, onSuccess: () {});
    handleApiState(_vm.payPasswordVerifyApiState, onSuccess: () {
      CustomToast.show("Success");
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context);
      });
    });
  }
}
