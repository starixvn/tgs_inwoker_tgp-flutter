import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/color_button.dart';
import 'package:tgp_flutter/custom/custom_picker.dart';
import 'package:tgp_flutter/custom/custom_picker_dialog.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_text_form_field.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/deposit/deposit_order_fragment.dart';
import 'package:tgp_flutter/ui/deposit/deposit_view_model.dart';
import 'package:tgp_flutter/ui/deposit/deposit_web.dart';
import 'package:progress_dialog/progress_dialog.dart';

class DepositMethod extends StatefulWidget{
  final List<dynamic> paymentList;
  final DepositViewModel vm;

  DepositMethod({
    this.paymentList,
    this.vm
  });

  @override
  _DepositMethodState createState() => _DepositMethodState();
}

class _DepositMethodState extends BaseState<DepositMethod> {
  String pickerText, bankText, bonusText, depositText;
  TextEditingController _textEditingController = TextEditingController();
  var isDepositEnabled = false,
      isButtonEnabled = false,
      isBankVisible = false,
      isDepositVisible = false,
      isBonusVisible = false;
  var selectedPayment, selectedBank, selectedDepositBonusGroup, selectedDepositBonus;
  var paymentMin, paymentMax;
  int amount;
  FocusNode _focusNode = FocusNode();
  var onClick = false;

  void initState(){
    //selectedPayment = widget.paymentList.first;
    //onSelectedPayment(selectedPayment);
    _focusNode.addListener(onTextChange);
    super.initState();
  }


  Widget build(BuildContext context) {
    _handleApiState();
    return /*widget.vm.isLoading?Center(child: CircularProgressIndicator(),):*/Container(
      margin:EdgeInsets.all(10.auto),
      child: ListView(
        children: [
          _buildCard("支付通道", ["ooo","yy"], true, true, false),
          isBankVisible? _buildCard("银行卡", [], isBankVisible, isBankVisible, false):Container(),
          _buildAmountCard("存款金额", "请输入$paymentMin-$paymentMax元"),
          isDepositVisible?_buildCard("申请红利", [], true, isDepositEnabled, true):Container(),
          //_buildCard("红利阶层", list, isBankVisible),
          _buildButton(),
          Container(
              width: context.screenWidth,
              margin:EdgeInsets.only(left:20.auto,right:20.auto,bottom:10.auto,top:15.auto,),
              child:Text("温性提醒 \n "
                  "1.存款完成，请勿关闭操作页面， 以确保账作业顺利。"
                  "\n 2.请您直接在弹出的银行页面上完成存款。"
                  "\n 3.因建行网银接口维护，请该用其他银行存款。",
                style: TextStyle(
                    color: CustomColor.grey,
                    fontSize: 11.auto
                ),)
          ),
        ],
      ),

    );
  }
  /* onSelectedPayment(Payment payment){
    selectedPayment = payment;
    setState(() {
      paymentMin = payment.min;
      paymentMax = payment.max;
      pickerText = payment.title;
    });
    if(payment.banks !=null && payment.banks.isNotEmpty)
      onSelectedBank(payment.banks.first);
  }

  onSelectedBank(PaymentBank paymentBank){
    selectedBank = paymentBank;
    if(selectedBank!=null) {
      isBankVisible = true;
      pickerText = paymentBank.bankName;
    }else
      bankText = "";
  }

  onSelectedDepositGroup(DepositBonusGroup depositBonusGroup){
    selectedDepositBonusGroup = depositBonusGroup;
    if(depositBonusGroup ==null){
      onSelectedDeposit(null);
      isBonusVisible = false;
    }else{
      //show arlet dialog
    }
  }

  onSelectedDeposit(DepositBonus depositBonus){
    selectedDepositBonus = depositBonus;
    pickerText = depositBonus.bospTitle;
    isBonusVisible =true;
  }*/

  _buildCard(String title, List<dynamic> list, bool isVisible, bool isEnabled, bool isDeposit) {
    if(isDeposit) _observeDepositList(list);
    return isVisible?Container(
        margin: EdgeInsets.only(top: 10.auto),
        child: Opacity(
          opacity: isEnabled? 1:0.5,
          child: CustomPicker(
            title: title,
            displayText: "支付",
            //isDeposit? depositText??"请选择红利": pickerText?? "",
            list: list,
            isHintText: isDeposit? (depositText==null?false:true):true,
            width: context.screenWidth,
            onClick:(){
              /*!isEnabled|| list==null||list.isEmpty? null:(){
              _buildBottomSheet(title, list);*/
            },
          ),
        )
    ):Container();
  }

