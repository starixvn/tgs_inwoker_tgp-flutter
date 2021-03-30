import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/extension/format.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/deposit/deposit_method.dart';
import 'package:tgp_flutter/ui/deposit/deposit_view_model.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';

class Deposit extends StatefulWidget{
  @override
  _DepositState createState() => _DepositState();
}

class _DepositState extends BaseState<Deposit> {
  DepositViewModel _vm = DepositViewModel();
  var tabList =
  [{
    "id": "0",
    "text": "支付宝"},
    {
      "id": "1",
      "text": "支付宝H5"},
    {
      "id": "2",
      "text": "银行收银台"},
    {
      "id": "3",
      "text": "在线支付"}
  ];
  var currentTabIndex = 0;
  var text = "";

  @override
  void initState() {
    super.initState();
    //_vm.getPayment();
  }

  Widget build(BuildContext context) {
    return ProviderWidget<DepositViewModel>(
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
                actions: [
                  Container(
                      margin: EdgeInsets.only(right: 15.auto),
                      alignment: Alignment.center,
                      child:Text(
                          /*_vm.mainAccountBalance ==null?"-":"¥ ${Format().currencyWithDecimalFormat(
                              _vm.mainAccountBalance)}",*/
                          "¥ 0.00",
                        style: TextStyle(
                          color: CustomColor.theme_label_text_highlight_color
                        ),
                      )
                  ),
                ],
                title: Text(getTranslatedText("deposit"),
                  style: TextStyle(fontSize: 20.auto),),
              ),
              body: /*_vm.paymentChannel == null ||_vm.mainAccountBalance==null||_vm.isLoading ?
              Center(child: CircularProgressIndicator(),):*/
              DefaultTabController(
                length: 3,
                child:Column(
                children: [
                  Container(
                    width: context.screenWidth,
                    color: CustomColor.theme_button_disable_bg,
                    child: TabBar(
                      isScrollable: true,
                      unselectedLabelColor: Colors.white,
                      labelColor: CustomColor.theme_label_text_highlight_color,
                      indicatorColor: CustomColor.theme_label_text_highlight_color ,
                      indicatorWeight: 3,
                      onTap: (index) {
                        setState(() {
                          currentTabIndex = index;
                        });
                      },
                      unselectedLabelStyle: TextStyle(
                          color: Colors.white
                      ),
                      tabs: List.generate(3,(index){
                        return Tab(
                          child:Text( "银行支付",
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
                      children: List.generate(3,(index){
                        return DepositMethod(
                          //paymentList: _vm.paymentChannel[index].paymentList,
                          vm: _vm,
                        );
                      }).toList(),
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}