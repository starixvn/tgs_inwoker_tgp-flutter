import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/custom_picker.dart';
import 'package:tgp_flutter/custom/custom_picker_dialog.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/entity/account_transaction.dart';
import 'package:tgp_flutter/entity/bet_transaction.dart';
import 'package:tgp_flutter/entity/daily_transaction.dart';
import 'package:tgp_flutter/entity/transaction_action_type.dart';
import 'package:tgp_flutter/entity/transaction_bet_status_type.dart';
import 'package:tgp_flutter/entity/transaction_cell_item_type.dart';
import 'package:tgp_flutter/entity/transaction_status_type.dart';
import 'package:tgp_flutter/entity/transaction_third_party.dart';
import 'package:tgp_flutter/entity/transaction_third_party_type.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/transaction/transaction_cell_item.dart';
import 'package:tgp_flutter/ui/transaction/transaction_date_item.dart';
import 'package:tgp_flutter/ui/transaction/transaction_filter_button_item.dart';
import 'package:tgp_flutter/ui/transaction/transaction_header_item.dart';
import 'package:tgp_flutter/ui/transaction/transaction_view_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../my_behavior.dart';

class TransactionDetails<T> extends StatefulWidget {
  final List<String> transactionHeaderList;

  TransactionDetails({Key key,
    this.transactionHeaderList,
  }) : super(key: key);

  @override
  TransactionDetailsState<T> createState() => TransactionDetailsState<T>();
}

class TransactionDetailsState<T> extends BaseState<TransactionDetails<T>>{
  TransactionViewModel _vm = TransactionViewModel();
  var startDate, endDate;
  var isToday = false, isWeek = false, isMonth = false, isLoading = false;
  var transactionList = [];
  var action = TransactionActionType.values;
  var pickerText1, pickerText2, pickerText3;
  var thirdPartyIdList;
  var thirdPartyList;
  ScrollController _controller2 = ScrollController();
  var isEndRecord = false;
  RefreshController _refreshController = RefreshController();

