import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tgp_flutter/extension/format.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/base_state.dart';

class TransactionHeaderItem extends StatefulWidget {
  final List<String> headerList;
  final bool isUploadButton;

  const TransactionHeaderItem({
    required this.headerList,
    required this.isUploadButton,
  });

  @override
  _TransactionHeaderItemState createState() => _TransactionHeaderItemState();
}

class _TransactionHeaderItemState extends BaseState<TransactionHeaderItem> {
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.auto, horizontal: 20.auto),
      child: Row(
          children: List.generate(widget.headerList.length, (index) {
        return Expanded(
          flex: /*(index == 3 && widget.isUploadButton) ? 1 :*/ 2,
          child: index == 3 && widget.isUploadButton
              ? Container(
                  width: 45.auto,
                )
              : AutoSizeText(
                  getTranslatedText(widget.headerList[index]) ?? " ",
                  minFontSize: 5,
                  maxFontSize: 12,
                  stepGranularity: 1,
                  maxLines: 1,
                  textAlign: index == 0 ? TextAlign.start : TextAlign.center,
                ),
        );
      }).toList()),
    );
  }
}
