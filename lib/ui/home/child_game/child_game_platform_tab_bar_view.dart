import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tgp_flutter/entity/game.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/ui/home/child_game/child_game_item.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/home/game/game_view_model.dart';

class ChildGamePlatformTabBarView extends StatefulWidget {
  final List<Game> gameList;
  final Function onClick;
  final bool isDisabled;
  final GameViewModel vm;

  ChildGamePlatformTabBarView({@required this.gameList, this.onClick, this.isDisabled, this.vm});

  @override
  _ChildGamePlatformTabBarViewState createState() => _ChildGamePlatformTabBarViewState();
}

class _ChildGamePlatformTabBarViewState extends BaseState<ChildGamePlatformTabBarView> {
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.all(10.auto),
      crossAxisCount: 2,
     childAspectRatio: 165.5/198,
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
              //isFavourite: true,
              isDisabled: widget.isDisabled ?? false,
              vm: widget.vm,
            ));
      }),
    );
  }
}