  void initState(){
    startDate = DateTime.now();
    endDate = DateTime.now();
    isToday = true;
    onFilter(today: isToday);
    getTransaction();
    _controller2.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //_vm.getThirdPartyList();
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return ProviderWidget<TransactionViewModel>(
        model: _vm,
        builder: (ctx, vm, _) {
          _handleApiState();
          return Container(
            height: context.screenHeight,
            child: ScrollConfiguration(
                behavior: MyBehavior(),
                child:
                SmartRefresher(
                  controller: _refreshController,
                  enablePullDown: true,
                  onRefresh: () {
                    getTransaction(
                        isLoadMore: false);
                    _refreshController.refreshCompleted();
                  },
                  child: /*transactionList == null?
                  Center(
                    child: CircularProgressIndicator(),
                  ) :*/
                  CustomScrollView(
                    controller: _controller2,
                    slivers: [
                    SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: true,
                    floating: false,
                    expandedHeight: 240.auto,
                    backgroundColor: Colors.grey[100],
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      background: Column(
                          children: [
                            _getCalendarItem(),
                            TransactionFilterButtonItem(
                              isToday: isToday,
                              isWeek: isWeek,
                              isMonth: isMonth,
                              onTextChanged:(value) {
                                //this.getTransaction();
                                onFilter(
                                  today: value==1?true:false,
                                  week: value==2?true:false,
                                  month: value==3?true:false,
                                );
                                getTransaction();
                                CustomProgressDialog.show(context);
                              },
                            ),
                            _getPickerBox()
                          ]
                      ),
                    ),
                    bottom: PreferredSize(
                      preferredSize: Size.zero,
                      child: Center(
                        child: TransactionHeaderItem(
                          headerList: widget.transactionHeaderList,
                        ),
                      ),
                    ),
                    toolbarHeight: 40.auto,
                    elevation: 0,
                  ),
                  SliverPadding(
                    padding: EdgeInsets.only(left: 10.auto, right:10.auto, top: 5.auto),
                    sliver: SliverList(
                        delegate: SliverChildListDelegate(
                          // transactionList.length==0?
                            List.generate(1, (index) => Container(
                                margin: EdgeInsets.only(top:60.auto),
                                child: ImageIcon(
                                  AssetImage("images/transaction/ic_no_record.png"),
                                  size: 75.auto,
                                )
                            ),
                            )
                        )/*: List.generate(0, (index) {
                                  return Container(
                                    child: TransactionCellItem<T>(
                                        //value: transactionList[index],
                                        type: _getTransactionItemType(index),
                                        isLoading: isEndRecord?false:isLoading,
                                        isEndRecord: isEndRecord
                                    ),
                                  );
                                }).toList()*/
                    ),
                  ),
                ]
            ),
          )
          ),
          );
        });
  }

  _getCalendarItem()=> Container(
    padding: EdgeInsets.all(10.auto),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TransactionDateItem(
          date: startDate,
          title: "开始时间",
          onDateChanged: (value){
            setState(() {
              startDate = value;
              onFilter();
              getTransaction(startDate: value);
              CustomProgressDialog.show(context);
            });
          },
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 20.auto),
          width: 5.auto,
          height: 1,
          color: CustomColor.grey,
        ),
        TransactionDateItem(
          date: endDate,
          title: "结束时间",
          onDateChanged: (value){
            setState(() {
              endDate = value;
              onFilter();
              getTransaction(endDate: value);
              CustomProgressDialog.show(context);
            });
          },
        ),
      ],
    ),
  );

  _getTransactionItemType(int index){
    /*if(transactionList.length == 1){
      return TransactionCellItemType.SINGLE;
    }else{
      if(index == 0) {
        return TransactionCellItemType.TOP;
      }
      else if(index == transactionList.length -1){
        return TransactionCellItemType.BOTTOM;
      }
      else{
        return TransactionCellItemType.CENTER;
      }
    }*/
  }

  _getPickerBox(){
    if(T == AccountTransaction){
      return _getAccountTransactionPickerBox();
    }
    else if(T == BetTransaction){
      return _getBetTransactionPickerBox();
    }
    else if(T == DailyTransaction){
      return _getDailyTransactionBox();
    }
  }

  _getAccountTransactionPickerBox(){
    var actionList = TransactionActionType.values.where(
            (e) => e!=TransactionActionType.SUMMARY && e!=TransactionActionType.BET).toList();
    var statusList = TransactionStatusType.values;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.auto),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomPicker(
              title: "交易类别",
              displayText: pickerText1 == null?"全部": pickerText1,
              list: actionList,
              isHintText: true,
              width: context.screenWidth / 2 - 60.auto,
              onClick:() {
                _buildPickerDialog("交易类别", actionList);
              }
          ),
          CustomPicker(
              title: "交易状态",
              displayText: pickerText2 == null?"全部": pickerText2,
              list: statusList,
              isHintText: true,
              width: context.screenWidth / 2 - 60.auto,
              onClick:() {
                _buildPickerDialog("交易状态", statusList);
              }
          ),
        ],
      ),
    );
  }

  _getBetTransactionPickerBox(){
    var thirdPartyTypeList = TransactionThirdPartyType.values;
    var statusList = TransactionBetStatusType.values;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.auto),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomPicker(
              title: "投注类别",
              displayText: pickerText1 == null? thirdPartyTypeList[0].displayName: pickerText1,
              list: thirdPartyTypeList,
              isHintText: true,
              width: context.screenWidth / 3 - 55.auto,
              onClick:() {
                _buildPickerDialog("投注类别", thirdPartyTypeList);
              }
          ),
          CustomPicker(
              title: "投注馆别",
              displayText: _getThirdPartyText(),
              list: thirdPartyIdList,
              isHintText: true,
              width: context.screenWidth / 3 - 55.auto,
              onClick:() {
                _buildPickerDialog("投注馆别", thirdPartyIdList);
              }
          ),
          CustomPicker(
              title: "投注状态",
              displayText: pickerText3 == null?statusList[0].displayName: pickerText3,
              list: statusList,
              isHintText: true,
              width: context.screenWidth / 3 - 55.auto,
              onClick:() {
                _buildPickerDialog("投注状态", statusList);
              }
          ),
        ],
      ),
    );
  }

  _getDailyTransactionBox(){
    var thirdPartyTypeList = TransactionThirdPartyType.values;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.auto),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomPicker(
              title: "投注类别",
              displayText: pickerText1 == null?"全部": pickerText1,
              list: thirdPartyTypeList,
              isHintText: true,
              width: context.screenWidth / 2 - 60.auto,
              onClick:() {
                _buildPickerDialog("投注类别", thirdPartyTypeList);
              }
          ),
          CustomPicker(
              title: "投注馆别",
              displayText: pickerText2 == null?"全部": pickerText2,
              list: thirdPartyIdList,
              isHintText: true,
              width: context.screenWidth / 2 - 60.auto,
              onClick:() {
                _buildPickerDialog("投注馆别", thirdPartyIdList);
              }
          ),
        ],
      ),
    );
  }

  _buildPickerDialog(String title, List<dynamic> list){
    showModalBottomSheet(
        context: context,
        isScrollControlled:true,
        builder: (BuildContext bc){
          return CustomPickerDialog(title: title, list: list,
              onChanged: (value){
                setState(() {
                  if(T == AccountTransaction){
                    if(value is TransactionActionType){
                      pickerText1 = value.displayName;
                      getTransaction(action: value);
                    }
                    else if(value is TransactionStatusType){
                      pickerText2 = value.displayName;
                      getTransaction(status: value);
                    }
                  }
                  else if(T == BetTransaction){
                    if(value is TransactionThirdPartyType){
                      pickerText1 = value.displayName;
                      getTransaction(transactionThirdPartyType: value);
                      filterThirdParty(value);
                    }
                    else if(value is TransactionBetStatusType){
                      pickerText3 = value.displayName;
                      getTransaction(transactionBetStatusType: value);
                    }
                    else if(value is TransactionThirdParty){
                      pickerText2 = value.name;
                      getTransaction(thirdPartyId: value.id);
                    }
                  }
                  else if(T == DailyTransaction){
                    if(value is TransactionThirdPartyType){
                      pickerText1 = value.displayName;
                      getTransaction(transactionThirdPartyType: value);
                      filterThirdParty(value);
                    }
                    //third party
                    else if(value is TransactionThirdParty){
                      pickerText2 = value.name;
                      getTransaction(thirdPartyId: value.id);
                    }
                  }
                  Navigator.pop(context);
                  CustomProgressDialog.show(context);
                });
              }
          );
        }
    );
  }

  onFilter({bool today = false, week = false, month = false}) {
    var currentDate = DateTime.now();
    setState(() {
      isToday = today;
      isWeek = week;
      isMonth = month;
      if(today){
        startDate = currentDate;
        endDate = currentDate;
      }else if(week){
        startDate = DateTime(currentDate.year, currentDate.month, currentDate.day - 7);
        endDate = currentDate;
      }else if(month){
        startDate = DateTime(currentDate.year, currentDate.month - 1, currentDate.day);
        endDate = currentDate;
      }
    });
    //_vm.filter(startDate);
  }

  getTransaction({
    DateTime startDate,
    DateTime endDate,
    TransactionActionType action,
    TransactionStatusType status,
    int thirdPartyId,
    int thirdPartyParentId,
    TransactionThirdPartyType transactionThirdPartyType,
    TransactionBetStatusType transactionBetStatusType,
    bool isLoadMore
  }) async{
    /* if(T == AccountTransaction){
      await _vm.getMoneyTransaction(
          startDate: startDate,
          endDate: endDate,
          actionType: action,
          status: status,
          isLoadMore: isLoadMore?? false
      );
      setState(() {
        isLoading = false;
        transactionList = _vm.accountTransactionList;
        isEndRecord = _vm.endRecord;
      });
    }
    else if(T == BetTransaction){
      await _vm.getBetTransaction(
          startDate: startDate,
          endDate: endDate,
          thirdPartyId: thirdPartyId,
          thirdPartyParentId: thirdPartyParentId,
          transactionThirdPartyType: transactionThirdPartyType,
          transactionBetStatusType: transactionBetStatusType,
          isLoadMore: isLoadMore?? false
      );
      setState(() {
        isLoading = false;
        transactionList = _vm.betTransactionList;
        isEndRecord = _vm.endRecord;
      });
    }
    else if(T == DailyTransaction){
      await _vm.getDailyTransaction(
          startDate: startDate,
          endDate: endDate,
          thirdPartyId: thirdPartyId,
          thirdPartyParentId: thirdPartyParentId,
          transactionThirdPartyType: transactionThirdPartyType
      );
      setState(() {
        isLoading = false;
        transactionList = _vm.dailyTransactionList;
        isEndRecord = _vm.endRecord;
      });
    }
    CustomProgressDialog.hide();*/
  }

  _handleApiState(){
    /*if (_vm.accountTransactionApiState == null &&
        _vm.betTransactionApiState == null &&
        _vm.dailyTransactionApiState == null ) {
      return;
    }
    if ((_vm.accountTransactionApiState?.isError ?? false)) {
      CustomToast.show(_vm.accountTransactionApiState.error);
    }
    if ((_vm.betTransactionApiState?.isError ?? false)) {
      CustomToast.show(_vm.betTransactionApiState.error);
    }
    if ((_vm.dailyTransactionApiState?.isError ?? false)) {
      CustomToast.show(_vm.dailyTransactionApiState.error);
    }*/
  }

  clearData({
    bool isAccountTransaction = false,
    bool isBetTransaction = false,
    bool isDailyTransaction = false,
  }){
    /*_vm.resetApiState(
        isAccountTransaction: isAccountTransaction,
        isBetTransaction: isBetTransaction,
        isDailyTransaction: isDailyTransaction
    );*/
  }

  _getThirdPartyText(){
    return "";
    /*if(pickerText2 == null){
      if(thirdPartyIdList == null) {
        thirdPartyIdList = _vm.thirdPartyIdList;
      }
      return thirdPartyIdList?.first?.name?? "";
    }else return pickerText2;*/
  }

  filterThirdParty(TransactionThirdPartyType type) async{
    /*await _vm.filterThirdParty(type:type);
    setState(() {
      thirdPartyIdList =_vm.thirdPartyIdList;
      pickerText2 = null;
    });*/
  }

  _scrollListener(){
    if(_controller2.offset >= _controller2.position.maxScrollExtent){
      getTransaction(isLoadMore: true);
      setState(() {
        isLoading = true;
      });
    }
  }
}