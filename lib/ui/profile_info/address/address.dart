import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/color_button.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_tab_bar.dart';
import 'package:tgp_flutter/custom/custom_text_form_field.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/custom/outline_border_button.dart';
import 'package:tgp_flutter/data/provider/input_validation_provider.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/profile_info/address/address_view_model.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';

class Address extends StatefulWidget {
  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends BaseState<Address> {
  var _vm = AddressViewModel();
  TextEditingController _nameController = TextEditingController(),
      _contactController = TextEditingController(),
      _addressController = TextEditingController();
  var isButtonEnabled = false, isAddressVerified = false;
  var name, cardNumber, buttonText;
  var userProfile;
  InputValidationProvider validate = new InputValidationProvider();

  @override
  void initState() {
    /*WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        userProfile =  _vm.userProfile;
        if(_vm.userProfile.memberAddressSurename.isNotEmpty||
            _vm.userProfile.memberAddress.isNotEmpty||
            _vm.userProfile.memberAddressPhone.isNotEmpty){
          _nameController.text = _vm.userProfile.memberAddressSurename;
          _contactController.text = _vm.userProfile.memberAddress;
          _addressController.text = _vm.userProfile.memberAddressPhone;
          isAddressVerified = true;
        }
      });
    });*/
    super.initState();
  }

  Widget build(BuildContext context) {
    return ProviderWidget<AddressViewModel>(
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
                  "收货地址",
                  style: TextStyle(fontSize: 16.auto),
                ),
              ),
              body: Column(
                children: [
                  _buildTextFormField("收件人", "请输入收件人", _nameController, false),
                  _buildTextFormField("手机号码", "请输入手机号码", _contactController, false),
                  _buildTextFormField("地址", "请填写真实地址，用于发放活动礼品", _addressController, true),
                  _buildButton(),
                  _buildFooterText()
                ],
              ));
        });
  }

  _buildTextFormField(String title, String hint, TextEditingController controller, bool isLast) => Container(
        margin: EdgeInsets.only(top: 15.auto),
        child: CustomTextFormField(
          title: title,
          hintText: hint,
          onChanged: (value) => _onTextChange(),
          onFieldSubmitted: (value) {},
          controller: controller,
          focusNode: null,
          width: context.screenWidth - 70.auto,
          textInputType: TextInputType.text,
          textInputAction: isLast ? TextInputAction.done : TextInputAction.next,
        ),
      );

  _buildButton() => Container(
      width: context.screenWidth,
      padding: EdgeInsets.only(top: 50.auto, bottom: 20.auto),
      child: ColorButton(
        text: Text(
          isAddressVerified ? "已验证" : "确认",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 16.auto),
        ),
        onClick: isAddressVerified
            ? null
            : () {
                _onClick();
              },
        isEnabled: isButtonEnabled,
        color: CustomColor.theme_bar_gradient_2,
        radius: 9.6,
      ));

  _buildFooterText() {
    var _footerText1, _footerText2;
    if (isAddressVerified) {
      _footerText1 = "如需修改号码，请点击";
      _footerText2 = "这里";
    } else {
      _footerText1 = "如有任何问题，请联系";
      _footerText2 = "线上客服";
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _footerText1,
          style: TextStyle(fontSize: 12.auto, color: CustomColor.theme_title_text_color),
        ),
        InkWell(
          onTap: isAddressVerified
              ? () => Navigator.of(context).pushNamed("/edit_email")
              : () {
                  //customer service
                },
          child: Text(
            _footerText2,
            style: TextStyle(fontSize: 12.auto, color: CustomColor.theme_bar_gradient_2),
          ),
        )
      ],
    );
  }

  _onTextChange() {
    if (_addressController.text.isNotEmpty && _nameController.text.isNotEmpty && _contactController.text.isNotEmpty) {
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
    ProgressDialog.show(context, _vm.brandLogoUrl);
    if (!validate.validateChinaPhoneNumber(_contactController.text)) {
      setState(() {
        CustomToast.show("手机号码格式不正确");
      });
    } else {
      /*_vm.updateAddress(_nameController.text, _contactController.text, _addressController.text, "");
      if (_vm.updateAddressApiState.isSuccess) {
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
  }

  _handleApiState() {
    /*if (_vm.updateAddressApiState == null
        && _vm.getBasicInfoApiState == null) {
      return;
    }
    if ((_vm.updateAddressApiState?.isError ?? false)) {
      CustomToast.show(_vm.updateAddressApiState.error);
       ProgressDialog.hide();
      FocusScope.of(context).requestFocus(FocusNode());
      _vm.resetApiState(isUpdateAddressApiState: true);
    }*/
  }
}
