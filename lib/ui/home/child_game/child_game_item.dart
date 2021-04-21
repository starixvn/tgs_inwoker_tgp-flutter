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

class ChildGameItem extends StatefulWidget {
  final bool isFavourite;
  final Game game;
  final bool isDisabled;
  final String str;

  ChildGameItem({this.isFavourite, this.game, this.isDisabled, this.str});

  @override
  _ChildGameItemState createState() => _ChildGameItemState();
}

class _ChildGameItemState extends BaseState<ChildGameItem> {
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.isDisabled ? () {} : () => _navigateToGameWeb(widget.game),
      child: Container(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Stack(
            children: [
              Column(children: [
                _buildImage(),
                _buildImageTitleAndFavouriteIcon(),
              ]),
              _buildPlatformText()
            ],
          ),
        ),
      ),
    );
  }

  _buildImage() => Expanded(
      flex: 4,
      child: Image.asset(
        "images/child_game_image/${widget.game.gamePlatformCode.toLowerCase()}/${widget.game.code.replaceAll(RegExp("_"), "")}.png",
        width: 165.5.auto,
        fit: BoxFit.cover,
      ));

  _buildImageTitleAndFavouriteIcon() => Expanded(
        flex: 1,
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [CustomColor.theme_bar_gradient_1, CustomColor.theme_bar_gradient_2],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              )),
          padding: EdgeInsets.only(left: 10.auto, right: 10.auto, top: 5.auto),
          child: Row(
            children: [
              Expanded(
                flex: 9,
                child: AutoSizeText(
                  widget.game.name,
                  style: TextStyle(color: Colors.white),
                  minFontSize: 3,
                  stepGranularity: 1,
                  maxLines: 1,
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {},
                  child: Image.asset(
                    widget.isFavourite ? "images/child_game/ic_like.png" : "images/child_game/ic_unlike.png",
                    width: 20.auto,
                    height: 20.auto,
                  ),
                ),
              )
            ],
          ),
        ),
      );

  _buildPlatformText() => Positioned(
        top: context.screenWidth / 3.1,
        child: Container(
          margin: EdgeInsets.only(left: 10.auto, top: 5.auto),
          padding: EdgeInsets.symmetric(vertical: 5.auto, horizontal: 15.auto),
          decoration: BoxDecoration(color: CustomColor.black, borderRadius: BorderRadius.circular(15.0)),
          child: Text(
            widget.game.gamePlatformName(),
            style: TextStyle(color: Colors.white, fontSize: 9.auto),
          ),
        ),
      );

  _navigateToGameWeb(Game game) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => GameWeb(game: game)));
    });
  }
}
