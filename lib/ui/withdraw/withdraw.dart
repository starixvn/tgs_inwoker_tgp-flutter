import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/color_button.dart';
import 'package:tgp_flutter/custom/custom_picker.dart';
import 'package:tgp_flutter/custom/custom_picker_dialog.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_text_form_field.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/custom/red_button.dart';
import 'package:tgp_flutter/extension/format.dart';
import 'package:tgp_flutter/extension/navigate_without_animation.dart';
import 'package:tgp_flutter/my_behavior.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/withdraw/withdraw_dialog.dart';
import 'package:tgp_flutter/ui/withdraw/withdraw_view_model.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/ui/base_state.dart';

class Withdraw extends StatefulWidget {
  @override
  _WithdrawState createState() => _WithdrawState();
}

class _WithdrawState extends BaseState<Withdraw> {
  var _vm = WithdrawViewModel();

  //UserProfile user;
  var isDetailsButtonEnabled = false, isNextButtonEnabled = false;
  var selectedBankCard;
  TextEditingController _amountController = TextEditingController(), _payPasswordController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //_vm.getWithdrawalInfo();
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return ProviderWidget<WithdrawViewModel>(
        model: _vm,
        builder: (ctx, vm, _) {
          _handleApiState();
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(),
            body:
                /*_vm.withdrawalInfo ==null || _vm.bankCardList == null?
            Center(
              child: CircularProgressIndicator(),
            ):*/
                Container(
              padding: EdgeInsets.only(left: 10.auto, right: 10.auto, bottom: MediaQuery.of(context).viewInsets.bottom),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  )),
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: ListView(
                  children: [
                    _buildWithdrawCard(),
                    _buildEditBankItem(),
                    _buildBankPicker(),
                    _buildTextField("金额", "请输入100-450，000元", _amountController),
                    _buildTextField("提款密码", "请输入提款密码", _payPasswordController),
                    _buildHintText(),
                    _buildButton(),
                    _buildCustomerServiceText()
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, NavigateWithoutAnimation());
          },
        ),
        flexibleSpace: Container(
          decoration: gradientDecoration,
        ),
        actions: [
          Container(
              margin: EdgeInsets.only(right: 15.auto),
              alignment: Alignment.center,
              child: Text(
                "¥ 0.00",
                /*_vm.mainAccountBalance ==null?"-":"¥ ${Format().currencyWithDecimalFormat(
                          _vm.mainAccountBalance)}",*/
                style: TextStyle(color: Colors.white),
              )),
        ],
        title: Text(
          "提款",
          style: TextStyle(fontSize: 20.auto),
        ),
      );

  _buildWithdrawCard() => Container(
        padding: EdgeInsets.only(top: 15.auto),
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 5,
          child: Column(
            children: [
              _buildWithdrawItem("可提资金", "0.00"
                  //Format().currencyWithDecimalFormat(double.parse(_vm.withdrawalInfo.canWithdrawal))
                  ),
              _buildWithdrawItem("未完成流水", "0.00"
                  //Format().currencyWithDecimalFormat(double.parse(_vm.withdrawalInfo.limitTurnover))
                  ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildWithdrawItem("红利限额", "0.00"
                      //Format().currencyWithDecimalFormat(double.parse(_vm.withdrawalInfo.bonusLimitWithdrawal))
                      ),
                  Container(
                    margin: EdgeInsets.only(right: 10.auto),
                    child: RedButton(
                      title: "查看详情",
                      onClick: this.onDetailsClick,
                      isEnabled: true,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      );

  _buildWithdrawItem(String title, String amount) => Container(
        margin: EdgeInsets.symmetric(vertical: 10.auto),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 3,
              height: 20.auto,
              color: Colors.black,
              margin: EdgeInsets.symmetric(vertical: 5.auto, horizontal: 15.auto),
              alignment: Alignment.topCenter,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: CustomColor.grey, fontSize: 14.auto),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5.auto),
                  child: Text(
                    "¥ $amount",
                    style: TextStyle(color: CustomColor.theme_bar_gradient_2, fontSize: 12.auto),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            )
          ],
        ),
      );

  _buildEditBankItem() => Container(
        padding: EdgeInsets.symmetric(vertical: 10.auto),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Image.asset(
            "images/ic_edit_card.png",
            width: 15.auto,
            height: 15.auto,
          ),
          Text(
            "管理银行卡",
            style: TextStyle(color: CustomColor.grey, fontSize: 12.auto),
          )
        ]),
      );

  _buildBankPicker() => CustomPicker(
        title: "银行卡",
        displayText: _getBankText() ?? "请选择银行卡",
        list: [],
        isHintText: //selectedBankCard !=null || _vm.bankCardList.first !=null ?
            true,
        //:false,
        width: context.screenWidth,
        onClick: () {
          //_buildPickerDialog("银行卡", _vm.bankCardList);
        },
      );

