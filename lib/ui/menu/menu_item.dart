import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/custom_color.dart';

class MenuItem extends StatefulWidget{
  final String image;
  final String text;
  final String navigationPath;
  final int navigationID;

  MenuItem({
    this.image,
    this.text,
    this.navigationPath,
    this.navigationID
  });

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  var tabIndex;
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          FloatingActionButton(
            heroTag: null,
            onPressed: () {},
            child: ImageIcon(
              AssetImage("images/menu/${widget.image}.png"),
              size: 25.auto,
            ),
            backgroundColor: Colors.transparent,
            materialTapTargetSize: MaterialTapTargetSize.padded,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.auto),
                side: BorderSide(
                  color: Colors.white,
                  width: 1.0,
                )
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.auto),
            child: Text(
              widget.text,
              style: TextStyle(
                  fontSize: 10.auto,
                  color: Colors.white
              ),
            ),
          )
        ],
      ),
    );
  }
}
