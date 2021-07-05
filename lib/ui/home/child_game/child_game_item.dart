import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/entity/game.dart';
import 'package:tgp_flutter/entity/game_type.dart';
import 'package:tgp_flutter/environment_config.dart';
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
  var languageCode;

  @override
  void initState() {
    _initData();
    super.initState();
  }

  _initData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var code = _prefs.getString("LANGUAGE_CODE");
    setState(() {
      if (code == "zh-TW")
        languageCode = "zh-CN";
      else
        languageCode = code;
    });
  }

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

  _buildImage() {
    return Expanded(
        flex: 4,
        child: CachedNetworkImage(
            placeholder: (context, url) => Container(
                  color: CustomColor.very_light_pink_four,
                ),
            imageUrl: _getImageUrl(),
            //handling error
            width: 165.5.auto,
            fit: BoxFit.cover)
    );
  }

  _getImageUrl() {
    //http://images.srvptt.com/PP/PowerofThorMegaways.jpg
    //https://images.srvptt.com/HABA/BirdofThunder.jpg
    //https://images.srvptt.com/SW/zh-CN/3CardBrag.jpg
    //https://images.srvptt.com/JDB/zh-CN/CaiShenFishing.jpg
    var gameName = widget.game.code.replaceAll(RegExp("_"), "");

    if (widget.game.gamePlatformCode == "PP" || widget.game.gamePlatformCode == "HABA")
      return EnvironmentConfig.slotGameUrl + "${widget.game.gamePlatformCode.toUpperCase()}/$gameName.jpg";
    else if (gameName == "FishingYiLuFa")
      return EnvironmentConfig.slotGameUrl + "${widget.game.gamePlatformCode.toUpperCase()}/zh-CN/$gameName.jpg";
    else
      return EnvironmentConfig.slotGameUrl +
          "${widget.game.gamePlatformCode.toUpperCase()}/${languageCode ?? "en-US"}/$gameName.jpg";
  }

  _buildImageTitleAndFavouriteIcon() {
    return Expanded(
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
        child: /*Row(
          children: [ */
            Container(
              width: context.screenWidth,
              child:AutoSizeText(
                widget.game.localizedName?? widget.game.name,
                style: TextStyle(color: Colors.white),
                minFontSize: 3,
                stepGranularity: 1,
                maxLines: 1,
              ),
     ),
     /*       Expanded(
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
        ),*/
      ),
    );
  }

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
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GameWeb(
                    gamePlatformCode: game.gamePlatformCode,
                    gameId: game.id,
                  )));
    });
  }
}
