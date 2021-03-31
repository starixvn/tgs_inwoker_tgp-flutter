import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/color_button.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_text_form_field.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/profile_info/qq_account/qq_account_view_model.dart';
import 'package:tgp_flutter/ui/profile_info/real_name/real_name_verification_view_model.dart';

class QQAccount extends StatefulWidget{
  @override
  _QQAccountState createState() => _QQAccountState();
}

class _QQAccountState extends BaseState<QQAccount> {
  var _vm = QQAccountViewModel();
  TextEditingController _qqController = TextEditingController();
  var isButtonEnabled = false;
  var name, cardNumber, buttonText;
  var userProfile;

  @override
  void initState() {
    _getUserProfile();
    super.initState();
  }

  Widget build(BuildContext context) {
    return ProviderWidget<QQAccountViewModel>(
        model: _vm,
        builder: (ctx, vm, _) {
          _handleApiState();
          return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.black87,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.black87,
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
              body: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      )
                  ),
                  child: /*userProfile == null?
                  Center(child: CircularProgressIndicator(),):*/
                  Container(
                    margin: EdgeInsets.only(left: 10.auto, right: 10.auto, top: 20.auto),
                    child: Column(
                      children: [
                        _buildTextFormField(),
                        _buildButton(),
                        _buildFooterText()
                      ],
                    ),
                  )
              )
          );
        });
  }

  _buildTextFormField() => CustomTextFormField(
    title: "QQ号码",
    hintText: "请输入您的QQ号码",
    onChanged: (value) => _onTextChange(),
    onFieldSubmitted: (value){},
    controller: _qqController,
    focusNode: null,
    width: context.screenWidth-70.auto,
    textInputType: TextInputType.number,
    textInputAction: TextInputAction.next,
    //enabled: (_vm.userProfile.memberQq.isEmpty)? true: false,
  );

  _buildButton() => Container(
      margin: EdgeInsets.only(top: 30.auto, bottom: 20.auto),
      child: ColorButton(
        text: Text(
          buttonText ?? "",
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
        /*userProfile =  _vm.userProfile;
        if(_vm.userProfile.memberQq.isNotEmpty){
          _qqController.text = _vm.userProfile.memberQq;
          buttonText = "已验证";
        }
        else{*/
        buttonText = "确认";
        //}
      });
    });
  }

  _onTextChange(){
    if(_qqController.text.isNotEmpty){
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
    _vm.updateQQAccount(_qqController.text);
    if(_vm.updateQQApiState.isSuccess){
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
    /* if (_vm.updateQQApiState == null) {
      return;
    }
    if ((_vm.updateQQApiState?.isError ?? false)) {
      CustomToast.show(_vm.updateQQApiState.error);
      CustomProgressDialog.hide();
      FocusScope.of(context).requestFocus(FocusNode());
      _vm.resetApiState(isUpdateQQApiState: true);
    }*/
  }
}