import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';

class ChildGameItem extends StatefulWidget{
  final bool isFavourite;
  final String imageUrl;

  ChildGameItem({
    this.isFavourite,
    this.imageUrl,
  });

  @override
  _ChildGameItemState createState() => _ChildGameItemState();
}

class _ChildGameItemState extends State<ChildGameItem> {
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Column(
        children:[
          Container(
            width: (165.5).auto,
            height: (131.1).auto,
            color: CustomColor.grey,
            /*child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.asset(
                      "images/promotion_1.png"
                  )
              )*/
          ),
          Container(
            decoration:BoxDecoration(
               gradient: LinearGradient(
                  colors: [
                    CustomColor.theme_bar_gradient_1,
                    CustomColor.theme_bar_gradient_2
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                )
            ),
            padding: EdgeInsets.only(left: 10.auto, right: 10.auto, top: 5.auto),
            child: Row(
              children: [
                Text("黄金之旅"),
                Spacer(),
                InkWell(
                  onTap: (){

                  },
                  child: Image.asset(
                    widget.isFavourite?"images/child_game/ic_like.png":"images/child_game/ic_unlike.png",
                    width: 20.auto,
                    height: 20.auto,
                  ),
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}