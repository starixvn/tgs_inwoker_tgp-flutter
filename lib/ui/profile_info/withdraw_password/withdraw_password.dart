import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/color_button.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_tab_bar.dart';
import 'package:tgp_flutter/custom/custom_text_form_field.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
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
import 'package:tgp_flutter/ui/profile_info/withdraw_password/withdraw_password_view_model.dart';

class WithdrawPassword extends StatefulWidget{
  @override
  _WithdrawPasswordState createState() => _WithdrawPasswordState();
}

class _WithdrawPasswordState  extends BaseState<WithdrawPassword> {
  var _vm = WithdrawPasswordViewModel();
  TextEditingController _passwordController = TextEditingController(),
      _confirmPasswordController = TextEditingController();
  var phoneText;
  var isButtonEnabled = false, isResetPassword = false,  isCodeVisible = false;
  var name, cardNumber, buttonText;
  var userProfile;
  InputValidationProvider validate = new InputValidationProvider();


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
      });
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return ProviderWidget<WithdrawPasswordViewModel>(
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
                title: Text(isResetPassword?"修改提款密码":"提款密码",
                  style: TextStyle(fontSize: 16.auto),
                ),
              ),
              body: Container(
                  padding: EdgeInsets.only(top: 10.auto, left: 10.auto, right: 10.auto),
                  child: Column(
                    children: [
                      _buildTextFormField("提款密码", "请输入提款密码", _passwordController, false),
                      _buildTextFormField("确认提款密码", "请再次输入提款密码", _confirmPasswordController, true),
                      _buildButton()
                    ],
                  )

              )
          );
        });
  }

  _buildTextFormField(String title, String hint, TextEditingController controller, bool isLast)=> Container(
    margin: EdgeInsets.only(top: 15.auto),
    child: CustomTextFormField(
      title: title,
      hintText: hint,
      onChanged: (value) => _onTextChange(),
      onFieldSubmitted: (value){},
      controller: controller,
      focusNode: null,
      width: context.screenWidth-70.auto,
      textInputType: TextInputType.number,
      textInputAction: isLast?TextInputAction.done:TextInputAction.next,
    ),
  );

  _buildButton() => Container(
      padding:  EdgeInsets.only(top: 50.auto,bottom: 20.auto),
      child: ColorButton(
        text: Text(
          "确认设置",
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
    if(_passwordController.text.isNotEmpty && _confirmPasswordController.text.isNotEmpty){
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

  _onClick() async {
    /*CustomProgressDialog.show(context);
    _vm.updateWithdrawPassword(_passwordController.text);
    if (_vm.updateWithdrawPasswordApiState.isSuccess) {
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
    /*if (_vm.updateWithdrawPasswordApiState == null
        && _vm.getBasicInfoApiState == null) {
      return;
    }
    if ((_vm.updateWithdrawPasswordApiState?.isError ?? false)) {
      CustomToast.show(_vm.updateWithdrawPasswordApiState.error);
      CustomProgressDialog.hide();
      FocusScope.of(context).requestFocus(FocusNode());
      _vm.resetApiState(isUpdateWithdrawPasswordApiState: true);
    }*/
  }
}


