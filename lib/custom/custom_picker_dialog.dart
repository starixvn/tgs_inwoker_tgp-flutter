import 'package:flutter/material.dart';
import 'package:tgp_flutter/entity/bank_card.dart';
import 'package:tgp_flutter/entity/bank_type.dart';
import 'package:tgp_flutter/entity/game_provider.dart';
import 'package:tgp_flutter/entity/payment.dart';
import 'package:tgp_flutter/entity/wallet.dart';
import 'package:tgp_flutter/entity/withdrawal_info.dart';
import 'package:tgp_flutter/extension/format.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/base_state.dart';

class CustomPickerDialog extends StatefulWidget {
  final String title;
  final List<dynamic> list;
  final ValueChanged<dynamic> onChanged;

  CustomPickerDialog({
    Key key,
    @required this.title,
    this.list,
    this.onChanged,
  }) : super(key: key);

  @override
  _CustomPickerDialogState createState() => _CustomPickerDialogState();
}

class _CustomPickerDialogState extends BaseState<CustomPickerDialog> {
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(children: [
        Container(
          alignment: Alignment.center,
          width: context.screenWidth,
          padding: EdgeInsets.only(bottom: 5),
          margin: EdgeInsets.only(left: 5, right: 5, top: 5),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey, width: 1.0))),
          child: Text(
            getTranslatedText(widget.title) ?? "",
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
              title: _getPickerItem(index),
              onTap: () {
                widget.onChanged(widget.list[index]);
              },
              hoverColor: Colors.transparent,
              dense: true,
            );
          }),
        ),
      ]),
    );
  }

  _getText(int index) {
    if (widget.list is List<Payment> || widget.list is List<WithdrawalInfo>) {
      var name = widget.list[index].channelName.replaceAll(RegExp("_"), " ");
      return name;
    } else if (widget.list is List<GameProvider>) {
      GameProvider game = widget.list[index];
      return game.name;
    } else if (widget.list is List<BankType>) {
      BankType bankType = widget.list[index];
      return bankType.displayName;
    } else if (widget.list is List<Wallet>) {
      Wallet wallet = widget.list[index];
      return (wallet.isMainWallet) ? getTranslatedText(wallet.title) : wallet.title;
    } else{
      //string
      if(widget.list[index] =="BankTransfer")
        return getTranslatedText("bank_transfer");
      else if(widget.list[index] =="Crypto")
        return getTranslatedText("crypto");
      else return widget.list[index];
    }
  }

  _getPickerItem(index) => widget.list is List<BankCard>
      ? _getBankCardPickerItem(index)
      : Text(
          _getText(index),
          style: TextStyle(fontSize: 13.auto),
          textAlign: TextAlign.center,
        );

  _getBankCardPickerItem(index) {
    BankType bankType= widget.list[index].bankType;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          bankType.displayName,
          style: TextStyle(fontSize: 13.auto),
          textAlign: TextAlign.center,
        ),
        Text(
          bankType == BankType.CRYPTO
              ? (widget.list[index].bankDetail.address)
              : (widget.list[index].bankDetail.bankAccount ?? ""),
          style: TextStyle(fontSize: 13.auto),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
