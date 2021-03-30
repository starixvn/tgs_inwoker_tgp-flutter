import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/ui/home/child_game/child_game_item.dart';

class ChildGamePlatformTabBarView extends StatefulWidget{
  @override
  _ChildGamePlatformTabBarViewState createState() => _ChildGamePlatformTabBarViewState();
}

class _ChildGamePlatformTabBarViewState extends State<ChildGamePlatformTabBarView> {
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: AlwaysScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: List.generate(6, (index) {
        return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ChildGameItem(
              imageUrl: "https://static.sixfeliz.com/static/Games/JDB/JDB_14044.jpg",
              isFavourite: true,
            )
        );
      }),
    );
  }
}


