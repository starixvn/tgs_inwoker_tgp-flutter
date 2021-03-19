import 'package:flutter/material.dart';
import 'package:tgp_flutter/extension/format.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/custom_color.dart';

class CustomPickerDialog extends StatefulWidget{
  final String title;
  final List<dynamic> list;
  final ValueChanged<dynamic> onChanged;

  CustomPickerDialog({Key key,
    @required this.title,
    this.list,
    this.onChanged,
  }) : super(key: key);

  @override
  _CustomPickerDialogState createState() => _CustomPickerDialogState();
}

class _CustomPickerDialogState extends State<CustomPickerDialog> {
  //var isListEmpty = false;
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
          children: [
            Container(
              alignment: Alignment.center,
              width: context.screenWidth,
              padding: EdgeInsets.only(bottom: 5),
              margin: EdgeInsets.only(left: 5, right: 5, top: 5),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Colors.grey,
                          width: 1.0
                      )
                  )
              ),
              child: Text(
                widget.title??"",
                style: TextStyle(
                  fontSize: 13.auto,
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Wrap(
              children: List.generate(widget.list.length, (index) {
                return ListTile(
                  title: Container(),
                  onTap: () {
                    widget.onChanged(widget.list[index]);
                  },
                  hoverColor: Colors.transparent,
                  dense: true,
                );
              }),

            ),
          ]
      ),
    );
  }

  _getText(int index){
    /*if(widget.list is List<Payment>){
      return widget.list[index].title;
    }
    else if(widget.list is List<DepositBonus>) {
      return widget.list[index].bospTitle;
    }
    else if(widget.list is List<TransactionActionType>){
      List<TransactionActionType> list = widget.list;
      return list[index].displayName;
    }
    else if(widget.list is List<TransactionStatusType>){
      List<TransactionStatusType> list = widget.list;
      return list[index].displayName;
    }
    else if(widget.list is List<TransactionThirdPartyType>){
      List<TransactionThirdPartyType> list = widget.list;
      return list[index].displayName;
    }
    else if(widget.list is List<TransactionBetStatusType>){
      List<TransactionBetStatusType> list = widget.list;
      return list[index].displayName;
    }
    //for thirdPartyList
    else if(widget.list is List<TransactionThirdParty>){
      return widget.list[index].name;
    }
    else if(widget.list is List<BankCard>){
      var bank = widget.list[index];
      return bank.getDisplayString();
    }
    else*/ return widget.list[index];
  }

  /*_getPickerItem(index){
    //title and text display in the same row
    if(widget.list is List<Wallet>) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: context.screenWidth/2 - 16.auto,
            padding:  EdgeInsets.only(right: 8.auto),
            child: Text(
              widget.list[index].name,
              style: TextStyle(
                  fontSize: 13.auto
              ),
              textAlign: TextAlign.right,
            ),
          ),
          Container(
            width: context.screenWidth/2 -16.auto,
            padding:  EdgeInsets.only(left: 8.auto),
            child: Text(
              Format().amountFormat(widget.list[index].balance),
              style: TextStyle(
                  fontSize: 13.auto,
                  color: Colors.red
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      );
    }
    //only text will display
    else{
      return Text(
        _getText(index),
        style: TextStyle(
            fontSize: 13.auto
        ),
        textAlign: TextAlign.center,
      );
    }
  }*/

}