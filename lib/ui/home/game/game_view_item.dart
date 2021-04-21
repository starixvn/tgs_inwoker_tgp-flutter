import 'package:flutter/material.dart';
import 'package:tgp_flutter/entity/game.dart';
import 'package:tgp_flutter/entity/game_provider2.dart';
import 'package:tgp_flutter/entity/game_type.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/home/child_game/child_game.dart';
import 'package:tgp_flutter/ui/home/home_view_model.dart';

class GameViewItem extends StatefulWidget {
  final ScrollController controller;
  final List<dynamic> gameProviderList;
  final Function(GameProvider2) onGameClick;

  GameViewItem({@required this.controller, this.gameProviderList, this.onGameClick});

  @override
  _GameViewItemState createState() => _GameViewItemState();
}

class _GameViewItemState extends BaseState<GameViewItem> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(
          right: 5.auto,
        ),
        decoration: BoxDecoration(color: CustomColor.very_light_pink_four, borderRadius: BorderRadius.circular(5.auto)),
        child: RawScrollbar(
          isAlwaysShown: true,
          thumbColor: CustomColor.theme_bar_gradient_2,
          thickness: 3.5,
          radius: Radius.circular(1.4),
          controller: widget.controller,
          child: ListView(
              padding: EdgeInsets.only(right: 5.auto),
              controller: widget.controller,
              children: widget.gameProviderList
                  .expand((element) => element)
                  .toList()
                  .map((item) => Container(
                      padding: EdgeInsets.only(left: (8.5).auto, right: 5.auto, top: (12.5).auto, bottom: 5.auto),
                      child: GestureDetector(
                          onTap: () => widget.onGameClick(item),
                          child: Container(
                              width: 335.auto,
                              height: 90.auto,
                              color: Colors.blue,
                              alignment: Alignment.center,
                              child: Text(
                                item.name,
                              )))))
                  .toList()),
        ),
      ),
    );
  }
}
