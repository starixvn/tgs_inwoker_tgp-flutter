import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/color_button.dart';
import 'package:tgp_flutter/custom/custom_picker.dart';
import 'package:tgp_flutter/custom/custom_picker_dialog.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_text_form_field.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/entity/payment.dart';
import 'package:tgp_flutter/extension/format.dart';
import 'package:tgp_flutter/extension/navigate_without_animation.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/deposit/deposit_order_view.dart';
import 'package:tgp_flutter/ui/deposit/deposit_view_model.dart';
import 'package:tgp_flutter/ui/deposit/deposit_web.dart';

class DepositMethod extends StatefulWidget {
  @override
  _DepositMethodState createState() => _DepositMethodState();
}

class _DepositMethodState extends BaseState<DepositMethod> {
  String methodPickerText, channelPickerText;
  TextEditingController _amountController = TextEditingController(), _bankNameController = TextEditingController();
  var isButtonEnabled = false;
  var selectedPayment;
  var paymentMin, paymentMax;
  int amount;
  FocusNode _focusNode = FocusNode(), _focusNode2  = FocusNode();
  var onClick = false;
  Payment _payment;
  var _vm = DepositViewModel();
  var paymentChannelId;

  void initState() {
    methodPickerText = _vm.pMethod;
    onSelectedMethod(methodPickerText);
    _focusNode.addListener(onTextChange);
    super.initState();
  }

  Widget build(BuildContext context) {
    return ProviderWidget<DepositViewModel>(
        model: _vm,
        builder: (ctx, vm, _) {
          _handleApiState();
          return /*_vm.isLoading?Center(child: CircularProgressIndicator(),):*/ Container(
            margin: EdgeInsets.all(10.auto),
            child: ListView(
              children: [
                _buildCard("deposit_method", _vm.depositMethodList.keys.toList(), isDepositMethod: true),
                _buildCard("deposit_channel", _vm.paymentList),
                _buildBankNameTextField("银行账号名称", "请输入银行账号名称"),
                _buildAmountTextField("deposit_amount", paymentMin, paymentMax),
                _buildButton(),
                Container(
                    width: context.screenWidth,
                    margin: EdgeInsets.only(
                      left: 20.auto,
                      right: 20.auto,
                      bottom: 10.auto,
                      top: 15.auto,
                    ),
                    child: Text(
                      "温性提醒 \n "
                      "1.存款完成，请勿关闭操作页面， 以确保账作业顺利。"
                      "\n 2.请您直接在弹出的银行页面上完成存款。"
                      "\n 3.因建行网银接口维护，请该用其他银行存款。",
                      style: TextStyle(color: CustomColor.grey, fontSize: 11.auto),
                    )),
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
                  Navigator.pop(context, NavigateWithoutAnimation());
                });
              });
        });
  }

  _buildAmountTextField(String title, double paymentMin, double paymentMax) => Container(
        margin: EdgeInsets.only(top: 10.auto),
        child: CustomTextFormField(
          title: getTranslatedText(title) ?? "",
          hintText:
              "请输入${Format().amountFormat(paymentMin) ?? "10.00"}-${Format().amountFormat(paymentMax) ?? "100,000"}元",
          onChanged: (value){},
          onFieldSubmitted: (value) => onTextChange(),
          controller: _amountController,
          focusNode: _focusNode,
          width: context.screenWidth - 70.auto,
          textInputType: TextInputType.number,
          textInputAction: TextInputAction.done,
        ),
      );

  _buildBankNameTextField(String title, String hintText) => Container(
        margin: EdgeInsets.only(top: 10.auto),
        child: CustomTextFormField(
          title: title,
          hintText: hintText,
          onChanged: (value){},
          onFieldSubmitted: (value){
            FocusScope.of(context).requestFocus(_focusNode);
          },
          controller: _bankNameController,
          focusNode: _focusNode2,
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
        onClick:() => _onClick(),
        text: Text(
          "Next",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 16.auto),
        ),
        color: CustomColor.theme_bar_gradient_2,
        radius: 9.6,
        isEnabled: isButtonEnabled,
      ));

  onTextChange() {
    if(_amountController.text !=null&& _amountController.text.isNotEmpty){
      amount = int.parse(_amountController.text);
      if (amount >= paymentMin &&
          amount <= paymentMax &&
          (_bankNameController.text != null || _bankNameController.text.isNotEmpty)) {
        setState(() {
          isButtonEnabled = true;
        });
      } else {
        setState(() {
          isButtonEnabled = false;
        });
      }
    }
  }

  _onClick() {
    ProgressDialog.show(context);
    _vm.getManualDepositId(_bankNameController.text, _amountController.text, _payment.id);
  }

  onSelectedMethod(String method) async {
    await _vm.filterMethod(method: method);
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
    handleApiState(_vm.getPaymentApiState, isAutoHideLoading: false, onSuccess: () {});
    handleApiState(_vm.getManualDepositIdApiState, onSuccess: () {
      paymentChannelId = _vm.getManualDepositIdApiState.result;
    });
    handleApiState(_vm.getDepositOrderApiState, onSuccess: () {
      ProgressDialog.hide();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.push(
            context,
            NavigateWithoutAnimation(
                widget: DepositOrderView(
                  method: _payment.methodCode,
                  deposit: _vm.getDepositOrderApiState.result,
                  id : paymentChannelId
                )));
      });
    });
  }
}
