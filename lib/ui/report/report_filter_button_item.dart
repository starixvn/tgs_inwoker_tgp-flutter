import 'package:flutter/material.dart';
import 'package:tgp_flutter/extension/format.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/base_state.dart';

class ReportFilterButtonItem extends StatefulWidget {
  final int index;
  final ValueChanged<int> onTextChanged;

  const ReportFilterButtonItem({required this.index, required this.onTextChanged});

  @override
  _ReportFilterButtonItemState createState() => _ReportFilterButtonItemState();
}

class _ReportFilterButtonItemState extends BaseState<ReportFilterButtonItem> {
  var currentFilterIndex = 0;
  var filterTabList = [
    {"id": "0", "text": "today"},
    {"id": "1", "text": "one_week"},
    {"id": "2", "text": "one_month"},
  ];

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.auto, horizontal: 20.auto),
      child: Row(
          children: List.generate(filterTabList.length, (index) {
        return Container(
          child: _buildFilterButton(index, filterTabList[index]["text"]!),
        );
      })),
    );
  }

  _buildFilterButton(int index, String text) => Expanded(
        flex: 1,
        child: InkWell(
          onTap: () {
            widget.onTextChanged(index);
          },
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Text(
            getTranslatedText(text),
            style: TextStyle(
                fontSize: widget.index == index ? 15.auto : 12.auto,
                color: widget.index == index ? CustomColor.theme_bar_gradient_2 : Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
      );
}
