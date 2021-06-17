import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/extension/format.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/deposit/deposit_method.dart';
import 'package:tgp_flutter/ui/deposit/deposit_view_model.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';

class Deposit extends StatefulWidget {
  @override
  _DepositState createState() => _DepositState();
}

class _DepositState extends BaseState<Deposit> {
  DepositViewModel _vm = DepositViewModel();

  /*var tabList = [
    {"id": "0", "text": "人工支付"}
  ];*/
  var currentTabIndex = 0;
  var text = "";

  @override
  void initState() {
    _vm.getPayment();
    _vm.getPlayerPromotionList(1);
    super.initState();
  }

  Widget build(BuildContext context) {
    return ProviderWidget<DepositViewModel>(
        model: _vm,
        builder: (ctx, vm, _) {
          _handleApiState();
          return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              appBar: _buildAppBar(),
              body: (() {
                if (_vm.paymentCodeList == null)
                  return buildProgressDialog();
                else if (_vm.paymentCodeList.isEmpty)
                  return Container();
                else {
                  return DefaultTabController(
                    length: _vm.paymentCodeList.keys.length,
                    child: Column(
                      children: [
                        Container(
                          width: context.screenWidth,
                          color: CustomColor.theme_button_disable_bg,
                          child: TabBar(
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
                            unselectedLabelStyle: TextStyle(color: Colors.white),
                            tabs: List.generate(_vm.paymentCodeList.keys.length, (index) {
                              return Tab(
                                child: Text(
                                  getTranslatedText(_vm.paymentCodeList.keys.toList()[index]),
                                  style: TextStyle(
                                    fontFamily: 'PingFang',
                                    fontSize: 14.auto,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: List.generate(_vm.paymentCodeList.keys.length, (index) {
                              return DepositMethod(
                                paymentCode: _vm.paymentCodeList.keys.toList()[index],
                                depositMethodList: _vm.paymentCodeList.values.toList()[index],
                                promotionList: _vm.displayPromotionList,
                              );
                            }).toList(),
                          ),
                        )
                      ],
                    ),
                  );
                }
              }()));
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
            Navigator.pop(context);
          },
        ),
        actions: [
          Container(
              margin: EdgeInsets.only(right: 15.auto),
              alignment: Alignment.center,
              child: Text(
                "¥ ${Format().currencyWithDecimalFormat(_vm.wallet?.main ?? 0.0)}",
                style: TextStyle(color: CustomColor.theme_label_text_highlight_color),
              )),
        ],
        title: Text(
          getTranslatedText("deposit"),
          style: TextStyle(fontSize: 20.auto),
        ),
      );

  _handleApiState() {
    handleApiState(_vm.getPaymentApiState, isAutoHideLoading: false, onSuccess: () {
      if (_vm.getPaymentApiState.result.isEmpty) {
        CustomToast.show(getTranslatedText("deposit_not_available"));
      }
    });
  }
}
