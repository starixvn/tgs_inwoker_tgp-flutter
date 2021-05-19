import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/color_button.dart';
import 'package:tgp_flutter/custom/custom_picker.dart';
import 'package:tgp_flutter/custom/custom_picker_dialog.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_text_form_field.dart';
import 'package:tgp_flutter/entity/payment.dart';
import 'package:tgp_flutter/extension/format.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/deposit/deposit_method_view_model.dart';
import 'package:tgp_flutter/ui/deposit/deposit_order_view.dart';
import 'package:tgp_flutter/ui/deposit/deposit_web.dart';

class DepositMethod extends StatefulWidget {
  final String paymentCode;
  final Map<String, List<Payment>> depositMethodList;

  DepositMethod({Key key, this.paymentCode, this.depositMethodList}) : super(key: key);

  @override
  _DepositMethodState createState() => _DepositMethodState();
}

class _DepositMethodState extends BaseState<DepositMethod> with AutomaticKeepAliveClientMixin {
  String methodPickerText, channelPickerText;
  TextEditingController _amountController = TextEditingController(), _bankNameController = TextEditingController();
  var isButtonEnabled = false;
  var selectedPayment;
  var paymentMin, paymentMax;
  int amount;

  DepositMethodViewModel _vm;
  Payment _payment;
  var paymentChannelId;

  void initState() {
    _vm = DepositMethodViewModel(widget.depositMethodList);
    if (_vm.depositMethodList.isNotEmpty) {
      methodPickerText = _vm.depositMethodList.keys.first;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        onSelectedMethod(methodPickerText);
      });
    }
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<DepositMethodViewModel>(
        model: _vm,
        builder: (ctx, vm, _) {
          _handleApiState();
          return Container(
            margin: EdgeInsets.all(10.auto),
            child: ListView(
              children: [
                _buildCard("deposit_method", _vm.depositMethodList.keys.toList(), isDepositMethod: true),
                _buildCard("deposit_channel", _vm.paymentList),
                if (_isManualDeposit()) _buildBankNameTextField(),
                _buildAmountTextField(),
                _buildButton(),
              ],
            ),
          );
        });
  }

  _buildCard(String title, List<dynamic> list, {bool isDepositMethod = false}) {
    return Container(
        margin: EdgeInsets.only(top: 10.auto),
        child: Opacity(
          opacity: 1,
          child: CustomPicker(
            title: title,
            displayText: isDepositMethod ? methodPickerText : channelPickerText ?? "",
            //isDeposit? depositText??"请选择红利": pickerText?? "",
            list: list,
            isHintText: true,
            width: context.screenWidth,
            onClick: () {
              _buildBottomSheet(title, list);
            },
          ),
        ));
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
                  if (value is String)
                    onSelectedMethod(value);
                  else if (value is Payment) {
                    onSelectedChannel(
                      value,
                    );
                  }
                  /*ielse if(value is PaymentBank) onSelectedBank(value as PaymentBank);
                  else if(value is DepositBonusGroup) onSelectedDepositGroup(value as DepositBonusGroup);
                  else if(value is DepositBonus) onSelectedDeposit(value as DepositBonus);*/
                  Navigator.pop(context);
                });
              });
        });
  }

  _buildAmountTextField() => Container(
        margin: EdgeInsets.only(top: 10.auto),
        child: CustomTextFormField(
          title: getTranslatedText("deposit_amount") ?? "",
          hintText: getTranslatedText("enter") +
              (Format().amountFormat(paymentMin) ?? "10.00") +
              "-" +
              (Format().amountFormat(paymentMax) ?? "100,000") +
              getTranslatedText("yuan"),
          onChanged: (value) => onTextChange(),
          onFieldSubmitted: (value) => onTextChange(),
          controller: _amountController,
          width: context.screenWidth - 70.auto,
          textInputType: TextInputType.number,
          textInputAction: TextInputAction.done,
        ),
      );

  _buildBankNameTextField() => Container(
        margin: EdgeInsets.only(top: 10.auto),
        child: CustomTextFormField(
          title: getTranslatedText("bank_name"),
          hintText: getTranslatedText("enter_bank_name"),
          onChanged: (value) => onTextChange(),
          onFieldSubmitted: (value) => onTextChange(),
          controller: _bankNameController,
          width: context.screenWidth - 70.auto,
          textInputType: TextInputType.text,
          textInputAction: TextInputAction.next,
        ),
      );

  _buildButton() => Container(
      margin: EdgeInsets.only(
        left: 10.auto,
        right: 10.auto,
        top: 15.auto,
      ),
      child: ColorButton(
        onClick: () => _onClick(),
        text: Text(
          getTranslatedText("next"),
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 16.auto),
        ),
        color: CustomColor.theme_bar_gradient_2,
        radius: 9.6,
        isEnabled: isButtonEnabled,
      ));

  onTextChange() {
    if (_isManualDeposit()) {
      if (_amountController.text != null &&
          _amountController.text.isNotEmpty &&
          _bankNameController.text != null &&
          _bankNameController.text.isNotEmpty) {
        amount = int.parse(_amountController.text);
        if (amount >= paymentMin && amount <= paymentMax) {
          setState(() {
            isButtonEnabled = true;
          });
        }
      }
    } else if (_amountController.text != null && _amountController.text.isNotEmpty) {
      amount = int.parse(_amountController.text);
      if (amount >= paymentMin && amount <= paymentMax) {
        setState(() {
          isButtonEnabled = true;
        });
      }
    } else {
      setState(() {
        isButtonEnabled = false;
      });
    }
  }

  _onClick() {
    ProgressDialog.show(context);
    if (_isManualDeposit())
      _vm.getManualDepositId(_bankNameController.text, _amountController.text, _payment.id);
    else //currently is LeePay
      _vm.leePayDepositOrder(_amountController.text, _payment.id);
  }

  _isManualDeposit() {
    return widget.paymentCode == "Manual";
  }

  onSelectedMethod(String method) async {
    _vm.filterMethod(method);
    onSelectedChannel(_vm.paymentList.first);
    setState(() {
      methodPickerText = method;
    });
  }

  onSelectedChannel(Payment payment) {
    setState(() {
      _payment = payment;
      channelPickerText = payment.channelName.replaceAll("_", " ");
      paymentMin = payment.transferLimit.from;
      paymentMax = payment.transferLimit.to;
    });
  }

  _handleApiState() {
    handleApiState(_vm.getLeepayOrderApiState, isRequireResult: true, onSuccess: (result) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DepositOrderView(
                      method: _payment.methodCode,
                      depositRedirect: _vm.getLeepayOrderApiState.result,
                      depositAmount: Format().currencySymbolWithDecimalFormat(double.parse(_amountController.text)),
                      depositChannel: channelPickerText,
                    )));
      });
    });

    handleApiState(_vm.getManualDepositIdApiState, isRequireResult: true, onSuccess: (result) {
      paymentChannelId = result;
    });
    handleApiState(_vm.getDepositOrderApiState, onSuccess: () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DepositOrderView(
                      method: _payment.methodCode,
                      id: paymentChannelId,
                      manualDepositOrder: _vm.getDepositOrderApiState.result,
                      payUsername: _bankNameController.text,
                      depositAmount: Format().currencySymbolWithDecimalFormat(double.parse(_amountController.text)),
                      depositChannel: channelPickerText,
                    )));
      });
    });
  }
}
