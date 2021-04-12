import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/entity/bank_card.dart';
import 'package:tgp_flutter/extension/format.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';

import 'card_view_model.dart';

class MainCard extends StatefulWidget{
  @override
  _MainCardState createState() => _MainCardState();
}

class _MainCardState extends BaseState<MainCard> {
  CardViewModel _vm = CardViewModel();
  var imagePath;
  var isNavigatedToVerifyName =false, isNavigatedToSetWithdrawPassword = false;
  var isNavigatedToAddCard = false;
  var bankCardList;

  var list = [{
    "id": "0",
    "text": "交易明细"},
    {
      "id": "1",
      "text": "投注明细"},
    {
      "id": "2",
      "text": "每日统计"},
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkNavigator();
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return ProviderWidget<CardViewModel>(
        model: _vm,
        builder: (ctx, vm, _) {
          _handleApiState();
          return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text("管理银行卡",
                  style: TextStyle(fontSize: 16.auto),
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(40),
                  child: Container(
                      margin: EdgeInsets.symmetric(vertical: 20.auto),
                      alignment: Alignment.center,
                      child: Text(
                        "¥ 0.00",
                        /*_vm.mainAccountBalance == null ? "-" : "¥ ${Format()
                            .currencyWithDecimalFormat(
                            _vm.mainAccountBalance)}",*/
                        style: TextStyle(
                            fontSize: 16.auto,
                            color: Colors.white),
                      )
                  ),
                ),
                flexibleSpace: Container(
                  decoration: gradientDecoration,
                ),
              ),

              body:/* bankCardList == null || bankCardList.length == 0 ?
              Center(
                child: CircularProgressIndicator(),
              ) :*/
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.auto),
                child: Column(
                  children: [
                    Wrap(
                      children: List.generate(1, (index) {
                        return Container(
                            child: Dismissible(
                              key: UniqueKey(),
                              //child: _buildBankCardItem(),
                              child: _buildBankCardItem(/*bankCardList[index]*/),
                              background: _swipeLeftBackground(),
                              direction: DismissDirection.endToStart,
                              behavior: HitTestBehavior.deferToChild,
                              onDismissed: (_) {
                                //_delete();
                                _delete(bankCardList[index]);
                              },
                            )
                        );
                      }),
                    ),
                    // Slidable(child: null, actionPane: null),
                    _buildDeleteHintText(),
                    _buildAddCardItem(),
                  ],
                ),
              )
          );
        });
  }

  _swipeLeftBackground(){
    return Container(
      //width: 100.auto,
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
                " Delete",
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

  //_buildBankCardItem() => Container(
  _buildBankCardItem(/*BankCard bankCard*/) => Container(
      margin: EdgeInsets.only(top: 10.auto),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
            image: AssetImage("images/card/card_bg.png"),
            fit: BoxFit.cover
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0.0,3.0),
            spreadRadius: 0.0,//(x,y)
            blurRadius: 15.0,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin:EdgeInsets.only(left: 20.auto, right: 10.auto),
            color: CustomColor.theme_bar_gradient_2,
            width: 23.auto,
            height: 23.auto,
/*child: Image.asset(
              bankCard.getImagePath(),
              width: 23.auto,
              height: 23.auto,
            ),*/
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20.auto),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  //bankCard.bankName,
                  "中国建设银行",
                  style: TextStyle(
                      fontSize: 11.auto
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top:10.auto),
                  child: Text(
                    //"**** **** **** ${bankCard.bankAccount}",
                    "**** **** **** 1234",
                    style: TextStyle(
                        fontSize: 15.auto,
                        color: CustomColor.theme_bar_gradient_2
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      )
  );

  _buildDeleteHintText() => Container(
    margin: EdgeInsets.only(right: 23.auto, top: 5.auto),
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
            "滑动以删除银行卡",
            style: TextStyle(
                fontSize: 9.auto,
                color: CustomColor.theme_button_disable_bg
            ),
          ),
        ),
      ],
    ),
  );

  _buildAddCardItem() => InkWell(
    onTap: (){
      Navigator.of(context).pushNamed("/add_card");
    },
    child: Container(
      margin: EdgeInsets.only(top:15.auto, left: 5.auto, right: 5.auto),
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
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.auto, horizontal: 20.auto),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "添加银行卡",
                      style: TextStyle(
                          fontSize: 11.auto,
                          color: Colors.black
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top:5.auto),
                      child: Text(
                        "添加银行卡后即可进行转出提款，至多3张。",
                        style: TextStyle(
                            fontSize: 9.auto,
                            color: CustomColor.theme_button_disable_bg
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  margin:EdgeInsets.symmetric(horizontal: 20.auto),
                  child: ImageIcon(
                      AssetImage(
                        "images/card/ic_add_card.png",
                      ),
                      size: 23.auto,
                      color: CustomColor.theme_button_disable_bg
                  )
              ),
            ],
          )
      ),
    ),
  );

  _delete(BankCard card)async{
    /*CustomProgressDialog.show(context);
    await _vm.deleteCard(card.id);
    if(_vm.deleteCardApiState.isSuccess){
      await _vm.getBankCardList();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        CustomProgressDialog.hide();
        if(_vm.getBankCardApiState.result.length == 0) {
          Navigator.of(context).pushReplacementNamed('/add_card');
          Navigator.of(context).popAndPushNamed("/add_card");
          isNavigatedToAddCard = true;
        }else{
          setState(() {
            bankCardList = _vm.getBankCardApiState.result;
          });
        }
      });
    }*/
  }

  _checkNavigator() async{
    /*var userProfile = _vm.userProfile;

    if(bankCardList == null){
      await _vm.getBankCardList();
      bankCardList = _vm.getBankCardApiState.result;
    }
    if(userProfile.memberName.isEmpty){
      if(isNavigatedToVerifyName){
        Navigator.pop(context);
      } else{
        //replace current route to card_verify_real_name
        Navigator.of(context).pushReplacementNamed('/card_verify_real_name');
        Navigator.of(context).popAndPushNamed("/card_verify_real_name");
        isNavigatedToVerifyName = true;
      }
      return;
    }
    else if(userProfile.memberSafePassword.isEmpty){
      if(isNavigatedToSetWithdrawPassword){
        Navigator.pop(context);

      } else{
        Navigator.of(context).pushReplacementNamed('/card_verify_withdraw_password');
        Navigator.of(context).popAndPushNamed("/card_verify_withdraw_password");
        isNavigatedToVerifyName = true;
      }
      return;
    }
    else if(bankCardList.length == 0){
      if(isNavigatedToAddCard){
        Navigator.pop(context);
      }else {
        Navigator.of(context).pushReplacementNamed('/add_card');
        Navigator.of(context).popAndPushNamed("/add_card");
        isNavigatedToAddCard = true;
      }
      return;
    }*/
  }

  _handleApiState() async{
    /*if (_vm.deleteCardApiState == null ) {
      return;
    }
    if ((_vm.deleteCardApiState?.isError ?? false)) {
      CustomProgressDialog.hide();
      CustomToast.show(_vm.deleteCardApiState.error);
    }*/
  }
}

