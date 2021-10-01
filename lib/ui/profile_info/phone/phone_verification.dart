import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/color_button.dart';
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
import 'package:tgp_flutter/ui/profile_info/phone/phone_verification_view_model.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';

class PhoneVerification extends StatefulWidget {
  @override
  _PhoneVerificationState createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends BaseState<PhoneVerification> {
  var _vm = PhoneVerificationViewModel();
  TextEditingController _phoneController = TextEditingController(), _otpController = TextEditingController();
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
    return ProviderWidget<PhoneVerificationViewModel>(
        model: _vm,
        builder: (ctx, vm, _) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: _buildAppBar(),
              body: Container(
                  child: /*userProfile == null?
                  Center(child: CircularProgressIndicator(),):*/
                      Container(
                margin: EdgeInsets.only(left: 10.auto, right: 10.auto, top: 10.auto),
                child: Column(
                  children: [
                    //CustomTabBar(index:1),
                    _buildTextFormField(),
                    _buildButton(),
                    _buildEditPhoneText()
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
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/profile_info'))),
        title: Text(
          getTranslatedText("phone_number"),
          style: TextStyle(fontSize: 16.auto),
        ),
      );

  _buildTextFormField() => Container(
        margin: EdgeInsets.only(top: 15.auto),
        child: CustomTextFormField(
          title: getTranslatedText("phone_number"),
          hintText: getTranslatedText("enter_phone_hint"),
          onChanged: (value) => _onTextChange(),
          onFieldSubmitted: (value) {},
          controller: _phoneController,
          focusNode: null,
          width: context.screenWidth - 70.auto,
          textInputType: TextInputType.number,
          textInputAction: TextInputAction.next,
          enabled: isTextFieldEnabled,
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
          //_onClick();
        },
        isEnabled: isButtonEnabled ?? false,
        color: CustomColor.theme_bar_gradient_2,
        radius: 9.6,
      ));

  _buildEditPhoneText() => Wrap(
        children: [
          Text(
            getTranslatedText("edit_phone_cs"),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(RoutePath.editPhone)
                  .then((value) => WidgetsBinding.instance.addPostFrameCallback((_) {
                        _getUserProfile();
                      }));
            },
            child: Text(
              getTranslatedText("here"),
              style: TextStyle(decoration: TextDecoration.underline, color: CustomColor.theme_bar_gradient_1),
            ),
          ),
        ],
      );

  _onTextChange() {
    setState(() {
      if (_otpController.text.isNotEmpty && _phoneController.text.isNotEmpty) {
        isButtonEnabled = true;
      } else if (_phoneController.text.isNotEmpty) {
        isOtpEnabled = true;
        isButtonEnabled = false;
      } else {
        isOtpEnabled = false;
        isButtonEnabled = false;
      }
    });
  }

  _getUserProfile() {
    setState(() {
      var phone = _vm.userProfile.phone;
      if (phone != null) {
        if (phone.isNotEmpty) {
          _phoneController.text = phone;
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
}
