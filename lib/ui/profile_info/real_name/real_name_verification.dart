import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/color_button.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_text_form_field.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/entity/user_profile.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/profile_info/real_name/real_name_verification_view_model.dart';

class RealNameVerification extends StatefulWidget{
  @override
  _RealNameVerificationState createState() => _RealNameVerificationState();
}

class _RealNameVerificationState extends BaseState<RealNameVerification> {
  var _vm = RealNameVerificationViewModel();
  TextEditingController _realNameController = TextEditingController(),
      _cardNoController = TextEditingController();
  var isButtonEnabled = false;
  var name, cardNumber, buttonText;
  var userProfile;

  @override
  void initState() {
    _getUserProfile();
    super.initState();
  }

  Widget build(BuildContext context) {
    return ProviderWidget<RealNameVerificationViewModel>(
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
                title: Text("真实姓名",
                  style: TextStyle(fontSize: 16.auto),
                ),
              ),
              body:  Container(
                margin: EdgeInsets.only(left: 10.auto, right: 10.auto, top: 20.auto),
                child: Column(
                  children: [
                    _buildTextFormField(
                        "真实姓名",
                        "请输入真实姓名",
                        _realNameController,
                        false
                    ),
                    _buildTextFormField(
                        "身份证号码",
                        "请输入您的身份证号码",
                        _realNameController,
                        true
                    ),
                    _buildButton(),
                    _buildFooterText()
                  ],
                ),
              )
          );
        });
  }

  _buildTextFormField(String title, String hint, TextEditingController controller, bool isLast) => CustomTextFormField(
    title: title,
    hintText: hint,
    onChanged: (value) => _onTextChange(),
    onFieldSubmitted: (value){},
    controller: controller,
    focusNode: null,
    width: context.screenWidth-70.auto,
    textInputType: isLast?TextInputType.text:TextInputType.number,
    textInputAction: isLast?TextInputAction.next:TextInputAction.done,
    //enabled: (_vm.userProfile.memberName.isEmpty)? true: false,
  );

  _buildButton() => Container(
      width:context.screenWidth,
      margin: EdgeInsets.only(top: 30.auto, bottom: 20.auto),
      child: ColorButton(
        text: Text(
          buttonText?? "Done",
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

  _buildFooterText() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "如需修改真实姓名，请联系",
        style: TextStyle(
            fontSize: 12.auto,
            color: CustomColor.theme_title_text_color
        ),
      ),
      Text(
        "线上客服",
        style: TextStyle(
            fontSize: 12.auto,
            color: CustomColor.theme_bar_gradient_2
        ),
      )
    ],
  );



  _getUserProfile(){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        userProfile =  _vm.userProfile;
        if(_vm.userProfile.memberName.isNotEmpty){
          _realNameController.text = _vm.userProfile.memberName;
        }
        if(_vm.userProfile.memberCardNo.isNotEmpty){
          _cardNoController.text = _vm.userProfile.memberCardNo;
        }
        if(_vm.userProfile.memberName.isNotEmpty &&_vm.userProfile.memberCardNo.isNotEmpty ){
          buttonText = "已验证";
        }
        else{
          buttonText = "确认";
        }
      });
    });
  }

  _onTextChange(){
    if(_realNameController.text.isNotEmpty && _cardNoController.text.isNotEmpty){
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

  _onClick() async{
    /*CustomProgressDialog.show(context);
    _vm.idVerify(_realNameController.text, _cardNoController.text);
    if(_vm.idVerifyApiState.isSuccess){
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
    /*if (_vm.idVerifyApiState == null) {
      return;
    }
    if ((_vm.idVerifyApiState?.isError ?? false)) {
      CustomToast.show(_vm.idVerifyApiState.error);
      CustomProgressDialog.hide();
      FocusScope.of(context).requestFocus(FocusNode());
      _vm.resetApiState(isIdVerifyApiState: true);
    }*/
  }
}