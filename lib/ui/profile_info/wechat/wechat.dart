import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/color_button.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_text_form_field.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/data/provider/input_validation_provider.dart';
import 'package:tgp_flutter/environment_config.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/profile_info/wechat/wechat_view_model.dart';

class Wechat extends StatefulWidget {
  @override
  _WechatState createState() => _WechatState();
}

class _WechatState extends BaseState<Wechat> {
  var _vm = WechatViewModel();
  TextEditingController _wechatController = TextEditingController();
  var isButtonEnabled = false, isTextFieldEnabled = false;
  var buttonText;
  InputValidationProvider validate = new InputValidationProvider();
  var _focusNode = FocusNode();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _getUserProfile();
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return ProviderWidget<WechatViewModel>(
        model: _vm,
        builder: (ctx, vm, _) {
          _handleApiState();
          return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: _buildAppBar(),
              body: Container(
                margin: EdgeInsets.only(left: 10.auto, right: 10.auto, top: 20.auto),
                child: Column(
                  children: [_buildTextFormField(), _buildButton(), _buildFooterText()],
                ),
              ));
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
          getTranslatedText("wechat_no"),
          style: TextStyle(fontSize: 16.auto),
        ),
      );

  _buildTextFormField() => CustomTextFormField(
        title: getTranslatedText("wechat_no"),
        hintText: getTranslatedText("wechat_no_hint"),
        onChanged: (value) => _onTextChange(),
        onFieldSubmitted: (value) {},
        controller: _wechatController,
        focusNode: _focusNode,
        width: context.screenWidth - 70.auto,
        textInputType: TextInputType.text,
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

  _buildFooterText() => Visibility(
        visible: _vm.userProfile.wechat != null,
        child: InkWell(
          onTap: () {
            EnvironmentConfig.brandName == "MESS8"
                ? Navigator.of(context).pushNamed("/customer_service")
                : setState(() {
                    isTextFieldEnabled = true;
                    isButtonEnabled = true;
                    buttonText = getTranslatedText("edit");
                    _focusNode.requestFocus();
                  });
          },
          child: Wrap(
            children: [
              Text(
                getTranslatedText("edit_wechat_cs"),
                style: TextStyle(fontSize: 12.auto),
              ),
              Text(
                EnvironmentConfig.brandName == "MESS8" ? getTranslatedText("online_cs") : getTranslatedText("here"),
                style: TextStyle(
                    decoration: TextDecoration.underline, color: CustomColor.theme_bar_gradient_1, fontSize: 12.auto),
              ),
            ],
          ),
        ),
      );

  _getUserProfile() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      var wechat = _vm.userProfile.wechat;
      setState(() {
        if (wechat != null) {
          if (wechat.isNotEmpty) {
           _wechatController.text = wechat;
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
    if (_wechatController.text.isNotEmpty) {
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
    if (!validate.validateWechat(_wechatController.text)) {
      setState(() {
        CustomToast.show(getTranslatedText("enter_wechat_error_message"));
      });
    } else {
      ProgressDialog.show(context, _vm.brandLogoUrl);
      _vm.setWechatAccount(_wechatController.text);
    }
  }

  _handleApiState() {
    handleApiState(_vm.setWechatApiState, onSuccess: () {
      CustomToast.show(getTranslatedText("success"));
      _getUserProfile();
    });
  }
}
