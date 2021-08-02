import 'package:flutter/material.dart';
import 'package:shared_api/extension/format.dart';
import 'package:shared_api/extension/screen_apis.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/transaction/account_transaction_view.dart';
import 'package:tgp_flutter/ui/transaction/bet_transaction_view.dart';
import 'package:tgp_flutter/ui/transaction/transfer_transaction_view.dart';
import 'package:tgp_flutter/ui/transaction/transaction_view_model.dart';
import 'package:tgp_flutter/ui/transaction/withdraw_transaction_view.dart';

class Transaction extends StatefulWidget {
  final int tabIndex;

  Transaction({Key key, this.tabIndex}) : super(key: key);

  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends BaseState<Transaction> with SingleTickerProviderStateMixin {
  var _tabController;
  var currentTabIndex = 0;
  var tabList = [
    {"id": "0", "text": "bet_history"},
    {"id": "1", "text": "deposit_history"},
    {"id": "2", "text": "withdrawal_history"},
    {"id": "3", "text": "transfer_history"},
    /*{"id": "4", "text": "返水记录"},*/
  ];
  TransactionViewModel _vm = TransactionViewModel();

  @override
  void initState() {
    currentTabIndex = widget.tabIndex??0;
    _tabController = TabController(length: tabList.length, vsync: this, initialIndex: currentTabIndex);
    super.initState();
  }

  Widget build(BuildContext context) {
    return ProviderWidget<TransactionViewModel>(
        model: _vm,
        builder: (ctx, vm, _) {
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
                getTranslatedText(tabList[currentTabIndex]["text"]),
                style: TextStyle(fontSize: 20.auto),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(40),
                child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20.auto),
                    alignment: Alignment.center,
                    child: Text(
                      "¥ ${Format().currencyWithDecimalFormat(_vm.wallet?.main ?? 0.0)}",
                      style: TextStyle(fontSize: 16.auto, color: Colors.white),
                    )),
              ),
            ),
            body: Column(
              children: [
                Container(
                  width: context.screenWidth,
                  color: Colors.black87,
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    unselectedLabelColor: Colors.white,
                    labelColor: CustomColor.theme_label_text_highlight_color,
                    indicatorColor: CustomColor.theme_label_text_highlight_color,
                    indicatorWeight: 3,
                    onTap: (index) {
                      setState(() {
                        currentTabIndex = index;
                      });
                    },
                    unselectedLabelStyle: TextStyle(color: CustomColor.grey),
                    tabs: tabList.map((item) {
                      return Tab(
                        child: Text(getTranslatedText(item["text"]) ?? tabList[currentTabIndex]["text"],
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
                      BetTransactionView(
                        vm: _vm,
                      ),
                      AccountTransactionView(
                        vm: _vm,
                      ),
                      WithdrawTransactionView(
                        vm: _vm,
                      ),
    TransferTransactionView(vm:_vm)
    /*     BaseTransactionView<AccountTransaction>(
                        isWithdraw: false,
                      ),
                      BaseTransactionView<BetTransaction>(
                        isWithdraw: false,
                      ),
                      BaseTransactionView<AccountTransaction>(
                        isWithdraw: true,
                      ),

                      AccountTransactionView(
                          vm: _vm, transactionHeaderList: ["time", "trade_order_no", "status", "amount"]),
                      AccountTransactionView(
                          vm: _vm, transactionHeaderList: ["time", "trade_order_no", "status", "amount"]),
                      AccountTransactionView(
                          vm: _vm,
                          transactionHeaderList: ["rebate_no", "rebate_cycle_date", "status", "rebate_detail"]),*/
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
