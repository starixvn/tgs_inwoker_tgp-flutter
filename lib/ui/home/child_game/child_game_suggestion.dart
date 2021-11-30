import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/entity/game.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/home/game/game_view_model.dart';
import 'package:tgp_flutter/ui/home/game/game_web_view.dart';
import 'package:tgp_flutter/ui/home/home_view_model.dart';

class ChildGameSuggestion extends StatefulWidget {
  final bool isVisible;
  final List<Game>? recommendList;

  ChildGameSuggestion({this.isVisible = false, this.recommendList});

  @override
  _ChildGameSuggestionState createState() => _ChildGameSuggestionState();
}

class _ChildGameSuggestionState extends BaseState<ChildGameSuggestion> {
 // var _vm = GameViewModel();

  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.isVisible,
      child: Container(
        width: context.screenWidth,
        margin: EdgeInsets.only(left: 10.auto, right: 10.auto, top: 5.auto),
        padding: EdgeInsets.all(10.auto),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.auto), color: Colors.white),
        child: GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            childAspectRatio: 96.6 / 25,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: List.generate(
                widget.recommendList!.length,
                (index) => Container(
                      height: (12.5).auto,
                      width: 50.auto,
                      child: _buildSearchSuggestionItem(widget.recommendList![index]),
                    ))),
      ),
    );
  }

  _buildSearchSuggestionItem(Game game) => InkWell(
        onTap: () => _navigateToGameWeb(game),
        child: Container(
          height: 5.auto,
          width: 50.auto,
          padding: EdgeInsets.symmetric(horizontal: 5.auto),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [CustomColor.theme_bar_gradient_1, CustomColor.theme_bar_gradient_2],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Center(
            child: AutoSizeText(
              game.name,
              style: TextStyle(color: Colors.white, fontSize: 15),
              minFontSize: 10,
              stepGranularity: 1,
            ),
          ),
        ),
      );

  _navigateToGameWeb(Game game) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => GameWeb(gamePlatformCode: game.gamePlatformCode, gameId: game.id,)));
    });
  }
}
