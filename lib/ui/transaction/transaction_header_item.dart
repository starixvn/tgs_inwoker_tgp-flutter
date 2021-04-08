import 'package:flutter/material.dart';
import 'package:tgp_flutter/extension/format.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/base_state.dart';

class TransactionHeaderItem extends StatefulWidget{
  final List<String> headerList;

  const TransactionHeaderItem({Key key,
    this.headerList
  }) : super(key: key);


  @override
  _TransactionHeaderItemState createState() => _TransactionHeaderItemState();
}

class _TransactionHeaderItemState extends BaseState<TransactionHeaderItem> {
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.auto, horizontal: 20.auto),
      child: Row(
          children:
          List.generate(widget.headerList.length, (index) {
            return Expanded(
              //first header (time) flex number is 2, others will be 1
              flex: index == 0 ? 2: 1,
              child: Text(
                getTranslatedText(widget.headerList[index]),
                style: TextStyle(
                    fontSize: 12.auto
                ),
                textAlign: TextAlign.center,
              ),
            );
          }).toList()
      ),
    );
  }
}