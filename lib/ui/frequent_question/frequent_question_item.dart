import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/transaction/transaction.dart';


class FrequentQuestionItem extends StatefulWidget{
  final String number;
  final String title;
  final String description;

  FrequentQuestionItem({Key key,
    this.number,
    this.title,
    this.description
  }) : super(key: key);

  @override
  _FrequentQuestionItemState createState() => _FrequentQuestionItemState();
}

class _FrequentQuestionItemState extends BaseState<FrequentQuestionItem> {
  var show = false;
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.auto),
      child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            setState(() {
              show=!show;
            });
          },
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.number}、",
                      style: TextStyle(
                          fontSize: 14.auto,
                          color: CustomColor.theme_title_text_color
                      ),
                    ),
                    Expanded(
                      child: Text(
                        widget.title,
                        style: TextStyle(
                            fontSize: 14.auto,
                            color: CustomColor.theme_title_text_color
                        ),
                      ),
                    ),
                    show?Icon(
                      Icons.keyboard_arrow_up,
                      color: CustomColor.theme_title_text_color,
                    ):Icon(
                      Icons.keyboard_arrow_down,
                      color: CustomColor.theme_title_text_color,
                    )
                  ],
                ),
              ),
              show?Container(
                margin: EdgeInsets.only(top: 20.auto),
                child: Text(
                  widget.description,
                  style: TextStyle(
                      fontSize: 14.auto,
                      color: CustomColor.theme_title_text_color
                  ),
                ),
              ):Container()
            ],
          )
      ),
    );
  }
}
