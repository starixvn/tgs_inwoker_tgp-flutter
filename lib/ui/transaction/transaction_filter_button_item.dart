import 'package:flutter/material.dart';
import 'package:tgp_flutter/extension/format.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/base_state.dart';

class TransactionFilterButtonItem extends StatefulWidget{
  final bool isToday;
  final bool isWeek;
  final bool isMonth;
  final ValueChanged<int> onTextChanged;

  const TransactionFilterButtonItem({Key key,
    this.isToday,
    this.isWeek,
    this.isMonth,
    this.onTextChanged
  }) : super(key: key);


  @override
  _TransactionFilterButtonItemState createState() => _TransactionFilterButtonItemState();
}

class _TransactionFilterButtonItemState extends BaseState<TransactionFilterButtonItem> {
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(vertical: 10.auto,horizontal: 20.auto),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: (){
                widget.onTextChanged(1);
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Text("今天",
                style: TextStyle(
                    fontSize: widget.isToday?15.auto:12.auto,
                    color: widget.isToday?Colors.red:Colors.black
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex:1,
            child: InkWell(
              onTap: (){
                widget.onTextChanged(2);
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Text("1週",
                style: TextStyle(
                    fontSize: widget.isWeek?15.auto:12.auto,
                    color: widget.isWeek?Colors.red:Colors.black
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex:1,
            child: InkWell(
              onTap: (){
                widget.onTextChanged(3);
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Text("1个月",
                style: TextStyle(
                    fontSize: widget.isMonth?15.auto:12.auto,
                    color: widget.isMonth?Colors.red:Colors.black
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

}


