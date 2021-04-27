import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/color_button.dart';
import 'package:tgp_flutter/entity/game_provider.dart';
import 'package:tgp_flutter/extension/format.dart';
import 'package:tgp_flutter/extension/navigate_without_animation.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/base_state.dart';

class MessageActionDialog extends StatefulWidget {
  MessageActionDialog({
    Key key,
  }) : super(key: key);

  @override
  _MessageActionDialogState createState() => _MessageActionDialogState();
}

class _MessageActionDialogState extends BaseState<MessageActionDialog> {
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.auto, right: 10.auto, bottom: 10.auto),
      child: Wrap(children: [
        ColorButton(
            text: Text(
              "删除",
              style: TextStyle(fontSize: 17.2.auto, color: Colors.red),
            ),
            onClick: () {},
            isEnabled: true,
            color: Colors.white,
            radius: 11.6.auto),
        ColorButton(
            text: Text(
              "取消",
              style: TextStyle(fontSize: 17.2.auto, color: Colors.black),
            ),
            onClick: () {
              Navigator.pop(
                context,
                NavigateWithoutAnimation(),
              );
            },
            isEnabled: true,
            color: Colors.white,
            radius: 11.6.auto),
      ]),
    );
  }
}
