import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tgp_flutter/custom/color_button.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/custom/gradient_button.dart';
import 'package:tgp_flutter/data/provider/input_validation_provider.dart';
import 'package:tgp_flutter/localizations/language_provider.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/login/login_password_text_form_field.dart';
import 'package:tgp_flutter/ui/login/login_text_form_field.dart';
import 'package:tgp_flutter/ui/login/login_view_model.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'dart:math' as math;

import '../../src/custom_color.dart';

class RegisterContent extends StatefulWidget {
  @override
  _RegisterContentState createState() => _RegisterContentState();
}

class _RegisterContentState extends BaseState<RegisterContent> {
  bool _obscurePassword = true, _obscureConfirmPassword = true;
  var username = TextEditingController();
  var password = TextEditingController();
  var confirmPassword = TextEditingController();
  var pay = TextEditingController();
  var confirmPay = TextEditingController();
  var invitationCode = TextEditingController();
  InputValidationProvider validate = new InputValidationProvider();
  LoginViewModel _vm = LoginViewModel();

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    confirmPassword.dispose();
    invitationCode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<LoginViewModel>(
      model: _vm,
      builder: (ctx, vm, _) {
        _handleApiState();
        return Container(
          child: Column(
            children: [
              _buildUsernameTextFormField(),
              _buildPasswordTextFormField(),
              _buildConfirmPasswordTextFormField(),
              _buildPayPasswordTextFormField(),
              _buildPromotionCodeTextFormField(),
              _buildRegisterButton()
            ],
          ),
        );
      },
    );
  }

  _buildUsernameTextFormField() => LoginTextFormField(
        icon: SvgPicture.asset(
          "images/login/ic_login_username.svg",
          height: 20.auto,
        ),
        hintText: getTranslatedText("signup_username_hint"),
        onChanged: (value) => null,
        onFieldSubmitted: (value) => null,
        controller: username,
        width: context.screenWidth,
        textInputType: TextInputType.text,
        textInputAction: TextInputAction.next,
      );

  _buildPasswordTextFormField() => Container(
        margin: EdgeInsets.only(top: 10.auto),
        child: LoginPasswordTextFormField(
          icon: SvgPicture.asset(
            "images/login/unlock_alt.svg",
            height: 20.auto,
          ),
          hintText: getTranslatedText("signup_password_hint"),
          onChanged: (value) => null,
          onFieldSubmitted: (value) => null,
          controller: password,
          width: context.screenWidth,
          textInputType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.next,
          onShowPassword: () {
            setState(() => this._obscurePassword = !this._obscurePassword);
          },
          obscurePassword: _obscurePassword,
        ),
      );

  _buildConfirmPasswordTextFormField() => Container(
        margin: EdgeInsets.only(top: 10.auto),
        child: LoginPasswordTextFormField(
          icon: SvgPicture.asset(
            "images/login/ic_login_password.svg",
            height: 20.auto,
          ),
          hintText: getTranslatedText("confirm_password"),
          onChanged: (value) => null,
          onFieldSubmitted: (value) => null,
          controller: confirmPassword,
          width: context.screenWidth,
          textInputType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.next,
          onShowPassword: () {
            setState(() => this._obscureConfirmPassword = !this._obscureConfirmPassword);
          },
          obscurePassword: _obscureConfirmPassword,
        ),
      );

  _buildPayPasswordTextFormField() => Container(
        margin: EdgeInsets.only(top: 10.auto),
        child: LoginTextFormField(
          icon: SvgPicture.asset(
            "images/login/ic_login_pig.svg",
            height: 20.auto,
          ),
          hintText: getTranslatedText("signup_pay_password_hint"),
          onChanged: (value) => null,
          onFieldSubmitted: (value) => null,
          controller: pay,
          width: context.screenWidth,
          textInputType: TextInputType.text,
          textInputAction: TextInputAction.next,
        ),
      );

  _buildPromotionCodeTextFormField() => Container(
        margin: EdgeInsets.only(top: 10.auto),
        child: LoginTextFormField(
          icon: SvgPicture.asset(
            "images/login/ic_login_promotion.svg",
            height: 20.auto,
          ),
          hintText: getTranslatedText("signup_promotion_code_hint"),
          onChanged: (value) => null,
          onFieldSubmitted: (value) => _register(),
          controller: invitationCode,
          width: context.screenWidth,
          textInputType: TextInputType.text,
          textInputAction: TextInputAction.done,
        ),
      );

  _buildRegisterButton() => Container(
        margin: EdgeInsets.only(top: 70.auto, bottom: 10.auto),
        child: GradientButton(
          title: getTranslatedText("register"),
          onClick: () {
            _register();
          },
          isEnabled: true,
          radius: 2.9,
          height: 44.5,
        ),
      );

  _register() {
    if (!validate.validateUsernameLength(username.text)) {
      setState(() {
        CustomToast.show(getTranslatedText("enter_username_error_message"));
      });
    } else if (!validate.validatePasswordLength(password.text)) {
      setState(() {
        CustomToast.show(getTranslatedText("enter_password_error_msg"));
      });
    } else if (password.text != confirmPassword.text) {
      setState(() {
        CustomToast.show(getTranslatedText("confirm_password_error_msg"));
      });
    } else if (pay.text != confirmPay.text) {
      setState(() {
        CustomToast.show(getTranslatedText("confirm_pay_error_msg"));
      });
    } else {
      CustomProgressDialog.show(context);
      _checkUsername();
    }
  }

  _checkUsername() async {
    _vm.checkUsername(username.text);
  }

  _handleApiState() {
    handleApiState(_vm.registerApiState, onSuccess: () {
      _navigateToHome();
    });
    handleApiState(_vm.checkUsernameApiState, isRequireResult: true, onSuccess: (result) {
      if (result.isExist) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CustomToast.show("Username is existed");
        });
      } else {
        CustomProgressDialog.show(context);
        _vm.register(username.text, password.text, confirmPassword.text, "CNY", invitationCode.text);
      }
    });
  }

  _navigateToHome() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushNamed("/home");
    });
  }
}
