import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tgp_flutter/entity/game.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/ui/home/child_game/child_game_item.dart';
import 'package:tgp_flutter/ui/base_state.dart';

class ChildGamePlatformTabBarView extends StatefulWidget{
  final List<Game> gameList;
  final Function onClick;

  ChildGamePlatformTabBarView({
    @required
    this.gameList,
    this.onClick
  });
  @override
  _ChildGamePlatformTabBarViewState createState() => _ChildGamePlatformTabBarViewState();
}

class _ChildGamePlatformTabBarViewState  extends BaseState<ChildGamePlatformTabBarView> {
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: AlwaysScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: List.generate(widget.gameList.length, (index) {
        return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ChildGameItem(
              game: widget.gameList[index],
              isFavourite: true,
            )
        );
      }),
    );
  }
}