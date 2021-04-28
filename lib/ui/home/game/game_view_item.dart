import 'package:auto_size_text/auto_size_text.dart';
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
                      child: GestureDetector(onTap: () => widget.onGameClick(item), child: _buildImage(item))))
                  .toList()),
        ),
      ),
    );
  }

  _getImagePath(GameProvider2 gameProvider) {
    var gameType = gameProvider.gameType.getImagePath();
    var gamePlatformCode = gameProvider.code.toLowerCase();
    var imagePath = "images/game/${gameType}_${gamePlatformCode}.png";
    return imagePath;
  }

  _buildImage(GameProvider2 gameProvider) => Stack(
        children: [
          AspectRatio(
            aspectRatio: 750 / 330,
            child: Container(
                color: Colors.blue,
                alignment: Alignment.center,
                child: Image.asset(
                  _getImagePath(gameProvider),
                  fit: BoxFit.cover,
                )),
          ),
          Positioned(
            bottom: context.screenWidth / 30,
            left: context.screenWidth / 12,
            child: Container(
              width: 74.auto,
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 5.auto, bottom: 5.auto),
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage("images/game/btn_start_game.png"))),
              child: Text(
                getTranslatedText("start_game"),
                style: TextStyle(
                  fontSize: 10.auto,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      );
}
