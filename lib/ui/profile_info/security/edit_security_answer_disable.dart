import 'package:flutter/material.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/ui/base_state.dart';

class EditSecurityAnswerDisable extends StatefulWidget{
  final String title;

  EditSecurityAnswerDisable({Key key,
    this.title,
  }) : super(key: key);

  @override
  _EditSecurityAnswerDisableState createState() => _EditSecurityAnswerDisableState();
}

class _EditSecurityAnswerDisableState extends BaseState<EditSecurityAnswerDisable> {
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey[100],
        padding: EdgeInsets.all(20.auto),
        child: Column(
          children: [
            Container(
                height: 80.auto,
                width: context.screenWidth - 20.auto,
                padding: EdgeInsets.all(20.auto),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.auto)
                ),
                child: Text(
                  widget.title,
                  style: TextStyle(
                      color: CustomColor.theme_title_text_color
                  ),
                )
            ),
          ],
        )
    );
  }
}