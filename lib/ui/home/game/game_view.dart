import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tgp_flutter/entity/game.dart';
import 'package:tgp_flutter/entity/game_provider.dart';
import 'package:tgp_flutter/entity/game_type.dart';
import 'package:tgp_flutter/entity/user_profile.dart';
import 'package:tgp_flutter/localizations/language_provider.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/home/game/game_content.dart';

class GameView extends StatefulWidget {
  final List<GameProvider> tabList;
  final List<List<GameType>> gameTypeList;

  GameView({
    @required
    this.tabList,
    this.gameTypeList
  });

  @override
  _GameViewState createState() => _GameViewState();
}

class _GameViewState extends BaseState<GameView> {
  var _controller = ScrollController();
  var itemRatio = 335/90;
  var currentTabIndex= 0;
  var key = GlobalKey();

  @override
  void initState() {
    _controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 10.auto, right: 10.auto, bottom: 5.auto),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 10.auto, bottom: 5.auto),
              child: Column(
                  children:List.generate(widget.tabList.length, (index) {
                    return Container(
                      margin: EdgeInsets.only(top: 8.auto),
                      child: _buildGameTab(index, widget.tabList[index].name),
                    );
                  }),
                /* widget.tabList.map((item) {
                    return Container(
                      margin: EdgeInsets.only(top: 8.auto),
                      child: _buildGameTab(item.name),
                    );
                  }).toList()*/
              ),
            ),
            Container(
              key: key,
              child: GameContent(
                controller: _controller,
                list: widget.gameTypeList,
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildGameTab(int tabIndex, String title) {
    var bgImage = tabIndex==currentTabIndex?"btn_home_game_category_selected_bg":"btn_home_game_category_bg";
    return InkWell(
      onTap: (){
        _onTabClick(tabIndex);
      },
      child: Container(
        width: (62.5).auto,
        height: (33.5).auto,
        decoration: BoxDecoration(
          image:DecorationImage(
            image: AssetImage("images/home/$bgImage.png"),
            fit: BoxFit.fill,
          ),
        ),
        padding: EdgeInsets.all(3.auto),
        child: Center(
            child: AutoSizeText(
              title,
              style: TextStyle(
                  fontSize: 17.auto,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    tabIndex==currentTabIndex?Shadow(
                      blurRadius:1.5,
                      color: Colors.black,
                      offset: Offset(0, 2.0),
                    ):Shadow(),
                  ],
                  color: tabIndex==currentTabIndex?CustomColor.theme_label_text_highlight_color: Colors.black
              ),
              minFontSize: 12.auto,
            )
        ),
      ),
    );
  }

  _onTabClick(int tabIndex){
    var width = key.currentContext.size.width;
    var itemHeight = (width+5.auto)*(1/itemRatio) + 10.auto;
    var des = 0.0;

    widget.gameTypeList.asMap().forEach((i,element) {
      if(tabIndex>i){
        des += itemHeight * widget.gameTypeList[i].length;
      }
    });
    setState(() {
      currentTabIndex = tabIndex;
      _controller.animateTo(des, curve: Curves.linear,
          duration: Duration(milliseconds: 250));
    });
  }

  _scrollListener(){
    var width = key.currentContext.size.width;
    var scrollTab = (width+5.auto)*(1/itemRatio) + 10.auto;
    var des = 0.0;
    var index = 0;

    widget.gameTypeList.asMap().forEach((i,element) {
      if(_controller.offset >= des){
        des += scrollTab * widget.gameTypeList[i].length;
        index=i;
      }else if(_controller.offset >= _controller.position.maxScrollExtent){
        index = widget.gameTypeList.length-1;
      }
    });
    setState(() {
      currentTabIndex = index;//1
    });
  }
}