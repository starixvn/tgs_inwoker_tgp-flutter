import 'package:flutter/material.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/custom_color.dart';

class CustomTabBar extends StatefulWidget{
  final int index;

  CustomTabBar({Key key,
    this.index
  }) : super(key: key);

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
                "STEP 1",
                style: TextStyle(
                  fontFamily: 'PingFang',
                  fontSize: 10.auto,
                    color: (widget.index ==1) ? Colors.red: Colors.red
                ),
                textAlign: TextAlign.center
            ),
            Container(
              width: context.screenWidth/2 - 20.auto,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  bottomLeft: Radius.circular(25.0),
                ),
                border: Border.all(
                  width: 2.0,
                  color: (widget.index ==1) ? Colors.red: Colors.red
                )
              ),
              margin: EdgeInsets.symmetric(vertical: 3.auto),
            ),
            Text(
                "验证原号码",
                style: TextStyle(
                    fontFamily: 'PingFang',
                    fontSize: 14.auto,
                    color: (widget.index ==1) ? Colors.red: Colors.red
                ),
                textAlign: TextAlign.center
            ),
          ],
        ),

        Column(
          children: [
            Text(
                "STEP 2",
                style: TextStyle(
                    fontFamily: 'PingFang',
                    fontSize: 10.auto,
                    color: (widget.index ==2) ? Colors.red: Colors.red
                ),
                textAlign: TextAlign.center
            ),
            Container(
              width: context.screenWidth/2 - 20.auto,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0),
                  ),
                  border: Border.all(
                      width: 2.0,
                      color: (widget.index ==2) ? Colors.red: Colors.red
                  )
              ),
              margin: EdgeInsets.symmetric(vertical: 3.auto),
            ),
            Text(
                "设定新号码",
                style: TextStyle(
                    fontFamily: 'PingFang',
                    fontSize: 14.auto,
                    color: (widget.index ==2) ? Colors.red: Colors.red
                ),
                textAlign: TextAlign.center
            ),
          ],
        ),
      ],
    );
  }
}