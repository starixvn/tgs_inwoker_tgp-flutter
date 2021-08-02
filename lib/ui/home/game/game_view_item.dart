import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:api_package/entity/game.dart';
import 'package:api_package/entity/game_provider2.dart';
import 'package:api_package/entity/game_type.dart';
import 'package:api_package/extension/screen_apis.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/home/child_game/child_game.dart';
import 'package:tgp_flutter/ui/home/home_view_model.dart';

class GameViewItem extends StatefulWidget {
  final ScrollController controller;
  final List<dynamic> gameProviderList;
  final Function(GameProvider2) onGameClick;
  final Key key;


  GameViewItem(this.key,{@required this.controller, this.gameProviderList, this.onGameClick}): super(key: key);

  @override
  GameViewItemState createState() => GameViewItemState();

}

class GameViewItemState extends BaseState<GameViewItem> {
double _imageRatio = 750 / 330;
double _containerPaddingRight = 5.auto;
double _listViewPaddingRight = 5.auto;
double _itemPaddingRight = 5.auto;
double _itemPaddingLeft = (8.5).auto;
double _itemPaddingTop = (12.5).auto;
double _itemPaddingBottom = (5).auto;

double get _itemWidth =>  context.size.width-_containerPaddingRight-_listViewPaddingRight-_itemPaddingRight-_itemPaddingLeft;
double get itemHeight => _itemWidth*(1/_imageRatio)+_itemPaddingTop+_itemPaddingBottom;


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(
          right: _containerPaddingRight,
        ),
        decoration: BoxDecoration(color: CustomColor.very_light_pink_four, borderRadius: BorderRadius.circular(5.auto)),
        child: RawScrollbar(
          isAlwaysShown: true,
          thumbColor: CustomColor.theme_bar_gradient_2,
          thickness: 3.5,
          radius: Radius.circular(1.4),
          controller: widget.controller,
          child: ListView(
              padding: EdgeInsets.only(right: _listViewPaddingRight),
              controller: widget.controller,
              children: widget.gameProviderList
                  .expand((element) => element)
                  .toList()
                  .map((item) => Container(
                  padding: EdgeInsets.only(left: _itemPaddingLeft, right:_itemPaddingRight, top: _itemPaddingTop, bottom: _itemPaddingBottom),
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
        aspectRatio: _imageRatio,
        child: Container(
           // color: Colors.blue,
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
