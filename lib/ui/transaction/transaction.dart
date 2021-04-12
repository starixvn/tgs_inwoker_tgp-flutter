import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/entity/account_transaction.dart';
import 'package:tgp_flutter/entity/bet_transaction.dart';
import 'package:tgp_flutter/entity/daily_transaction.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/my_behavior.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/transaction/bet_transaction_view.dart';
import 'package:tgp_flutter/ui/transaction/transaction_details.dart';
import 'package:tgp_flutter/ui/transaction/transaction_view_model.dart';


class Transaction extends StatefulWidget{
  final int tabIndex;

  Transaction({Key key,
    this.tabIndex
  }) : super(key: key);

  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends BaseState<Transaction> with SingleTickerProviderStateMixin{
  var _tabController;
  var currentTabIndex = 0;
  var tabList =
  [{
    "id": "0",
    "text": "转换记录"},
    {
      "id": "1",
      "text": "投注明细"},
    {
      "id": "2",
      "text": "提现记录"},
    {
      "id": "3",
      "text": "充值记录"},
    {
      "id": "4",
      "text": "返水记录"},
  ];
  var accountTransactionList;

  @override
  void initState() {
    _tabController = TabController(length:tabList.length, vsync: this, initialIndex: (widget.tabIndex)?? 0);
    super.initState();
  }

  @override
  void dispose(){
    _tabController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: gradientDecoration,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          tabList[currentTabIndex]["text"],
          style: TextStyle(fontSize: 20.auto),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: Container(
              margin: EdgeInsets.symmetric(vertical: 20.auto),
              alignment: Alignment.center,
              child: Text(
                "¥ 0.00",
                style: TextStyle(
                    fontSize: 16.auto,
                    color: Colors.white),
              )
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: context.screenWidth,
            color: Colors.black87,
            child: TabBar(
              controller: _tabController,
              isScrollable : true,
              unselectedLabelColor: Colors.white,
              labelColor: CustomColor.theme_label_text_highlight_color,
              indicatorColor: CustomColor.theme_label_text_highlight_color,
              indicatorWeight: 3,
              onTap: (index){
                setState(() {
                  currentTabIndex = index;
                });
              },
              unselectedLabelStyle: TextStyle(
                  color: CustomColor.grey
              ),
              tabs: tabList.map((item) {
                return Tab(
                  child: Text(item["text"],
                      style: TextStyle(
                        fontFamily: 'PingFang',
                        fontSize: 14.auto,
                      )),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                TransactionDetails<AccountTransaction>(
                    transactionHeaderList: [
                      "bet_time",
                      "platform",
                      "bet_amount",
                      "win_loss"
                    ]
                ),
                BetTransactionView(),
                TransactionDetails<AccountTransaction>(
                    transactionHeaderList: [
                      "bet_time",
                      "platform",
                      "bet_amount",
                      "win_loss"
                    ]
                ),
                TransactionDetails<BetTransaction>(
                  transactionHeaderList: [
                    "bet_time",
                    "platform",
                    "bet_amount",
                    "win_loss"
                  ],
                ),
                TransactionDetails<DailyTransaction>(
                  transactionHeaderList: [
                    "bet_time",
                    "platform",
                    "bet_amount",
                    "win_loss"
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}