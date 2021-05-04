import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/color_button.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_text_form_field.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/profile_info/qq_account/qq_account_view_model.dart';
import 'package:tgp_flutter/ui/profile_info/real_name/real_name_verification_view_model.dart';

class QQAccount extends StatefulWidget {
  @override
  _QQAccountState createState() => _QQAccountState();
}

class _QQAccountState extends BaseState<QQAccount> {
  var _vm = QQAccountViewModel();
  TextEditingController _qqController = TextEditingController();
  var isButtonEnabled = false, isTextFieldEnabled = false;
  var buttonText;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getUserProfile();
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return ProviderWidget<QQAccountViewModel>(
        model: _vm,
        builder: (ctx, vm, _) {
          _handleApiState();
          return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: _buildAppBar(),
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
                      children: [_buildTextFormField(), _buildButton(), _buildFooterText()],
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
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          getTranslatedText("qq_no"),
          style: TextStyle(fontSize: 16.auto),
        ),
      );

  _buildTextFormField() => CustomTextFormField(
        title: getTranslatedText("qq_no"),
        hintText: getTranslatedText("qq_no_hint"),
        onChanged: (value) => _onTextChange(),
        onFieldSubmitted: (value) {},
        controller: _qqController,
        focusNode: null,
        width: context.screenWidth - 70.auto,
        textInputType: TextInputType.number,
        textInputAction: TextInputAction.done,
        enabled: isTextFieldEnabled,
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
          _onClick();
        },
        isEnabled: isButtonEnabled,
        color: CustomColor.theme_bar_gradient_2,
        radius: 9.6,
      ));

  _buildFooterText() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            getTranslatedText("edit_qq_cs"),
            style: TextStyle(fontSize: 12.auto, color: CustomColor.theme_title_text_color),
          ),
          Text(
            getTranslatedText("customer_service"),
            style: TextStyle(fontSize: 12.auto, color: CustomColor.theme_bar_gradient_2),
          )
        ],
      );

  _getUserProfile() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var _qq = _vm.userProfile.qq;
      setState(() {
        if (_qq != null) {
          if (_qq.isNotEmpty) {
            _qqController.text = _qq;
            buttonText = getTranslatedText("verified");
            isButtonEnabled = false;
            isTextFieldEnabled = false;
          }
        } else {
          buttonText = getTranslatedText("done");
          isTextFieldEnabled = true;
        }
      });
    });
  }

  _onTextChange() {
    if (_qqController.text.isNotEmpty) {
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
    ProgressDialog.show(context);
    _vm.setQQAccount(_qqController.text);
  }

  _handleApiState() {
    handleApiState(_vm.setQQApiState, onSuccess: () async {
      await _getUserProfile();
      CustomToast.show("Success");
    });
  }
}
