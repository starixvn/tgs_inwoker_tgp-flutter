import 'package:flutter/material.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/transaction/transaction_date_item.dart';
import 'package:tgp_flutter/ui/transaction/transaction_filter_button_item.dart';
import 'package:tgp_flutter/ui/transaction/transaction_header_item.dart';

class BaseTransaction extends StatefulWidget {
  final List<String> transactionHeaderList;
  final Function(DateTime, bool) onCalendarClick;
  final Function(int) onFilter;
  final Widget getPickerBox;
  final DateTime startDate;
  final DateTime endDate;
  final int filterIndex;
  final int expandedHeight;

  BaseTransaction(
      {Key key,
      this.transactionHeaderList,
      this.onCalendarClick,
      this.onFilter,
      this.getPickerBox,
      this.startDate,
      this.endDate,
      this.filterIndex,
      this.expandedHeight})
      : super(key: key);

  @override
  BaseTransactionState createState() => BaseTransactionState();
}

class BaseTransactionState extends BaseState<BaseTransaction> {
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      floating: false,
      expandedHeight: widget.expandedHeight.auto,
      backgroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Column(children: [
          _getCalendarItem(),
          TransactionFilterButtonItem(
            index: widget.filterIndex,
            onTextChanged: (value) => widget.onFilter(value),
          ),
          widget.getPickerBox
        ]),
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

  _getCalendarItem() => Container(
        padding: EdgeInsets.all(10.auto),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TransactionDateItem(
              date: widget.startDate,
              title: getTranslatedText("start_time"),
              onDateChanged: (value) {
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
              title: getTranslatedText("end_time"),
              onDateChanged: (value) {
                widget.onCalendarClick(value, false);
              },
            ),
          ],
        ),
      );
}
