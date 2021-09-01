import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/color_button.dart';
import 'package:tgp_flutter/custom/custom_picker.dart';
import 'package:tgp_flutter/custom/custom_picker_dialog.dart';
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
import 'package:tgp_flutter/ui/profile_info/security/security_answer_view_model.dart';

class SecurityAnswer extends StatefulWidget {
  @override
  _SecurityAnswerState createState() => _SecurityAnswerState();
}

class _SecurityAnswerState extends BaseState<SecurityAnswer> {
  var _vm = SecurityAnswerViewModel();
  TextEditingController _realNameController = TextEditingController(), _cardNoController = TextEditingController();
  var isButtonEnabled = false, isReset = false;
  var name, cardNumber, buttonText;
  var userProfile;
  var list = [
    {"ddd", "sss"}
  ];
  var securityQuestion;

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
                title: Text(
                  isReset ? "修改安全问题" : "安全问题",
                  style: TextStyle(fontSize: 16.auto),
                ),
              ),
              body: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      )),
                  child: /*userProfile == null?
                  Center(child: CircularProgressIndicator(),):*/
                      Container(
                    margin: EdgeInsets.only(left: 10.auto, right: 10.auto, top: 20.auto),
                    child: Column(
                      children: [
                        /* CustomTextFormField(
                          title: ,
                          hintText: "请选择安全问题",
                          onChanged: (value) => _onTextChange(),
                          onFieldSubmitted: (value){},
                          controller: _realNameController,
                          focusNode: null,
                          width: context.screenWidth-70.auto,
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          enabled: (_vm.userProfile.memberName.isEmpty)? true: false,
                        ),*/
                        CustomPicker(
                          title: "安全问题",
                          displayText: "请选择安全问题",
                          list: list,
                          isHintText: false,
                          width: context.screenWidth,
                          onClick: list.isEmpty
                              ? null
                              : () {
                                  _buildBottomSheet("安全问题", list);
                                },
                        ),
                        CustomTextFormField(
                          title: "问题答案",
                          hintText: "请输入答案",
                          onChanged: (value) => _onTextChange(),
                          onFieldSubmitted: (value) {},
                          controller: _cardNoController,
                          focusNode: null,
                          width: context.screenWidth - 70.auto,
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          //enabled: /*(_vm.userProfile.memberCardNo.isEmpty)? true:*/ false,
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 30.auto, bottom: 20.auto),
                            child: ColorButton(
                              text: Text(
                                "完成",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white, fontSize: 16.auto),
                              ),
                              onClick: () {
                                _onClick();
                              },
                              isEnabled: isButtonEnabled,
                              color: CustomColor.theme_bar_gradient_2,
                              radius: 9.6,
                            )),
                      ],
                    ),
                  )));
        });
  }

  _buildBottomSheet(String title, List<dynamic> list) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return CustomPickerDialog(
              title: title,
              list: list,
              onChanged: (value) {
                setState(() {
                  securityQuestion = value;
                  Navigator.pop(context);
                });
              });
        });
  }

  _getUserProfile() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        userProfile = _vm.userProfile;
        if (_vm.userProfile.memberName.isNotEmpty) {
          _realNameController.text = _vm.userProfile.memberName;
        }
        if (_vm.userProfile.memberCardNo.isNotEmpty) {
          _cardNoController.text = _vm.userProfile.memberCardNo;
        }
      });
    });
  }

  _onTextChange() {
    if (_realNameController.text.isNotEmpty && _cardNoController.text.isNotEmpty) {
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
