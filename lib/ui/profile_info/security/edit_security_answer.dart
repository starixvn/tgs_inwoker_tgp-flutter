import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/custom_picker.dart';
import 'package:tgp_flutter/custom/custom_picker_dialog.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_text_form_field.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/entity/user_profile.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/profile_info/real_name/real_name_verification_view_model.dart';
import 'package:tgp_flutter/ui/profile_info/security/edit_security_answer_by_security_answer.dart';
import 'package:tgp_flutter/ui/profile_info/security/edit_security_answer_disable.dart';
import 'package:tgp_flutter/ui/profile_info/security/edit_security_answer_via_email.dart';
import 'package:tgp_flutter/ui/profile_info/security/edit_security_answer_via_phone.dart';
import 'package:tgp_flutter/ui/profile_info/security/security_answer_view_model.dart';

class EditSecurityAnswer extends StatefulWidget {
  @override
  _EditSecurityAnswerState createState() => _EditSecurityAnswerState();
}

class _EditSecurityAnswerState extends BaseState<EditSecurityAnswer> {
  var _vm = SecurityAnswerViewModel();
  TextEditingController _realNameController = TextEditingController(), _cardNoController = TextEditingController();
  var isButtonEnabled = false, isReset = false;
  var name, cardNumber, buttonText;
  var userProfile;
  var tabList = [
    {"text": "安全问题找回"},
    {"text": "手机找回"},
    {"text": "邮箱找回"},
    {"text": "dd"},
  ];
  var currentTabIndex = 0;
  var securityQuestion;

  //TabController _tabController = TabController();

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
                backgroundColor: Colors.black87,
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
                      DefaultTabController(
                    length: 4,
                    child: Column(children: [
                      Container(
                        width: context.screenWidth,
                        color: Colors.black87,
                        child: TabBar(
                          isScrollable: false,
                          unselectedLabelColor: CustomColor.grey,
                          labelColor: CustomColor.theme_label_text_highlight_color,
                          indicatorColor: CustomColor.theme_label_text_highlight_color,
                          indicatorWeight: 3,
                          onTap: (index) {
                            setState(() {
                              currentTabIndex = index;
                            });
                          },
                          unselectedLabelStyle: TextStyle(color: CustomColor.grey),
                          tabs: /*List.generate(tabList.length,(index){*/
                              tabList.map((item) {
                            return Tab(
                              child: Text(
                                item["text"] ?? "null",
                                style: TextStyle(
                                  fontSize: 14.auto,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Expanded(
                          child: TabBarView(children: [
                        EditSecurityAnswerBySecurityAnswer(),
                        EditSecurityAnswerViaPhone(),
                        EditSecurityAnswerViaEmail(),
                        EditSecurityAnswerDisable(title: "无法透过手机号码修改安全问题"),
                        /*(userProfile.checkPassPhone)?EditSecurityAnswerViaPhone():EditSecurityAnswerDisable(),
                                    (userProfile.checkPassEmail)?EditSecurityAnswerViaEmail():EditSecurityAnswerDisable(),*/
                      ]))
                    ]),
                  )));
        });
  }

  _buildBottomSheet(String title, List<dynamic> tabList) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return CustomPickerDialog(
              title: title,
              list: tabList,
              onChanged: (value) {
                setState(() {
                  securityQuestion = value;
                  Navigator.pop(context);
                });
              });
        });
  }

  _getUserProfile() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
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
    /* ProgressDialog.show(context, _vm.brandLogoUrl);
    _vm.updateSecurityQuestion(securityQuestion.securityQuestionID, securityQuestion.answer, isReset);
    if(_vm.updateSecurityQuestionApiState.isSuccess){
      await _vm.getBasicInfo();
      WidgetsBinding.instance!.addPostFrameCallback((_) {
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
