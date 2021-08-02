import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/color_button.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_text_form_field.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:shared_api/entity/user_profile.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:shared_api/extension/screen_apis.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/profile_info/real_name/real_name_verification_view_model.dart';

class RealNameVerification extends StatefulWidget {
  @override
  _RealNameVerificationState createState() => _RealNameVerificationState();
}

class _RealNameVerificationState extends BaseState<RealNameVerification> {
  var _vm = RealNameVerificationViewModel();
  TextEditingController _realNameController = TextEditingController(), _icNoController = TextEditingController();
  var isButtonEnabled = false, isTextFieldEnabled = false;
  var buttonText;

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
              appBar: _buildAppBar(),
              body: Container(
                margin: EdgeInsets.only(left: 10.auto, right: 10.auto, top: 20.auto),
                child: Column(
                  children: [
                    _buildTextFormField("realname", "enter_realname_hint", _realNameController, false),
                    _buildTextFormField("ic_no", "enter_ic_no_hint", _icNoController, true),
                    _buildButton(),
                    _buildFooterText()
                  ],
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
          getTranslatedText("ic_no"),
          style: TextStyle(fontSize: 16.auto),
        ),
      );

  _buildTextFormField(String title, String hint, TextEditingController controller, bool isLast) => CustomTextFormField(
        title: getTranslatedText(title),
        hintText: getTranslatedText(hint),
        onChanged: (value) => _onTextChange(),
        onFieldSubmitted: (value) {},
        controller: controller,
        focusNode: null,
        width: context.screenWidth - 70.auto,
        textInputType: TextInputType.text,
        textInputAction: isLast ? TextInputAction.done : TextInputAction.next,
        enabled: isTextFieldEnabled,
      );

  _buildButton() => Container(
      width: context.screenWidth,
      margin: EdgeInsets.only(top: 30.auto, bottom: 20.auto),
      child: ColorButton(
        text: Text(
          buttonText ?? "Done",
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

  _buildFooterText() => Container(
    alignment: Alignment.center,
    child: InkWell(
      onTap: ()=> Navigator.of(context).pushNamed("/customer_service"),
      child: Wrap(
        children: [
          Text(
            getTranslatedText("edit_ic_no_cs"),
            style: TextStyle(fontSize: 12.auto, color: CustomColor.theme_title_text_color),
          ),
          Text(
            getTranslatedText("online_cs"),
            style: TextStyle(fontSize: 12.auto, color: CustomColor.theme_bar_gradient_2),
          )
        ],
      ),
    ),
  );

  _getUserProfile() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var _realname = _vm.userProfile.realname;
      setState(() {
        if (_realname != null) {
          if (_realname.isNotEmpty) {
            _realNameController.text = _realname;
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
    setState(() {
      if (_realNameController.text.isNotEmpty && _icNoController.text.isNotEmpty) {
        isButtonEnabled = true;
      } else {
        isButtonEnabled = false;
      }
    });
  }

  _onClick() async {
    ProgressDialog.show(context);
    _vm.idVerify(_realNameController.text, _icNoController.text);
  }

  _handleApiState() {
    handleApiState(_vm.idVerifyApiState, onSuccess: () {
      CustomToast.show(getTranslatedText("success"));
      _getUserProfile();
    });
  }
}
