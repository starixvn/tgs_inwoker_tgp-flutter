import 'package:auto_size_text/auto_size_text.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/custom_picker_dialog.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/entity/bank_card.dart';
import 'package:tgp_flutter/entity/bank_type.dart';
import 'package:tgp_flutter/extension/format.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/main.dart';
import 'package:tgp_flutter/my_behavior.dart';
import 'package:tgp_flutter/network/event_result.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/card/add_card.dart';

import 'card_view_model.dart';

class MainCard extends StatefulWidget {
  @override
  _MainCardState createState() => _MainCardState();
}

class _MainCardState extends BaseState<MainCard> {
  CardViewModel _vm = CardViewModel();
  var imagePath;
  var isNavigatedToVerifyName = false, isNavigatedToSetWithdrawPassword = false;
  bool isNavigatedToAddCard = false, isInitLoading = false;

  @override
  void initState() {
    _vm.getWithdrawalInfoList();
    _getBankCardList();
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
              backgroundColor: Colors.white,
              appBar: _buildAppBar(),
              body: _vm.bankCardList == null || _vm.bankCardList.length == 0
                  ? buildProgressDialog(_vm.brandLogoUrl)
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.auto),
                      child: ListView(
                        children: [
                          Wrap(
                            children: List.generate(_vm.bankCardList.length, (index) {
                              return Container(
                                  child: Dismissible(
                                key: UniqueKey(),
                                child: _buildBankCardItem(_vm.bankCardList[index]),
                                background: _swipeLeftBackground(),
                                direction: DismissDirection.endToStart,
                                behavior: HitTestBehavior.deferToChild,
                                onDismissed: (_) {
                                  _delete(_vm.bankCardList[index], index);
                                },
                              ));
                            }),
                          ),
                          _buildDeleteHintText(),
                          _buildAddCardItem(),
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
            /*Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => MyHomePage(
                          isFirstRun: false,
                          index: 4,
                        )),
                (Route<dynamic> route) => false);*/
            Navigator.pop(context);
          },
        ),
        title: Text(
          getTranslatedText("manage_card"),
          style: TextStyle(fontSize: 16.auto),
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

  _swipeLeftBackground() {
    return Container(
      margin: EdgeInsets.only(top: 10.auto),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Align(
        child: Container(
          padding: EdgeInsets.only(right: 50.auto),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.delete,
                color: Colors.white,
              ),
              Text(
                getTranslatedText("delete"),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  _buildBankCardItem(BankCard bankCard) => Container(
      margin: EdgeInsets.only(top: 10.auto),
      padding: EdgeInsets.only(left: 30.auto, right: 20.auto),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(image: AssetImage("images/card/card_bg.png"), fit: BoxFit.cover),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0.0, 3.0),
            spreadRadius: 0.0, //(x,y)
            blurRadius: 15.0,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 20.auto),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bankCard.bankType.getName(context),
                  style: TextStyle(fontSize: 11.auto),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.auto),
                  child: Text(
                    bankCard.bankType == BankType.CRYPTO ? (bankCard.bankDetail.address) : (bankCard.bankDetail.bankAccount ?? ""),
                    style: TextStyle(fontSize: 15.auto, color: CustomColor.theme_bar_gradient_2),
                  ),
                )
              ],
            ),
          )
        ],
      ));

  _buildDeleteHintText() => Container(
        margin: EdgeInsets.only(right: 23.auto, top: 10.auto),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ImageIcon(
              AssetImage(
                "images/card/ic_card_delete_hint.png",
              ),
              size: 15.auto,
              color: CustomColor.theme_button_disable_bg,
            ),
            Container(
              margin: EdgeInsets.only(left: 5.auto),
              child: Text(
                getTranslatedText("slide_to_delete_card"),
                style: TextStyle(fontSize: 9.auto, color: CustomColor.theme_button_disable_bg),
              ),
            ),
          ],
        ),
      );

  _buildAddCardItem() => InkWell(
    onTap: () async {
      await Navigator.of(context).pushNamed("/add_card");
      _getBankCardList(); //reinitdata after pop from  add card
    },
    child: Container(
      margin: EdgeInsets.only(top: 15.auto, left: 5.auto, right: 5.auto, bottom: 20.auto),
      child: FDottedLine(
          color: CustomColor.theme_button_disable_bg,
          height: 70.0,
          width: context.screenWidth,
          space: 2.0,
          corner: FDottedLineCorner.all(10.auto),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex:8,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 20.auto, horizontal: 20.auto),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        getTranslatedText("add_card"),
                        style: TextStyle(color: Colors.black),
                        minFontSize: 5,
                        stepGranularity: 1,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.auto),
                        child: AutoSizeText(
                          getTranslatedText("max_card_hint"),
                          style: TextStyle(color: CustomColor.theme_button_disable_bg),
                          minFontSize: 5,
                          maxFontSize: 11,
                          stepGranularity: 1,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.auto),
                    child: ImageIcon(
                        AssetImage(
                          "images/card/ic_add_card.png",
                        ),
                        size: 23.auto,
                        color: CustomColor.theme_button_disable_bg)),
              ),
            ],
          )),
    ),
  );

  _delete(BankCard card, int index) async {
    if (_vm.bankCardList.length > 1) //only show when existing list more than 1, else overlapped
      ProgressDialog.show(context, _vm.brandLogoUrl);
    setState(() {
      _vm.bankCardList.removeAt(index);
    });
    await _vm.deleteBankCard(card.id);
  }

  _getBankCardList() async {
    _vm.getBankCardList();
  }

  _checkBankCardListLength() async {
    if (_vm.bankCardList.length == 0) {
      var result = await Navigator.of(context).pushNamed("/add_card");
      if (result == null) //no result mean no card added
        Navigator.pop(context);
      else {
        _getBankCardList();
      } //fetch bank list
      return;
    }
  }

  _handleApiState() async {
    handleApiState(_vm.getBankCardListApiState, isAutoHideLoading: isInitLoading, onSuccess: () {
      if (!isInitLoading) {
        isInitLoading = true;
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _checkBankCardListLength(); //check card list every time fetched
      });
    });

    handleApiState(_vm.getWithdrawalInfoListApiState, isAutoHideLoading: false, onSuccess: (){});
    handleApiState(_vm.deleteBankCardApiState, isAutoHideLoading: false, onSuccess: (){});

  }
}
