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

class BaseTransaction extends StatefulWidget {
  final List<String> transactionHeaderList;
  final Function(DateTime,bool) onCalendarClick;
  final Function(int) onFilter;
  final Widget getPickerBox;
  final DateTime startDate;
  final DateTime endDate;
  final int filterIndex;

  BaseTransaction({Key key,
    this.transactionHeaderList,
    this.onCalendarClick,
    this.onFilter,
    this.getPickerBox,
    this.startDate,
    this.endDate,
    this.filterIndex
  }) : super(key: key);

  @override
  BaseTransactionState createState() => BaseTransactionState();
}

class BaseTransactionState extends BaseState<BaseTransaction>{
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      floating: false,
      expandedHeight: 240.auto,
      backgroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Column(
            children: [
              _getCalendarItem(),
              TransactionFilterButtonItem(
                index: widget.filterIndex,
                onTextChanged:(value) => widget.onFilter(value),
              ),
              widget.getPickerBox
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
    );
  }

  _getCalendarItem()=> Container(
    padding: EdgeInsets.all(10.auto),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TransactionDateItem(
          date: widget.startDate,
          title: "开始时间",
          onDateChanged: (value){
            widget.onCalendarClick(value, true);
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
          date: widget.endDate,
          title: "结束时间",
          onDateChanged: (value){
            widget.onCalendarClick(value, false);
          },
        ),
      ],
    ),
  );
}