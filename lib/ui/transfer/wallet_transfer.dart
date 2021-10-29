import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:lottie/lottie.dart';
import 'package:tgp_flutter/custom/color_button.dart';
import 'package:tgp_flutter/custom/custom_dialog.dart';
import 'package:tgp_flutter/custom/custom_picker.dart';
import 'package:tgp_flutter/custom/custom_picker_dialog.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_text_form_field.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/custom/gradient_button.dart';
import 'package:tgp_flutter/entity/game_provider.dart';
import 'package:tgp_flutter/entity/wallet.dart';
import 'package:tgp_flutter/extension/format.dart';
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

class _WalletTransferState extends BaseState<WalletTransfer> with TickerProviderStateMixin {
  WalletTransferViewModel _vm = WalletTransferViewModel();
  var _amountController = TextEditingController();
  var isEnabled = false, isMaxAmountButtonEnabled = false;

  Wallet fromWallet, toWallet;
  String textFromWallet, textToWallet;
  var transferAmount;
  FocusNode _focusNode = FocusNode();
  var _key = GlobalKey();
  AnimationController _controller;
  Animation<double> _animation;
  int amount;
  bool toggleValue = false;

  @override
  void dispose() {
    _controller.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void initState() {
    //_focusNode.addListener(checkButtonState);
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (_vm.isFetchingBalance) _controller.forward(from: 0.0);
      }
    });
    _vm.getAllWallet();
    _vm.getAutoTransferValue();
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
                        _getAutoTransferToggleButton(),
                        _buildWalletGridView(),
                        //_buildHintText(),
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
        Navigator.pop(context, true);
      },
    ),
    actions: [
      Container(
        margin: EdgeInsets.all(10.auto),
        alignment: Alignment.center,
        child: RotationTransition(
          turns: _animation,
          child: IconButton(
            icon: Image.asset("images/ic_refresh.png"),
            onPressed: () {
              _vm.getAllWallet();
            },
          ),
        ),
      ),
    ],
    title: Text(
      getTranslatedText("transfer"),
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
                  Container(
                    margin: EdgeInsets.only(top: 3.auto),
                    child: Text(
                      getTranslatedText("main_wallet"),
                      style: TextStyle(fontSize: 8.auto),
                    ),
                  )
                  /*Image.asset(
                        "images/transfer/ic_question.png",
                        width: 12.auto,
                        height: 12.auto,
                      ),*/
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 15.auto),
            alignment: Alignment.centerLeft,
            child: Text(
              "¥ ${Format().amountFormat(_vm.userMainWalletBalance) ?? ""}",
              style: TextStyle(fontSize: 12.auto),
            ),
          ),
          Spacer(),

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
        children: List.generate(_vm.gameWalletList.length, (index) {
          return _buildWalletTransferItem(_vm.gameWalletList[index]);
        }),
      ),
    ),
  );

  _buildWalletTransferItem(Wallet wallet) => InkWell(
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
          wallet.title,
          style: TextStyle(fontSize: (12.5).auto, color: CustomColor.theme_title_text_color),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.auto),
          child: Text(
            wallet.balance != null ? Format().amountFormat(wallet.balance) : "",
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
      getTranslatedText("wallet_transfer_hint"),
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
            title: getTranslatedText("transfer_from"),
            displayText: textFromWallet ?? getTranslatedText("please_select"),
            list: [],
            isHintText: textFromWallet == null|| textFromWallet == getTranslatedText("please_select"),
            width: (context.screenWidth / 2) - 75.auto,
            onClick: () {
              _buildPicker("transfer_from", _vm.walletList, true);
            }),
        Image.asset(
          "images/transfer/ic_transfer_to.png",
          width: 21.auto,
        ),
        CustomPicker(
            title: getTranslatedText("transfer_to"),
            displayText: textToWallet ?? getTranslatedText("please_select"),
            list: [],
            isHintText: textToWallet == null || textToWallet == getTranslatedText("please_select"),
            width: (context.screenWidth / 2) - 75.auto,
            onClick: () {
              _buildPicker("transfer_to", _vm.walletList, false);
            }),
      ],
    ),
  );

  _buildPicker(String title, List<Wallet> list, bool isFrom) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return CustomPickerDialog(
              title: title,
              list: list,
              onChanged: (value) {
                setState(() {
                  /*  if (isFrom) {
                    if (toWallet != null && value.gpCode == toWallet.gpCode)
                      CustomToast.show("不能转账去同样的钱包！");
                    else
                      setFromWallet(value);
                  } else {
                    if (fromWallet != null && value.gpCode == fromWallet.gpCode)
                      CustomToast.show("不能转账去同样的钱包！");
                    else
                      setToWallet(value);
                  }*/
                  if (isFrom) {
                    if (!value.isMainWallet)
                      setToWallet(list.first);
                    else
                      setToWallet(fromWallet != null
                          ? fromWallet.isMainWallet
                          ? null
                          : fromWallet
                          : null);
                    setFromWallet(value);
                  } else {
                    if (!value.isMainWallet)
                      setFromWallet(list.first);
                    else
                      setFromWallet(toWallet != null
                          ? toWallet.isMainWallet
                          ? null
                          : toWallet
                          : null);
                    setToWallet(value);
                  }
                  checkButtonState();
                  Navigator.pop(context);
                });
              });
        });
  }

  _buildAmountTextFormField() => Container(
      padding: EdgeInsets.only(top: 10.auto),
      child: CustomTextFormField(
        title: getTranslatedText("amount"),
        hintText: getTranslatedText("enter_amount"),
        onChanged: (value) {
          checkButtonState();
        },
        onFieldSubmitted: (value) {},
        controller: _amountController,
        focusNode: _focusNode,
        width: context.screenWidth - 140.auto,
        button: Container(
          key: _key,
          child: ColorButton(
            onClick: this.getMaxAmount,
            isEnabled: isMaxAmountButtonEnabled,
            radius: 4.8,
            color: CustomColor.theme_bar_gradient_2,
            width: 40.auto,
            height: 25.auto,
            text: Container(
              width: 56.auto,
              child: AutoSizeText(
                getTranslatedText("max_amount"),
                style: TextStyle(color: Colors.white),
                minFontSize: 5,
                maxFontSize: 12,
                stepGranularity: 1,
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
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
          getTranslatedText("confirm"),
          style: TextStyle(fontSize: (16.2).auto, color: Colors.white),
        ),
        onClick: () {
          onClick();
        },
        isEnabled: isEnabled,
        radius: 9.6,
        color: CustomColor.theme_bar_gradient_2,
      ),
    ),
  );

  _getAutoTransferToggleButton() => Container(
    margin: EdgeInsets.only(right: 10.auto, top: 5.auto, bottom: 2.auto),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(margin: EdgeInsets.only(right: 10.auto), child: Text(getTranslatedText("auto_transfer"))),
        FlutterSwitch(
          value: _vm.autoTransferValue ?? false,
          width: 35,
          height: 17.5,
          toggleSize: 17.5,
          padding: 2,
          activeColor: CustomColor.theme_bar_gradient_2,
          onToggle: (val) {
            _vm.setAutoTransferValue();
          },
        ),
      ],
    ),
  );

  getMaxAmount() {
    setState(() {
      _amountController.text =
          _vm.walletList.singleWhere((e) => e.gpCode == fromWallet.gpCode).balance.floor().toString() ?? "";
      checkButtonState();
    });
  }

  setFromWallet(Wallet wallet) {
    fromWallet = wallet;
    if (wallet == null)
      textFromWallet = getTranslatedText("please_select");
    else {
      textFromWallet = (getTranslatedText(wallet.title) ?? wallet.title) ?? getTranslatedText("please_select");
      setState(() {
        isMaxAmountButtonEnabled = true;
      });
    }
  }

  setToWallet(Wallet wallet) {
    toWallet = wallet;
    if (wallet == null)
      textToWallet = getTranslatedText("please_select");
    else
      textToWallet = (getTranslatedText(wallet.title) ?? wallet.title) ?? getTranslatedText("please_select");
  }

  checkButtonState() {
    if (_amountController.text.isNotEmpty) {
      amount = int.parse(_amountController.text);
    } else
      amount = 0;
    if (fromWallet == null || toWallet == null || amount == 0 || amount > fromWallet.balance) {
      setState(() {
        isEnabled = false;
      });
      return;
    } else {
      setState(() {
        isEnabled = true;
      });
    }
  }

  onClick() {
    if (fromWallet == null || toWallet == null || _amountController.text.isEmpty) {
      return;
    } else {
      setState(() {
        ProgressDialog.show(context, _vm.brandLogoUrl);
        final isFundOut = fromWallet.isMainWallet;
        final gpCode = isFundOut ? toWallet.gpCode : fromWallet.gpCode;
        _vm.transferWallet(gpCode, int.parse(_amountController.text), isFundOut);
      });
    }
  }

  clearData() {
    setFromWallet(null);
    setToWallet(null);
    isEnabled = false;
    FocusScope.of(context).requestFocus(new FocusNode());
    _amountController.clear();
  }

  _handleApiState() {
    if (_vm.isFetchingBalance) {
      if (!_controller.isAnimating) _controller.forward(from: 0.0);
    }
    handleApiState(_vm.transferWalletApiState, onSuccess: () {
      CustomToast.show(getTranslatedText("success"));

      WidgetsBinding.instance.addPostFrameCallback((_) {
        clearData();
      });
    });
    handleApiState(_vm.setAutoTransferApiState, onSuccess: () {});
    handleApiState(_vm.getAutoTransferApiState, onSuccess: () {});
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
}