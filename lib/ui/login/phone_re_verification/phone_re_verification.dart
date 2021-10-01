import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/color_button.dart';
import 'package:tgp_flutter/custom/custom_password_text_form_field.dart';
import 'package:tgp_flutter/custom/custom_picker.dart';
import 'package:tgp_flutter/custom/custom_picker_dialog.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_text_form_field.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/custom/otp_text_form_field.dart';
import 'package:tgp_flutter/data/provider/input_validation_provider.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/route_path.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/login/login_view_model.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';

class PhoneReVerification extends StatefulWidget {
  final String username;
  final String password;

  PhoneReVerification({Key key, this.username, this.password}) : super(key: key);

  @override
  _PhoneReVerificationState createState() => _PhoneReVerificationState();
}

class _PhoneReVerificationState extends BaseState<PhoneReVerification> {
  var _vm = LoginViewModel();
  TextEditingController _phoneController = TextEditingController(),
      _otpController = TextEditingController(),
      _usernameController = TextEditingController(),
      _passwordController = TextEditingController();
  var isButtonEnabled = false, isOtpEnabled = false, isTextFieldEnabled = false, isOtpCountdown = false;
  var buttonText;
  InputValidationProvider validate = new InputValidationProvider();
  bool _obscurePassword = true;
  String display;

  @override
  void initState() {
    display = areaCodeList.first;
    super.initState();
  }

  Widget build(BuildContext context) {
    return ProviderWidget<LoginViewModel>(
        model: _vm,
        builder: (ctx, vm, _) {
          _handleApiState();
          return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: _buildAppBar(),
              body: Container(
                  child: /*userProfile == null?
                  Center(child: CircularProgressIndicator(),):*/
                      Container(
                margin: EdgeInsets.only(
                    left: 10.auto, right: 10.auto, top: 10.auto, bottom: MediaQuery.of(context).viewInsets.bottom),
                child: ListView(
                  children: [
                    //CustomTabBar(index:1),
                    _buildUsernameTextFormField(),
                    _buildPasswordTextFormField(),
                    _buildPhoneTextFormField(),
                    _buildOtpTextFormField(),
                    _buildButton()
                  ],
                ),
              )));
        });
  }

  _buildAppBar() => AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: gradientDecoration,
        ),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
        title: Text(
          getTranslatedText("phone_re-verify"),
          style: TextStyle(fontSize: 16.auto),
        ),
      );

  _buildUsernameTextFormField() => Visibility(
        visible: widget.username.isEmpty && widget.password.isEmpty,
        child: Container(
          margin: EdgeInsets.only(top: 15.auto),
          child: CustomTextFormField(
            title: getTranslatedText("username"),
            hintText: getTranslatedText("username"),
            onChanged: (value) => _onTextChange(),
            onFieldSubmitted: (value) {},
            controller: _usernameController,
            focusNode: null,
            width: context.screenWidth - 70.auto,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
            enabled: true,
          ),
        ),
      );

  _buildPasswordTextFormField() => Visibility(
        visible: widget.username.isEmpty && widget.password.isEmpty,
        child: Container(
          margin: EdgeInsets.only(top: 15.auto),
          child: CustomPasswordTextFormField(
            title: getTranslatedText("password"),
            hintText: getTranslatedText("password"),
            onChanged: (value) => _onTextChange(),
            onFieldSubmitted: (value) {},
            controller: _passwordController,
            width: context.screenWidth - 70.auto,
            obscurePassword: _obscurePassword,
            onShowPassword: () {
              setState(() => this._obscurePassword = !this._obscurePassword);
            },
          ),
        ),
      );

  _buildPhoneTextFormField() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCard(),
          Container(
            margin: EdgeInsets.only(top: 15.auto),
            child: CustomTextFormField(
              title: getTranslatedText("phone_number"),
              hintText: getTranslatedText("enter_phone_hint"),
              onChanged: (value) => _onTextChange(),
              onFieldSubmitted: (value) {},
              controller: _phoneController,
              focusNode: null,
              width: context.screenWidth * 2 / 5 + 20.auto,
              textInputType: TextInputType.number,
              textInputAction: TextInputAction.next,
              enabled: true,
            ),
          ),
        ],
      );

  _buildCard() => Container(
      margin: EdgeInsets.only(top: 15.auto),
      child: Opacity(
        opacity: 1,
        child: CustomPicker(
          title: getTranslatedText("area_code"),
          displayText: display ?? "",
          //isDeposit? depositText??"请选择红利": pickerText?? "",
          list: areaCodeList,
          isHintText: false,
          width: context.screenWidth / 5,
          onClick: () {
            _buildBottomSheet();
          },
        ),
      ));

  _buildBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return CustomPickerDialog(
              title: getTranslatedText("area_code"),
              list: areaCodeList,
              onChanged: (value) {
                setState(() {
                  display = value;
                  Navigator.pop(context);
                });
              });
        });
  }

  _buildOtpTextFormField() => Visibility(
        visible: true,
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
                isCountdown: isOtpCountdown,
                isEnabled: isOtpEnabled,
                onCountDownEnd: () => {
                      setState(() {
                        isOtpCountdown = false;
                      })
                    }),
          ),
        ),
      );

  _buildButton() => Container(
      width: context.screenWidth,
      margin: EdgeInsets.only(top: 30.auto, bottom: 20.auto),
      child: ColorButton(
        text: Text(
          getTranslatedText("submit"),
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 16.auto),
        ),
        onClick: () {
          _onClick();
        },
        isEnabled: isButtonEnabled ?? false,
        color: CustomColor.theme_bar_gradient_2,
        radius: 9.6,
      ));

  _onTextChange() {
    setState(() {
      if ((widget.username.isNotEmpty && widget.password.isNotEmpty) ||
          (_usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty)) {
        if (_phoneController.text.isNotEmpty && _otpController.text.isNotEmpty) {
          isButtonEnabled = true;
        } else if (_phoneController.text.isNotEmpty) {
          isOtpEnabled = true;
          isButtonEnabled = false;
        } else {
          isOtpEnabled = false;
          isButtonEnabled = false;
        }
      } else {
        isOtpEnabled = false;
        isButtonEnabled = false;
      }
    });
  }

  _getSmsCode() {
    if (!validate.validateAreaCodeAndPhone(display, _phoneController.text)) {
      setState(() {
        CustomToast.show(getTranslatedText("phone_format_error_msg"));
      });
    } else {
      //ProgressDialog.show(context, _vm.brandLogoUrl);
      _vm.getReVerifyCode(_usernameController.text, _passwordController.text, display, _phoneController.text);
    }
  }

  _onClick() async {
    ProgressDialog.show(context, _vm.brandLogoUrl);
    _vm.phoneVerify(_otpController.text);
  }

  _handleApiState() {
    handleApiState(_vm.getReVerifyCodeApiState, onSuccess: () {});

    handleApiState(_vm.phoneReVerifyApiState, onSuccess: () {
      _navigateToHome();
    });
  }

  _navigateToHome() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushNamedAndRemoveUntil(RoutePath.home, (Route<dynamic> route) => false);
    });
  }
}
