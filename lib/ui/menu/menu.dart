import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/custom_color.dart';

import 'menu_item.dart';

class Menu extends StatefulWidget{
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        resizeToAvoidBottomPadding: false,
        body: Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(top:10.auto, left: 10.auto, right: 10.auto),
          child: Wrap(
              children: [
                GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  children: [
                    MenuItem(
                      image:"ic_menu_deposit",
                      text:"存款",
                      navigationPath: "deposit",
                      navigationID: 0,
                    ),
                    MenuItem(
                      image:"ic_menu_transfer"
                      ,text:"转账",
                      navigationPath: "wallet_transfer",
                      navigationID: 0,
                    ),
                    MenuItem(
                      image:"ic_menu_withdraw",
                      text:"提款",
                      navigationPath: "withdraw",
                      navigationID: 0,
                    ),
                    MenuItem(
                      image:"ic_menu_transfer_history",
                      text:"账户明细",
                      navigationPath: "transaction",
                      navigationID: 0,
                    ),
                    MenuItem(
                      image:"ic_menu_bet_history",
                      text:"投注明细",
                      navigationPath: "transaction",
                      navigationID: 1,
                    ),
                    MenuItem(
                      image:"ic_menu_withdraw_history",
                      text:"每日投注",
                      navigationPath: "transaction",
                      navigationID: 2,
                    ),
                    MenuItem(
                      image:"ic_menu_deposit_history",
                      text:"管理银行卡",
                      navigationPath: "main_card",
                      navigationID: 0,
                    ),
                    MenuItem(
                      image:"ic_menu_card",
                      text:"消息中心",
                      navigationPath: "message",
                      navigationID: 0,
                    ),
                    MenuItem(
                      image:"ic_menu_message_center",
                      text:"红利中心",
                      navigationPath: "bonus",
                      navigationID: 0,
                    ),
                  ],
                ),
                Container(
                    margin: EdgeInsets.only(top: 30.auto, bottom: 20.auto),
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
                      },
                      child: ImageIcon(
                        AssetImage("images/menu/ic_menu_close.png"),
                        size: 25.auto,
                        color: Colors.white,
                      ),
                    )
                ),
              ]
          ),
        )
    );
  }
}


