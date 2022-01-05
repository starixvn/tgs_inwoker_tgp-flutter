import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tgp_flutter/custom/color_button.dart';
import 'package:tgp_flutter/custom/custom_dialog.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_text_form_field.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/custom/gradient_button.dart';
import 'package:tgp_flutter/data/provider/input_validation_provider.dart';
import 'package:tgp_flutter/entity/user_profile.dart';
import 'package:tgp_flutter/environment_config.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/profile_info/real_name/real_name_verification_view_model.dart';

class RealNameVerification extends StatefulWidget {
  @override
  _RealNameVerificationState createState() => _RealNameVerificationState();
}

class _RealNameVerificationState extends BaseState<RealNameVerification> {
  var _vm = RealNameVerificationViewModel();
  TextEditingController _realNameController = TextEditingController(),
      _icNoController = TextEditingController(),
      _docNoController = TextEditingController();
  var isButtonEnabled = false, isTextFieldEnabled = false;
  var buttonText;
  File? uploadImage;
  InputValidationProvider validate = new InputValidationProvider();

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
                  child: isPisoBet()?_buildUploadDocColumn(): _buildRealNameColumn()));
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

  _buildRealNameColumn() => Column(
        children: [
          _buildTextFormField("realname", "enter_realname_hint", _realNameController, false),
          _buildTextFormField("ic_no", "enter_ic_no_hint", _icNoController, true),
          _buildButton(),
          _buildFooterText()
        ],
      );

  _buildUploadDocColumn() => Column(
        children: [
          _buildTextFormField("doc_no", "enter_doc_no_hint", _docNoController, false),
          _buildTextFormField("full_name", "enter_full_name_hint", _realNameController, true),
          /*GradientButton(
            title: getTranslatedText("upload_prof"),
            onClick: () => _vm.uploadDepositImage(uploadImage!.path, " "),
            isEnabled: uploadImage == null ? false : true,
            radius: 9.6,
            height: 44.5,
          ),*/
          _buildButton(),
        ],
      );

  _buildTextFormField(String title, String hint, TextEditingController controller, bool isLast) => Container(
        margin: EdgeInsets.only(
          bottom: isLast ? 30.auto : 0,
        ),
        child: CustomTextFormField(
          title: getTranslatedText(title),
          hintText: getTranslatedText(hint),
          onChanged: (value) => _onTextChange(),
          onFieldSubmitted: (value) {},
          controller: controller,
          focusNode: null,
          width: context.screenWidth - 70.auto,
          textInputType: TextInputType.text,
          textInputAction: isLast ? TextInputAction.done : TextInputAction.next,
          enabled: true,//isTextFieldEnabled,
        ),
      );

  _buildButton() => Container(
      width: context.screenWidth,
      margin: EdgeInsets.only(top: 10.auto, bottom: 20.auto),
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
          onTap: () => Navigator.of(context).pushNamed("/customer_service"),
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
    WidgetsBinding.instance!.addPostFrameCallback((_) {
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

  _onTextChange() async {
    setState(() {
      if ((isPisoBet() && _realNameController.text.isNotEmpty && _docNoController.text.isNotEmpty) ||
          (_realNameController.text.isNotEmpty && _docNoController.text.isNotEmpty)) {
        isButtonEnabled = true;
      } else {
        isButtonEnabled = false;
      }
    });
  }

  _onClick() async {
    if (isPisoBet() &&
        validate.validateInputLength(_docNoController.text) &&
        validate.validateInputLength(_realNameController.text)) {
      setState(() {
        CustomToast.show(getTranslatedText("input_length_error"));
      });
    } else {
      ProgressDialog.show(context, _vm.brandLogoUrl);
      _vm.idVerify(_realNameController.text, _icNoController.text);
    }
  }

  Future<void> chooseImage() async {
    ImagePicker picker = ImagePicker();
    XFile? choosedImage = await picker.pickImage(source: ImageSource.gallery);
    File imageFile;
    imageFile = File(choosedImage!.path);
    var bytes = imageFile.readAsBytesSync().lengthInBytes;
    if (bytes > 10485760) {
      //restrict upload image to 10MB
      CustomToast.show(getTranslatedText("image_size_limit"));
    } else {
      setState(() {
        uploadImage = imageFile;
      });
    }
  }

  isPisoBet() => EnvironmentConfig.brandName == "PISO";

  _handleApiState() {
    handleApiState(_vm.idVerifyApiState, onSuccess: () {
      CustomToast.show(getTranslatedText("success"));
      _getUserProfile();
    });

    handleApiState(_vm.uploadDepositImageApiState, onSuccess: () {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (BuildContext context) => CustomDialog(
            title: null,
            description: getTranslatedText("upload_success"),
            buttonText1: getTranslatedText("confirm"),
            onClick: () {
              Navigator.pop(
                context,
              );
              Navigator.pop(
                context,
              );
            },
          ),
        );
      });
    });
  }
}
