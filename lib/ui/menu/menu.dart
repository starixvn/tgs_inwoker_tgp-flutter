import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:api/entity/message.dart';
import 'package:api/extension/screen_apis.dart';
import 'package:api/localizations/language_provider.dart';
import 'package:tgp_flutter/main.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/card/main_card.dart';
import 'package:tgp_flutter/ui/deposit/deposit.dart';
import 'package:tgp_flutter/ui/home/home.dart';
import 'package:tgp_flutter/ui/message/message_view.dart';
import 'package:tgp_flutter/ui/transaction/transaction.dart';
import 'package:tgp_flutter/ui/transfer/wallet_transfer.dart';
import 'package:tgp_flutter/ui/withdraw/withdraw.dart';

import 'menu_item.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends BaseState<Menu> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(top: 10.auto, left: 10.auto, right: 10.auto),
          child: Wrap(children: [
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              children: [
                MenuItem(
                  image: "ic_menu_deposit",
                  text: getTranslatedText("deposit"),
                  navigationPath: "deposit",
                  navigationID: 0,
                ),
                MenuItem(
                  image: "ic_menu_transfer",
                  text: getTranslatedText("transfer"),
                  navigationPath: "wallet_transfer",
                  navigationID: 0,
                ),
                MenuItem(
                  image: "ic_menu_withdraw",
                  text: getTranslatedText("withdrawal"),
                  navigationPath: "withdraw",
                  navigationID: 0,
                ),
                /*MenuItem(
                  image: "ic_menu_transfer_history",
                  text: getTranslatedText("transfer_history"),
                  navigationPath: "transaction",
                  navigationID: 0,
                ),*/
                MenuItem(
                  image: "ic_menu_bet_history",
                  text: getTranslatedText("bet_history"),
                  navigationPath: "transaction",
                  navigationID: 0,
                ),
                MenuItem(
                  image: "ic_menu_deposit_history",
                  text: getTranslatedText("deposit_history"),
                  navigationPath: "transaction",
                  navigationID: 1,
                ),
                MenuItem(
                  image: "ic_menu_withdraw_history",
                  text: getTranslatedText("withdrawal_history"),
                  navigationPath: "transaction",
                  navigationID: 2,
                ),
                MenuItem(
                  image: "ic_menu_withdraw_history",
                  text: getTranslatedText("transfer_history"),
                  navigationPath: "transaction",
                  navigationID: 3,
                ),
                MenuItem(
                  image: "ic_menu_card",
                  text: getTranslatedText("manage_card"),
                  navigationPath: "main_card",
                  navigationID: 0,
                ),
                MenuItem(
                  image: "ic_menu_message_center",
                  text: getTranslatedText("message_center"),
                  navigationPath: "message",
                  navigationID: 0,
                ),
              ],
            ),
            Container(
                margin: EdgeInsets.only(top: 30.auto, bottom: 20.auto),
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => MyHomePage()), (Route<dynamic> route) => false);
                  },
                  child: ImageIcon(
                    AssetImage("images/menu/ic_menu_close.png"),
                    size: 25.auto,
                    color: Colors.white,
                  ),
                )),
          ]),
        ));
  }
}
