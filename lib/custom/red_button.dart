import 'package:flutter/material.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/custom_color.dart';

class RedButton extends StatelessWidget {
  final String title;
  final Function onClick;
  final bool isEnabled;

  RedButton({Key key,
    @required this.title,
    this.onClick,
    this.isEnabled
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 70,
      height: 30,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(45)),
        color: Colors.red,
        onPressed: isEnabled?() => {
          this.onClick()
        }:(){

        },
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.auto
              ),
            )
          ],
        ),
      ),
    );
  }
}