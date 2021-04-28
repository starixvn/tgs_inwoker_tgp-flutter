import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/color_button.dart';
import 'package:tgp_flutter/custom/custom_picker.dart';
import 'package:tgp_flutter/custom/custom_picker_dialog.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_text_form_field.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/custom/gradient_button.dart';
import 'package:tgp_flutter/extension/format.dart';
import 'package:tgp_flutter/extension/navigate_without_animation.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/transfer/wallet_transfer_view_model.dart';

import '../../my_behavior.dart';

class WalletTransfer extends StatefulWidget {
  @override
  _WalletTransferState createState() => _WalletTransferState();
}

class _WalletTransferState extends BaseState<WalletTransfer> {
  WalletTransferViewModel _vm = WalletTransferViewModel();
  var amount = TextEditingController();
  var isEnabled = false, isMaxAmountButtonEnabled = false;

  //Wallet fromWallet, toWallet;
  String textFromWallet, textToWallet;
  var transferAmount;
  FocusNode _focusNode = FocusNode();
  var mainWalletBalance, noneMainWalletList;
  var _key = GlobalKey();

  @override
  void dispose() {
    amount.dispose();
    super.dispose();
  }

  void initState() {
    //_focusNode.addListener(checkButtonState);
    super.initState();
  }

  Widget build(BuildContext context) {
    return ProviderWidget<WalletTransferViewModel>(
        model: _vm,
        builder: (ctx, vm, _) {
          _handleApiState();
          //updateData();
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.grey[100],
            appBar: _buildAppBar(),
            body:
                /*_vm.walletList ==null|| mainWalletBalance==null ||noneMainWalletList==null?
            Center(child: CircularProgressIndicator()):*/
                ScrollConfiguration(
              behavior: MyBehavior(),
              child: SingleChildScrollView(
                  reverse: true,
                  child: Container(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        _buildWalletDetails(),
                        _buildWalletGridView(),
                        _buildHintText(),
                        _buildTransferAccount(),
                        _buildAmountTextFormField(),
                        _buildButton()
                      ],
                    ),
                  )),
            ),
          );
        });
  }

  _buildAppBar() => AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: gradientDecoration,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, NavigateWithoutAnimation());
          },
        ),
        actions: [
          Container(
            margin: EdgeInsets.all(10.auto),
            alignment: Alignment.center,
            child: IconButton(
              icon: Image.asset("images/ic_refresh.png"),
              onPressed: () {
                ProgressDialog.show(context);
                //_vm.getAllWallet();
              },
            ),
          ),
        ],
        title: Text(
          "转账",
          style: TextStyle(fontSize: 20.auto),
        ),
      );

  _buildWalletDetails() => Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(left: (25.5).auto, top: 15.auto, right: 10.auto, bottom: 10.auto),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  _buildWalletIcon(),
                  Row(
                    children: [
                      Text(
                        "主账户",
                        style: TextStyle(fontSize: 8.auto),
                      ),
                      Image.asset(
                        "images/transfer/ic_question.png",
                        width: 12.auto,
                        height: 12.auto,
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 15.auto),
                alignment: Alignment.centerLeft,
                child: Text(
                  mainWalletBalance ?? "¥ 0.00",
                  style: TextStyle(fontSize: 12.auto),
                ),
              ),
              Spacer(),
              GradientButton(
                isEnabled: true,
                onClick: () {
                  /*setState(() {
                _vm.transferAllToMainWallet();
                _vm.getAllWallet();
                updateData();
                 ProgressDialog.show(context);
              });*/
                },
                radius: 4.8,
                title: "Collect All",
                height: 23.0,
                fontSize: (10.5).auto,
                width: 68.auto,
              )
            ],
          ),
        ),
      );

  _buildWalletIcon() => CircleAvatar(
        backgroundColor: CustomColor.theme_bar_gradient_2,
        child: Center(child: Image.asset("images/home/ic_deposit.png")),
      );

  _buildWalletGridView() => Container(
        padding: EdgeInsets.only(top: 10.auto),
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          child: GridView.count(
            //padding: EdgeInsets.only(bottom: 10.auto),
            padding: EdgeInsets.zero,
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
            children: List.generate(8, (index) {
              return _buildWalletTransferItem();
            }),
          ),
        ),
      );

  _buildWalletTransferItem(/*Wallet wallet*/) => InkWell(
        onTap: () {
          setState(() {
            /*setFromWallet(_vm.getMainWallet());
        setToWallet(wallet);
        amount.text = (Format().amountFormat(_vm.getMainWallet().balance)) ?? "";
        checkButtonState();*/
          });
        },
        splashColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "KY Games",
              style: TextStyle(fontSize: (12.5).auto, color: CustomColor.theme_title_text_color),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.auto),
              child: Text(
                Format().amountFormat(0.00),
                style: TextStyle(color: CustomColor.theme_bar_gradient_1),
              ),
            )
          ],
        ),
      );

  _buildHintText() => Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(5.auto),
        child: Text(
          "温馨提示：点击某平台可自选转入对象。",
          style: TextStyle(fontSize: 9.auto),
          textAlign: TextAlign.left,
        ),
      );

  _buildTransferAccount() => Container(
        padding: EdgeInsets.only(top: 5.auto),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomPicker(
                title: "转出账户",
                displayText: textFromWallet ?? "请选择",
                list: [],
                isHintText: textFromWallet == null ? false : true,
                width: (context.screenWidth / 2) - 75.auto,
                onClick: () {
                  _buildPicker("转出账户", true);
                }),
            Image.asset(
              "images/transfer/ic_transfer_to.png",
              width: 21.auto,
            ),
            CustomPicker(
                title: "转入账户",
                displayText: textToWallet ?? "请选择",
                list: [],
                isHintText: textToWallet == null ? false : true,
                width: (context.screenWidth / 2) - 75.auto,
                onClick: () {
                  _buildPicker("转入账户", false);
                }),
          ],
        ),
      );

  _buildPicker(String title, /*List<Wallet> list,*/ bool isFrom) {
    var list = [];
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return CustomPickerDialog(
              title: title,
              list: list,
              onChanged: (value) {
                setState(() {
                  /*if(isFrom){
                    if(toWallet!=null && value.id == toWallet.id) CustomToast.show("不能转账去同样的钱包！");
                    else setFromWallet(value);
                  }else{
                    if(fromWallet!=null && value.id == fromWallet.id) CustomToast.show("不能转账去同样的钱包！");
                    else setToWallet(value);
                  }*/
                  Navigator.pop(context, NavigateWithoutAnimation());
                });
              });
        });
  }

  _buildAmountTextFormField() => Container(
      padding: EdgeInsets.only(top: 10.auto),
      child: CustomTextFormField(
        title: "金额",
        hintText: "请输入转账金额",
        onChanged: (value) {},
        onFieldSubmitted: (value) {},
        controller: amount,
        focusNode: _focusNode,
        width: context.screenWidth - 140.auto,
        button: Container(
          key: _key,
          child: ColorButton(
            onClick: this.getMaxAmount,
            isEnabled: isMaxAmountButtonEnabled,
            radius: 4.8,
            color: null,
            width: 40.auto,
            height: 25.auto,
            text: Text(
              "最大金额",
              style: TextStyle(fontSize: 10.5, color: Colors.white),
            ),
          ),
        ),
        textInputType: TextInputType.number,
        textInputAction: TextInputAction.done,
      ));

  _buildButton() => Container(
        padding: EdgeInsets.only(top: 20.auto, left: 5.auto, right: 5.auto),
        width: context.screenWidth,
        child: Opacity(
          opacity: isEnabled ? 1 : 0.5,
          child: ColorButton(
            text: Text(
              "确认",
              style: TextStyle(fontSize: (16.2).auto, color: Colors.white),
            ),
            onClick: () {
              //onClick();
            },
            isEnabled: isEnabled,
            radius: 9.6,
            color: CustomColor.theme_bar_gradient_2,
          ),
        ),
      );

  getMaxAmount() {
    setState(() {
      amount.text = "";
      // amount.text = (Format().amountFormat(_vm.getTransferableWalletList().singleWhere((e) => e.id == fromWallet.id).balance))??"";
      //checkButtonState();
    });
  }

  /*setFromWallet(Wallet wallet){
    fromWallet = wallet;
    if(wallet ==null) textFromWallet = "请选择";
    else {
      textFromWallet = wallet?.name ?? "请选择";
      setState(() {
        isMaxAmountButtonEnabled = true;
      });
    }
  }

  setToWallet(Wallet wallet){
    toWallet = wallet;
    if(wallet ==null) textToWallet = "请选择";
    else textToWallet = wallet.name ?? "请选择";
  }*/

  _handleApiState() {
    /*if(_vm.transferAllToMainWalletApiState == null && _vm.transferWalletApiState == null&& _vm.getWalletApiState ==null) {
      return;
    }
    if (_vm.transferAllToMainWalletApiState?.isError ?? false) {
      CustomToast.show(_vm.transferAllToMainWalletApiState.error);
    }
    if (_vm.transferWalletApiState?.isError ?? false) {
      CustomToast.show(_vm.transferWalletApiState.error);
    }
    if(!(_vm.isLoading)){
       ProgressDialog.hide();
    }*/
  }

/*checkButtonState(){
    if(fromWallet == null || toWallet == null||amount.text.isEmpty){
      setState(() {
        isEnabled = false;
      });
      return;
    }else{
      setState(() {
        isEnabled = true;
      });
    }
  }

  onClick(){
    if(fromWallet == null || toWallet == null||amount.text.isEmpty){
      return;
    }else{
      setState(() {
         ProgressDialog.show(context);
        _vm.transferWallet(fromWallet.id, toWallet.id, double.parse(amount.text));
        _vm.getAllWallet();
        updateData();
        clearData();
      });
    }
  }

  updateData(){
    if(_vm.walletList!=null){
      mainWalletBalance = Format().currencyWithDecimalFormat(double.parse(_vm.getMainWallet().balance));
      noneMainWalletList = _vm.getNoneMainWalletList();
    }
  }

  clearData(){
    FocusScope.of(context).unfocus();
    amount.clear();
    setFromWallet(null);
    setToWallet(null);
    isEnabled = false;
  }*/
}
