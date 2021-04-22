import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/custom_picker.dart';
import 'package:tgp_flutter/custom/custom_picker_dialog.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/entity/account_transaction.dart';
import 'package:tgp_flutter/entity/bet_transaction.dart';
import 'package:tgp_flutter/entity/daily_transaction.dart';
import 'package:tgp_flutter/entity/bet_transaction.dart';
import 'package:tgp_flutter/entity/game_provider.dart';
import 'package:tgp_flutter/entity/transaction_action_type.dart';
import 'package:tgp_flutter/entity/transaction_bet_status_type.dart';
import 'package:tgp_flutter/entity/transaction_cell_item_type.dart';
import 'package:tgp_flutter/entity/transaction_status_type.dart';
import 'package:tgp_flutter/entity/transaction_third_party.dart';
import 'package:tgp_flutter/entity/transaction_third_party_type.dart';
import 'package:tgp_flutter/extension/format.dart';
import 'package:tgp_flutter/extension/navigate_without_animation.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/transaction/base_transaction.dart';
import 'package:tgp_flutter/ui/transaction/transaction.dart';
import 'package:tgp_flutter/ui/transaction/transaction_cell_item.dart';
import 'package:tgp_flutter/ui/transaction/transaction_date_item.dart';
import 'package:tgp_flutter/ui/transaction/transaction_filter_button_item.dart';
import 'package:tgp_flutter/ui/transaction/transaction_header_item.dart';
import 'package:tgp_flutter/ui/transaction/transaction_view_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../my_behavior.dart';

class BetTransactionView extends StatefulWidget {
  final List<String> transactionHeaderList;

  BetTransactionView({
    Key key,
    this.transactionHeaderList,
  }) : super(key: key);

  @override
  BetTransactionViewState createState() => BetTransactionViewState();
}

class BetTransactionViewState extends BaseState<BetTransactionView> {
  TransactionViewModel _vm = TransactionViewModel();
  ScrollController _scrollController = ScrollController();
  var isEndRecord = false, isLoading = false;
  RefreshController _refreshController = RefreshController();
  var pickerText1, pickerText2, pickerText3;
  var filterIndex = 0;
  var isFirst = true;

  void initState() {
    _scrollController.addListener(_scrollListener);
    isFirst = false;
    _vm.getGameProviderList();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onDateFilter(0);
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
                child: SmartRefresher(
                  controller: _refreshController,
                  enablePullDown: true,
                  onRefresh: () {
                    _getTransaction(isLoadMore: false);
                    _refreshController.refreshCompleted();
                  },
                  child: _vm.betTransactionList == null
                      ? buildProgressDialog()
                      : CustomScrollView(controller: _scrollController, slivers: [
                          BaseTransaction(
                            transactionHeaderList: ["bet_time", "bet_platform", "bet_amount", "win_loss"],
                            onCalendarClick: (value, isStartDate) => _onCalendarClick(value, isStartDate),
                            onFilter: (value) {
                              // ProgressDialog.show(context);
                              _onDateFilter(value);
                            },
                            getPickerBox: _getPickerBox(),
                            startDate: _vm.pStartDate,
                            endDate: _vm.pEndDate,
                            filterIndex: filterIndex,
                          ),
                          _buildTransactionItem()
                        ]),
                )),
          );
        });
  }

  _buildTransactionItem() => SliverPadding(
        padding: EdgeInsets.only(left: 10.auto, right: 10.auto, top: 5.auto),
        sliver: SliverList(
          delegate: SliverChildListDelegate(_vm.betTransactionList.length == 0
              ? List.generate(
                  1,
                  (index) => Container(
                        margin: EdgeInsets.only(top: 60.auto),
                        child: Container(
                            width: 75.auto, height: 75.auto, child: Image.asset("images/transaction/ic_no_record.png")),
                      ))
              : List.generate(_vm.betTransactionList.length, (index) {
                  return Container(
                    child: TransactionCellItem(
                        list: [
                          Format().dateTimeFormat(DateTime.parse(_vm.betTransactionList[index].createdOn)),
                          _vm.betTransactionList[index].gameProviderName,
                          _vm.betTransactionList[index].betAmount.toString(),
                          _vm.betTransactionList[index].winLoss.toString(),
                        ],
                        type: _getTransactionItemType(index),
                        isLoading: isEndRecord ? false : isLoading,
                        isEndRecord: isEndRecord),
                  );
                }).toList()),
        ),
      );

  _onCalendarClick(DateTime date, bool isStartDate) {
    if (isStartDate) {
      _vm.setDate(startDate: date);
      _getTransaction(startDate: date);
    } else {
      _vm.setDate(endDate: date);
      _getTransaction(endDate: date);
    }
    _onDateFilter(-1);
    // ProgressDialog.show(context);
  }

  _onDateFilter(int index) {
    var currentDate = DateTime.now();
    switch (index) {
      case 0: //today
        _vm.setDate(startDate: currentDate, endDate: currentDate);
        break;
      case 1: //week
        _vm.setDate(
            startDate: DateTime(currentDate.year, currentDate.month, currentDate.day - 7), endDate: currentDate);
        break;
      case 2: //month
        _vm.setDate(
            startDate: DateTime(currentDate.year, currentDate.month - 1, currentDate.day), endDate: currentDate);
        break;
      default:
        _vm.setDate();
        break;
    }
    setState(() {
      filterIndex = index;
    });
    _getTransaction();
  }

  _getPickerBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.auto),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomPicker(
              title: "bet_platform",
              displayText: pickerText1 == null ? getTranslatedText("all") : pickerText1,
              list: _vm.gameProviderList,
              isHintText: true,
              width: context.screenWidth - 70.auto,
              onClick: () {
                _buildPickerDialog("bet_platform", _vm.gameProviderList);
              }),
        ],
      ),
    );
  }

  _buildPickerDialog(String title, List<dynamic> list) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return CustomPickerDialog(
              title: title,
              list: list,
              onChanged: (value) {
                setState(() {
                  if (value is GameProvider) {
                    pickerText1 = value.name;
                    _getTransaction(/*action: value*/);
                  } else if (value is TransactionStatusType) {
                    pickerText2 = value.displayName;
                    _getTransaction(/*status: value*/);
                  }
                  Navigator.pop(context, NavigateWithoutAnimation());
                  // ProgressDialog.show(context);
                });
              });
        });
  }

  _getTransactionItemType(int index) {
    if (_vm.betTransactionList.length == 1) {
      return TransactionCellItemType.SINGLE;
    } else {
      if (index == 0) {
        return TransactionCellItemType.TOP;
      } else if (index == _vm.betTransactionList.length - 1) {
        return TransactionCellItemType.BOTTOM;
      } else {
        return TransactionCellItemType.CENTER;
      }
    }
  }

  _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent) {
      _getTransaction(isLoadMore: true);
      setState(() {
        isLoading = true;
      });
    }
  }

  _getTransaction({DateTime startDate, DateTime endDate, GameProvider platform, bool isLoadMore}) async {
    await _vm.getTransaction(isLoadMore: isLoadMore ?? false);
  }

  _handleApiState() {
    handleApiState(_vm.getTransactionApiState, isAutoHideLoading: false, onSuccess: () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          if (!isFirst) isFirst = !isFirst;
        });
      });
    });

    handleApiState(_vm.getGameProviderApiState, isAutoHideLoading: false, onSuccess: () {});
  }
}