  _buildBottomSheet(String title, List<dynamic> list){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return CustomPickerDialog(title: title, list: list,
              onChanged: (value){
                setState(() {
                  /*if(value is Payment) onSelectedPayment(value as Payment);
                  else if(value is PaymentBank) onSelectedBank(value as PaymentBank);
                  else if(value is DepositBonusGroup) onSelectedDepositGroup(value as DepositBonusGroup);
                  else if(value is DepositBonus) onSelectedDeposit(value as DepositBonus);*/
                  Navigator.pop(context);
                });
              }
          );
        }
    );
  }

  _buildAmountCard(String title, String hintText)=> Container(
    margin: EdgeInsets.only(top: 10.auto),
    child: CustomTextFormField(
      title: title??"",
      hintText: hintText,
      onChanged:(value){
        onClick = true;
      },
      onFieldSubmitted:(value) => onTextChange(),
      controller: _textEditingController,
      focusNode: _focusNode,
      width:context.screenWidth-70,
      textInputType: TextInputType.number,
      textInputAction: TextInputAction.done,
    ),
  );

  _buildButton() => Container(
      margin:EdgeInsets.only(left:10.auto,right:10.auto,top:15.auto,),
      child: ColorButton(
        onClick: null,
        text: Text(
          "Next",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: 16.auto
          ),
        ),
        color: CustomColor.theme_bar_gradient_2,
        radius: 9.6,
        isEnabled: isButtonEnabled,
      )
  );

  void onTextChange(){
    if(!_focusNode.hasFocus && onClick){
      amount = int.parse(_textEditingController.text??"");
      if(amount >=paymentMin && amount<=paymentMax) {
        setState(() {
          CustomProgressDialog.show(context);
          isDepositEnabled = true;
          isButtonEnabled = true;
          //widget.vm.getDepositActs(amount);
        });
        onClick = false;
      }
      else {
        setState(() {
          isDepositEnabled = false;
          isButtonEnabled = false;
        });
      }
    }
  }

  onButtonClick(){
    CustomProgressDialog.show(context);
    //widget.vm.deposit(selectedPayment.id, amount, selectedDepositBonus?.bospId, selectedBank?.id,);
  }

  _observeDepositList(List<dynamic> list){
    /*if (list == null || list.isEmpty) {
      if (widget.vm.isDepositHandled) {
        setState(() {
          FocusScope.of(context).requestFocus(FocusNode());
          CustomProgressDialog.hide();
          isDepositEnabled = false;
          depositText = "无可选择红利";
        });
        widget.vm.markIsDepositHandled();
      }
    }
    else {
      setState(() {
        FocusScope.of(context).requestFocus(FocusNode());
        CustomProgressDialog.hide();
        isDepositEnabled = true;
        depositText = list.first.depositBonus.bospTitle;
      });
    }*/
  }

  _handleApiState() {
    /*if(widget.vm.depositApiState == null&& widget.vm.getDepositActsApiState == null) return;
    if ((widget.vm.depositApiState?.isError ?? false) ) {
      CustomToast.show(widget.vm.depositApiState.error);
      widget.vm.resetApiState(true, false, false);
    }
    if ((widget.vm.getDepositActsApiState?.isError ?? false) ) {
      CustomToast.show(widget.vm.getDepositActsApiState.error);
      widget.vm.resetApiState(false, true, false);
    }
    if(widget.vm.depositApiState?.isSuccess ?? false){
      WidgetsBinding.instance.addPostFrameCallback((_){
        var order = Order.convertByDepositResponseAndPayment(widget.vm.depositResponse, selectedPayment);
        var param = widget.vm.depositResponse.params;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DepositOrderFragment(
                      order: order,
                      params: param==null?null:"oid=${param.oid}&cid=${param.cid}",
                    )
            ));
      });
      widget.vm.resetApiState(true, false, false);
    }
    if(!(widget.vm.isLoading)){
      CustomProgressDialog.hide();
    }*/
  }
}