import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/custom_picker.dart';
import 'package:tgp_flutter/custom/custom_picker_dialog.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_text_form_field.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/custom/outline_border_button.dart';
import 'package:tgp_flutter/data/provider/input_validation_provider.dart';
import 'package:tgp_flutter/entity/user_profile.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/profile_info/real_name/real_name_verification_view_model.dart';
import 'package:tgp_flutter/ui/profile_info/security/security_answer_view_model.dart';

class BaseEditSecurityAnswer extends StatefulWidget {
  @override
  _BaseEditSecurityAnswerState createState() => _BaseEditSecurityAnswerState();
}

class _BaseEditSecurityAnswerState extends BaseState<BaseEditSecurityAnswer> {
  var _vm = SecurityAnswerViewModel();
  TextEditingController _emailController = TextEditingController(), _otpController = TextEditingController();
  var isButtonEnabled = false, isReset = false;
  var name, cardNumber, buttonText;
  var userProfile;
  var securityQuestion;
  InputValidationProvider validate = new InputValidationProvider();

  @override
  void initState() {
    //_getUserProfile();
    super.initState();
  }

  Widget build(BuildContext context) {
    return ProviderWidget<SecurityAnswerViewModel>(
        model: _vm,
        builder: (ctx, vm, _) {
          _handleApiState();
          return Column();
        });
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

  _getUserProfile() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        userProfile = _vm.userProfile;
        if (_vm.userProfile.memberName.isNotEmpty) {
          _emailController.text = _vm.userProfile.memberName;
        }
        if (_vm.userProfile.memberCardNo.isNotEmpty) {
          _otpController.text = _vm.userProfile.memberCardNo;
        }
      });
    });
  }

  _onTextChange() {
    if (_emailController.text.isNotEmpty && _otpController.text.isNotEmpty) {
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
    /* ProgressDialog.show(context);
    _vm.updateSecurityQuestion(securityQuestion.securityQuestionID, securityQuestion.answer, isReset);
    if(_vm.updateSecurityQuestionApiState.isSuccess){
      await _vm.getBasicInfo();
      WidgetsBinding.instance.addPostFrameCallback((_) {
         ProgressDialog.hide();
        setState(() {
          userProfile = _vm.getBasicInfoApiState.result;
        });
        _vm.resetApiState(isGetBasicInfoApiState: true);
      });
    }*/
  }

  _handleApiState() {
    /*if (_vm.idVerifyApiState == null) {
      return;
    }
    if ((_vm.idVerifyApiState?.isError ?? false)) {
      CustomToast.show(_vm.idVerifyApiState.error);
       ProgressDialog.hide();
      FocusScope.of(context).requestFocus(FocusNode());
      _vm.resetApiState(isIdVerifyApiState: true);
    }*/
  }
}
