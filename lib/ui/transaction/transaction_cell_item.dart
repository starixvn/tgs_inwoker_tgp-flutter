import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tgp_flutter/entity/account_transaction.dart';
import 'package:tgp_flutter/entity/bet_transaction.dart';
import 'package:tgp_flutter/entity/daily_transaction.dart';
import 'package:tgp_flutter/entity/transaction_cell_item_type.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/base_state.dart';

class TransactionCellItem<T> extends StatefulWidget{
  //final T value;
  final TransactionCellItemType type;
  final bool isLoading;
  final bool isEndRecord;

   TransactionCellItem({Key key,
    //this.value,
    this.type,
    this.isLoading,
     this.isEndRecord
  }) : super(key: key);


  @override
  _TransactionCellItemState<T> createState() => _TransactionCellItemState();
}

class _TransactionCellItemState<T> extends BaseState<TransactionCellItem<T>> {
  var text1, text2, text3;

  Widget build(BuildContext context) {
    _getDisplayText();
    //only one item
    if(widget.type == TransactionCellItemType.SINGLE){
      return Container(
        padding: EdgeInsets.only(bottom: 10.auto),
        child: Container(
          padding: EdgeInsets.only(top:5.auto,bottom: 10.auto),
          decoration:BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: _getTransactionCellItem(isLast: true),
        ),
      );
    }
    //top item
    else if(widget.type == TransactionCellItemType.TOP){
      return Container(
        padding: EdgeInsets.only(top:5.auto),
          decoration:BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10) ,topRight: Radius.circular(10)
            ),
          ),
          child: _getTransactionCellItem()
      );
    }
    //bottom item
    else if(widget.type == TransactionCellItemType.BOTTOM){
      return Column(
        children: [
          Container(
          padding: EdgeInsets.only(bottom: 10.auto),
          child: Container(
            padding: EdgeInsets.only(bottom: 10.auto),
            decoration:BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10) ,bottomRight: Radius.circular(10)
              ),
            ),
            child: _getTransactionCellItem(isLast: true)
          ),
        ),
          /*widget.isLoading?Container(
            height: 50,
            width: 50,
            padding: EdgeInsets.only(bottom: 10.auto),
            child: CircularProgressIndicator(),
          ):Container(),*/
          widget.isEndRecord?
              Container(
                padding: EdgeInsets.only(bottom: 10.auto),
                child: Text(
                  "没有跟多了",
                  style: TextStyle(
                    fontSize: 12.auto,
                    color: CustomColor.grey
                  ),
                ),
              )
              :Container()
        ]
      );
    }

    else{
      return Container(
        color: Colors.white,
        child: _getTransactionCellItem()
      );
    }
  }

  _getTransactionCellItem({bool isLast = false}) => Column(
      children:[
        Container(
          margin: EdgeInsets.only(top:5.auto),
          child: Row(
            children: [
              Expanded(
                flex:2,
                child: AutoSizeText(
                  text1??"",
                  style: TextStyle(
                      fontSize: 12.auto,
                      color: Colors.grey[700]
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),

              ),
              Expanded(
                flex: 1,
                child: AutoSizeText(
                  text2??"",
                  style: TextStyle(
                      fontSize: 12.auto,
                      color: Colors.grey[700]
                  ),
                  textAlign: TextAlign.center,
                ),

              ),
              Expanded(
                flex: 1,
                child: AutoSizeText(
                  text3??"",
                  style: TextStyle(
                      fontSize: 12.auto,
                      color: Colors.grey[700]
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

            ],
          ),
        ),
        isLast?Container():Divider(
            thickness: (1.0).auto,
            color: CustomColor.very_light_pink_four,
          )
      ]
  );

  _getDisplayText() {
    /*if (T == AccountTransaction) {
      AccountTransaction value = widget.value as AccountTransaction;
      text1 = value.actionTime;
      text2 = value.actionTypeStr;
      text3 = value.amount;
    }
    if (T == BetTransaction) {
      BetTransaction value = widget.value as BetTransaction;
      text1 = value.betTime;
      text2 = value.betContent;
      text3 = value.realBetAmount;
    }
    if (T == DailyTransaction) {
      DailyTransaction value = widget.value as DailyTransaction;
      text1 = value.betTime.toString();
      text2 = value.winLoss.toString();
      text3 = value.betAmount.toString();
    }*/
  }
}

