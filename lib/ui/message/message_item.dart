import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/round_check_box.dart';
import 'package:tgp_flutter/entity/message.dart';
import 'package:tgp_flutter/extension/format.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/base_state.dart';

class MessageItem extends StatefulWidget{
  final Message message;
  final bool isEditing;
  final Function(bool, Message) onSelected;

  MessageItem({
    this.message,
    this.isEditing,
    this.onSelected
  });

  @override
  _MessageItemState createState() => _MessageItemState();
}

class _MessageItemState  extends BaseState<MessageItem> {
  var isSelected = false;
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Row(
      children: [
        Visibility(
            visible: widget.isEditing,
            child: Expanded(
              flex: 1,
              child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: (){
                  _onChanged();
                  widget.onSelected(isSelected, widget.message);
                },
                child: isSelected?
                Image.asset(
                  "images/message/ic_message_selected_dot.png",
                  width: 22.auto, height: 22.auto,
                ) :
                Container(
                  width: 22.auto,
                  height: 22.auto,
                  margin: EdgeInsets.only(left: 6.auto, right: 6.auto),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                          width: 2,
                          color: CustomColor.theme_button_disable_bg
                      )
                  ),
                ),
              ),
            )
        ),
        Expanded(
          flex: 9,
          child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            elevation: 5,
            child:Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _messageDot(),
                  _messageContent()
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _messageDot() =>Visibility(
    visible: widget.message.isRead,
    child: Container(
      width: 8.auto,
      height: 8.auto,
      margin: EdgeInsets.only(top:10.auto, right: 10.auto),
      decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle
      ),
    ),
  );

  _messageContent() => Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.message.subject,
          style: TextStyle(
              fontSize: 15.auto
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical:5.auto),
          child: Text(
            Format().dateFormat(DateTime.parse(widget.message.createdOn)),
            style: TextStyle(
                fontSize: 10.auto,
                color: CustomColor.grey
            ),
          ),
        ),
        Text(
          widget.message.content,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style: TextStyle(
              fontSize: 12.auto,
              color: CustomColor.grey
          ),
        ),
      ],
    ),
  );

  _onChanged(){
    setState(() {
      isSelected = !isSelected;
    });
  }
}