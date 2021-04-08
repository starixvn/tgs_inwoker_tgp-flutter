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


class EditPassword extends StatefulWidget{
  @override
  _EditPasswordState createState() => _EditPasswordState();
}

class _EditPasswordState extends BaseState<EditPassword> {
  var _vm = EditPasswordViewModel();
  TextEditingController _oldPasswordController = TextEditingController(),
      _newPasswordController = TextEditingController(),
      _confirmPasswordController = TextEditingController();
  var isButtonEnabled = false;
  var name, cardNumber, buttonText;
  var userProfile;
  InputValidationProvider validate = new InputValidationProvider();


  @override
  void initState() {
    /*WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        userProfile =  _vm.userProfile;
      });
    });*/
    super.initState();
  }

  Widget build(BuildContext context) {
    return ProviderWidget<EditPasswordViewModel>(
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
                title: Text("修改密码",
                  style: TextStyle(fontSize: 16.auto),
                ),
              ),
              body: Container(
                  padding: EdgeInsets.only(top: 10.auto, left: 10.auto, right: 10.auto),
                  child: Column(
                    children:[
                      _buildTextFormField("old_password", "enter_old_password_hint", _oldPasswordController,false),
                      _buildTextFormField("new_password", "enter_new_password_hint", _newPasswordController,false),
                      _buildTextFormField("confirm_new_password", "confirm_new_password_hint", _confirmPasswordController,true),
                      _buildButton()
                      //_buildFooterText()
                    ],
                  )
              )
          );
        });
  }

  _buildTextFormField(String title, String hint, TextEditingController controller, bool isLast)=> Container(
    margin: EdgeInsets.only(top: 15.auto),
    child: CustomTextFormField(
      title: getTranslatedText(title),
      hintText: getTranslatedText(hint),
      onChanged: (value) => _onTextChange(),
      onFieldSubmitted: (value){},
      controller: controller,
      focusNode: null,
      width: context.screenWidth-70.auto,
      textInputType: TextInputType.visiblePassword,
      textInputAction: isLast?TextInputAction.done:TextInputAction.next,
    ),
  );

  _buildButton() => Container(
      width: context.screenWidth,
      padding:  EdgeInsets.only(top: 50.auto,bottom: 20.auto),
      child: ColorButton(
        text: Text(
          getTranslatedText("confirm"),
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: 16.auto
          ),
        ),
        onClick: () =>_onClick(),
        isEnabled: isButtonEnabled,
        color: CustomColor.theme_bar_gradient_2,
        radius: 9.6 ,
      )
  );

  /*_buildFooterText(){
    var _footerText1, _footerText2;
    if(isEditPasswordVerified){
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
          onTap: isEditPasswordVerified?(){
            Navigator.of(context).pushNamed("/edit_email");
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

  _onTextChange(){
    if(_oldPasswordController.text.isNotEmpty &&
        _newPasswordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty
    ){
      setState(() {
        isButtonEnabled = true;
      });
    }else{
      setState(() {
        isButtonEnabled = false;
      });
    }
  }

  _onClick() async {
    if(!validate.validatePasswordLength(_newPasswordController.text)) {
      setState(() {
        CustomToast.show("密码由6-20个英文字母或者数字组成");
      });
    }else if(_newPasswordController.text != _confirmPasswordController.text){
      setState(() {
        CustomToast.show("确认密码与密码不一致");
      });
    }else{
      CustomProgressDialog.show(context);
      _vm.editPassword(_oldPasswordController.text, _newPasswordController.text);
    }
  }

  _handleApiState(){
    handleApiState(_vm.editPasswordApiState, onSuccess: (){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.pop(context);
      });
    });
  }
}


