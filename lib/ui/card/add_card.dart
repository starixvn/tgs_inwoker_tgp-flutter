import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/color_button.dart';
import 'package:tgp_flutter/custom/custom_picker.dart';
import 'package:tgp_flutter/custom/custom_picker_dialog.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_text_form_field.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/entity/bank_type.dart';
import 'package:tgp_flutter/entity/withdrawal_info.dart';
import 'package:tgp_flutter/extension/format.dart';
import 'package:tgp_flutter/my_behavior.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'card_view_model.dart';

class AddCard extends StatefulWidget {
  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends BaseState<AddCard> {
  var _bankNumController = TextEditingController(),
      _passController = TextEditingController(),
      _addressController = TextEditingController();
  var _vm = CardViewModel();
  var isButtonEnabled = false;
  String bankTypePickerText, bankNamePickerText;
  bool isCrypto = true;

  @override
  void initState() {
    onSelectedBankType();
    super.initState();
  }

  Widget build(BuildContext context) {
    return ProviderWidget<CardViewModel>(
        model: _vm,
        builder: (ctx, vm, _) {
          _handleApiState();
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.grey[100],
              appBar: _buildAppBar(),
              body: _vm.bankTypeList == null
                  ? buildProgressDialog()
                  : Container(
                      padding: EdgeInsets.only(
                        left: 10.auto,
                        right: 10.auto,
                        top: 5.auto,
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: ListView(
                        children: [
                          _buildAddCardTitle(),
                          _buildBankTypePicker(),
                          _buildBankNamePicker(),
                          _buildBankCardTextField(),
                          _buildWithdrawPasswordTextField(),
                          _buildCryptoAddressTextField(),
                          _getHintText(),
                          _buildConfirmButton()
                        ],
                      ),
                    ),
            ),
          );
        });
  }

  _buildAppBar() => AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(
                context,
              );
            }),
        title: Text(
          getTranslatedText("manage_card"),
          style: TextStyle(fontSize: 20.auto),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: Container(
              margin: EdgeInsets.symmetric(vertical: 20.auto),
              alignment: Alignment.center,
              child: Text(
                _vm.wallet == null ? "-" : "¥ ${Format().currencyWithDecimalFormat(_vm.wallet.main)}",
                style: TextStyle(fontSize: 16.auto, color: Colors.white),
              )),
        ),
        flexibleSpace: Container(
          decoration: gradientDecoration,
        ),
      );

  _buildAddCardTitle() => Container(
      margin: EdgeInsets.only(top: 10.auto, left: 20.auto, bottom: 10.auto),
      alignment: Alignment.topLeft,
      child: Text(
        getTranslatedText("add_card"),
        style: TextStyle(fontWeight: FontWeight.w500),
      ));

  _buildBankTypePicker() => CustomPicker(
      title: "bank_type",
      displayText: bankTypePickerText == null ? "Please select bank type" : bankTypePickerText,
      list: _vm.bankTypeList.keys.toList(),
      isHintText: true,
      width: context.screenWidth,
      onClick: () {
        _buildBottomSheet("Bank Type", _vm.bankTypeList.keys.toList());
      });

  _buildBankNamePicker() => CustomPicker(
      title: "bank_name",
      displayText: bankNamePickerText == null ? "Please select bank name" : bankNamePickerText,
      list: _vm.withdrawalInfoList,
      isHintText: true,
      width: context.screenWidth,
      onClick: () {
        _buildBottomSheet("Bank Name", _vm.withdrawalInfoList);
      });

  _buildBankCardTextField() => Visibility(
        visible: !isCrypto,
        child: CustomTextFormField(
          title: getTranslatedText("card_number"),
          hintText: getTranslatedText("enter_card_number"),
          onChanged: (value) => _onTextChange(value),
          onFieldSubmitted: (value) => _onTextChange(value),
          controller: _bankNumController,
          focusNode: null,
          width: context.screenWidth - 70.auto,
          textInputType: TextInputType.number,
          textInputAction: TextInputAction.next,
        ),
      );

  _buildWithdrawPasswordTextField() => Visibility(
        visible: !isCrypto,
        child: Container(
          margin: EdgeInsets.only(top: 10.auto),
          child: CustomTextFormField(
            title: getTranslatedText("pay_password"),
            hintText: getTranslatedText("enter_pay_password"),
            onChanged: (value) => _onTextChange(value),
            onFieldSubmitted: (value) => _onTextChange(value),
            controller: _passController,
            focusNode: null,
            width: context.screenWidth - 70.auto,
            textInputType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
          ),
        ),
      );

  _buildCryptoAddressTextField() => Visibility(
        visible: isCrypto,
        child: CustomTextFormField(
          title: "Address",
          hintText: "Please enter address",
          onChanged: (value) => _onTextChange(value),
          onFieldSubmitted: (value) => _onTextChange(value),
          controller: _addressController,
          focusNode: null,
          width: context.screenWidth - 70.auto,
          textInputType: TextInputType.text,
          textInputAction: TextInputAction.next,
        ),
      );

  _getHintText() => Container(
        margin: EdgeInsets.only(top: 2.auto, bottom: 20.auto),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/card/ic_hint.png",
              width: 15.auto,
              height: 15.auto,
            ),
            Container(
              margin: EdgeInsets.only(left: 5.auto),
              child: Text(
                "资讯加密处理，仅用银行验证",
                style: TextStyle(fontSize: 9.auto, color: Colors.red),
              ),
            )
          ],
        ),
      );

  _buildConfirmButton() => ColorButton(
        text: Text(
          getTranslatedText("confirm"),
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 16.auto),
        ),
        onClick: () {
          _onClick();
        },
        isEnabled: isButtonEnabled,
        color: CustomColor.theme_bar_gradient_2,
        radius: 9.6,
      );

  _buildBottomSheet(String title, List<dynamic> list) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return CustomPickerDialog(
              title: title,
              list: list,
              onChanged: (value) {
                setState(() {
                  if (value is BankType)
                    onSelectedBankType(bankType: value);
                  else if (value is WithdrawalInfo) onSelectedWithdrawalInfo(withdrawalInfo:value);
                  Navigator.pop(context);
                });
              });
        });
  }

  _onTextChange(String value) {
    if (isCrypto) {
      if (_addressController.text != null && _addressController.text.isNotEmpty) {
        setState(() {
          isButtonEnabled = true;
        });
      }
    } else
      isButtonEnabled = false;
  }

  onSelectedBankType({BankType bankType}) async {
    if(bankType == null) bankType=_vm.pBankType;
    await _vm.onSelectedBankType(bankType);
    onSelectedWithdrawalInfo();
    setState(() {
      isCrypto = bankType == BankType.CRYPTO;
      bankTypePickerText = bankType.displayName;
    });
  }

  onSelectedWithdrawalInfo({WithdrawalInfo withdrawalInfo}) async{
    await _vm.onSelectedWithdrawalInfo(withdrawalInfo:withdrawalInfo);
    setState(() {
      bankNamePickerText = _vm.pWithdrawalInfo.channelName.replaceAll(RegExp("_"), " ");
    });
  }

  _onClick() {
    ProgressDialog.show(context);
    _vm.addBankCard(_addressController.text);
  }

  _handleApiState() {
    handleApiState(_vm.addBankCardApiState, onSuccess: () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pop(true);
      });
    });
  }
}
