import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/color_button.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_text_form_field.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/data/provider/input_validation_provider.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/profile_info/password/edit_password_view_model.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/ui/profile_info/pay_password/pay_password_view_model.dart';

class PayPassword extends StatefulWidget {
  @override
  _PayPasswordState createState() => _PayPasswordState();
}

class _PayPasswordState extends BaseState<PayPassword> {
  var _vm = PayPasswordViewModel();
  TextEditingController _oldPasswordController = TextEditingController(),
      _newPasswordController = TextEditingController(),
      _confirmPasswordController = TextEditingController();
  var isButtonEnabled = false;
  InputValidationProvider validate = new InputValidationProvider();

  @override
  void initState() {
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
              body: _vm.userProfile == null
                  ? buildProgressDialog()
                  : Container(
                      padding: EdgeInsets.only(top: 10.auto, left: 10.auto, right: 10.auto),
                      child: Column(
                        children: [
                          Visibility(
                              visible: _vm.userProfile.isSetPayPassword,
                              child: _buildTextFormField(
                                  "old_password", "enter_old_password_hint", _oldPasswordController, false)),
                          _buildTextFormField("new_password", "enter_new_password_hint", _newPasswordController, false),
                          _buildTextFormField(
                              "confirm_new_password", "confirm_new_password_hint", _confirmPasswordController, true),
                          _buildButton()
                          //_buildFooterText()
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
          _vm.userProfile.isSetPayPassword
              ? getTranslatedText("edit_pay_password")
              : getTranslatedText("add_pay_password"),
          style: TextStyle(fontSize: 16.auto),
        ),
      );

  _buildTextFormField(String title, String hint, TextEditingController controller, bool isLast) => Container(
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
          textInputAction: isLast ? TextInputAction.done : TextInputAction.next,
        ),
      );

  _buildButton() => Container(
      width: context.screenWidth,
      padding: EdgeInsets.only(top: 50.auto, bottom: 20.auto),
      child: ColorButton(
        text: Text(
          getTranslatedText("confirm"),
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 16.auto),
        ),
        onClick: () => _onClick(),
        isEnabled: isButtonEnabled,
        color: CustomColor.theme_bar_gradient_2,
        radius: 9.6,
      ));

  /*_buildFooterText(){
    var _footerText1, _footerText2;
    if(isEditPayPasswordVerified){
      _footerText1 = "如需修改号码，请点击";
      _footerText2 = "这里";
    }else{
      _footerText1 = "如有任何问题，请联系";
      _footerText2 = "线上客服";
   // }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _footerText1,
          style: TextStyle(
              fontSize: 12.auto,
              color: CustomColor.black
          ),
        ),
        InkWell(
          onTap: isEditPayPasswordVerified?(){
            Navigator.of(context).push((widget: route));("/edit_email");
          }:(){
            //customer service
          },
          child: Text(
            _footerText2,
            style: TextStyle(
                fontSize: 12.auto,
                color: CustomColor.sand_brown
            ),
          ),
        )
      ],
    );
  }*/

  _onTextChange() {
    setState(() {
      if (!_vm.userProfile.isSetPayPassword) {
        if (_newPasswordController.text.isNotEmpty && _confirmPasswordController.text.isNotEmpty) {
          isButtonEnabled = true;
        }
      } else if (_vm.userProfile.isSetPayPassword) {
        if (_oldPasswordController.text.isNotEmpty &&
            _newPasswordController.text.isNotEmpty &&
            _confirmPasswordController.text.isNotEmpty) {
          isButtonEnabled = true;
        }
      } else {
        isButtonEnabled = false;
      }
    });
  }

  _onClick() async {
    if (!validate.validatePasswordLength(_newPasswordController.text)) {
      setState(() {
        CustomToast.show(getTranslatedText("enter_password_error_msg"));
      });
    } else if (_newPasswordController.text != _confirmPasswordController.text) {
      setState(() {
        CustomToast.show(getTranslatedText("confirm_password_error_msg"));
      });
    } else {
      ProgressDialog.show(context);
      if (_vm.userProfile.isSetPayPassword) {
        //_vm.EditPayPassword(_oldPasswordController.text, _newPasswordController.text);
      } else {
        _vm.addPayPassword(_newPasswordController.text);
      }
    }
  }

  _handleApiState() {
    handleApiState(_vm.addPayPasswordApiState, onSuccess: () {
      CustomToast.show("success");
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context);
      });
    });
  }
}