/*  _buildPickerDialog(String title, List<BankCard> list) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return CustomPickerDialog(title: title, list: list,
              onChanged: (value) {
                setState(() {
                  selectedBankCard = value;
                  Navigator.pop(context, NavigateWithoutAnimation());
                });
              }
          );
        }
    );
  }*/

  _getBankText() {
    if (selectedBankCard == null) {
      //selectedBankCard = _vm.bankCardList.first;
    }
    return selectedBankCard?.getDisplayString();
  }

  _buildTextField(String titleText, String hintText, TextEditingController controller) => CustomTextFormField(
        title: titleText,
        hintText: hintText,
        onChanged: (value) => onTextChange(value),
        onFieldSubmitted: (value) => onTextChange(value),
        controller: controller,
        focusNode: null,
        width: context.screenWidth - 70.auto,
        textInputType: TextInputType.number,
        textInputAction: TextInputAction.done,
      );

  _buildHintText() => Container(
        margin: EdgeInsets.symmetric(vertical: 10.auto, horizontal: 15.auto),
        child: Text(
          "此银行卡的开户名必须与您帐号所填写真实姓名一致，否则提款可能失败",
          style: TextStyle(color: Colors.red, fontSize: 11.auto),
        ),
      );

  _buildCustomerServiceText() => Container(
        margin: EdgeInsets.symmetric(vertical: 15.auto),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "如有任何问题，请联系",
              style: TextStyle(fontSize: 12.auto),
            ),
            Text(
              "线上客服",
              style: TextStyle(color: CustomColor.theme_bar_gradient_2, fontSize: 12.auto),
            )
          ],
        ),
      );

  _buildButton() => ColorButton(
        onClick: this.onNextButtonClick,
        isEnabled: isNextButtonEnabled,
        radius: 9.6,
        color: CustomColor.theme_bar_gradient_2,
        text: Text(
          "下一步",
          style: TextStyle(color: Colors.white, fontSize: 16.auto),
        ),
      );

  onDetailsClick() {
    showDialog(
      context: context,
      builder: (BuildContext context) => WithdrawDialog(),
    );
  }

  onTextChange(String amount) {
    if (amount.isNotEmpty) {
      setState(() {
        isNextButtonEnabled = true;
      });
    } else {
      setState(() {
        isNextButtonEnabled = false;
      });
    }
  }

  onNextButtonClick() {
    ProgressDialog.show(context);
    //_vm.withdraw(selectedBankCard.id, int.parse(_textEditingController.text));
  }

  _handleApiState() {
    /*if (_vm.withdrawalApiState == null &&
        _vm.getWithdrawalInfoApiState == null) {
      return;
    }
    if ((_vm.withdrawalApiState?.isError ?? false)) {
      CustomToast.show(_vm.withdrawalApiState.error);
       ProgressDialog.hide();
      FocusScope.of(context).requestFocus(FocusNode());
      _vm.resetApiState(isWithdrawalApiState: true);
    }
    if ((_vm.getWithdrawalInfoApiState?.isError ?? false)) {
      CustomToast.show(_vm.getWithdrawalInfoApiState.error);
      _vm.resetApiState(isGetWithdrawalInfoApiState: true);
    }
    if((_vm.withdrawalApiState?.isSuccess ?? false)){
       ProgressDialog.hide();
      FocusScope.of(context).requestFocus(FocusNode());
      _vm.resetApiState(isWithdrawalApiState: true);
    }*/
  }
}
