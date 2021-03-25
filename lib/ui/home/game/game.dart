import 'package:flutter/material.dart';
import 'package:tgp_flutter/entity/user_profile.dart';
import 'package:tgp_flutter/localizations/language_provider.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/ui/home/game/game_content.dart';

class Game extends StatefulWidget {
  final List<Map<String, String>> tabList;
  final List<List<String>> gameList;

  Game({
    @required
    this.tabList,
    this.gameList
  });

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  var _controller = ScrollController();
  var itemRatio = 335/90;
  var currentTabIndex= "0";
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
                  children: widget.tabList.map((item) {
                    return Container(
                      margin: EdgeInsets.only(top: 8.auto),
                      child: _buildGameTab(item["text"], item["id"]),
                    );
                  }).toList()
              ),
            ),
            Container(
              key: key,
              child: GameContent(
                controller: _controller,
                list: widget.gameList,
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildGameTab(String title, String tabIndex) {
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
        child: Center(
            child: Text(
              LanguageProvider().getTranslated(context, title),
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
            )
        ),
      ),
    );
  }

  _onTabClick(String tabIndex){
    var width = key.currentContext.size.width;
    var itemHeight = (width+5.auto)*(1/itemRatio) + 10.auto;
    var index = int.parse(tabIndex);
    var des = 0.0;

    widget.gameList.asMap().forEach((i,element) {
      if(index>i){
        des += itemHeight * widget.gameList[i].length;
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

    widget.gameList.asMap().forEach((i,element) {
      if(_controller.offset >= des){
        des += scrollTab * widget.gameList[i].length;
        index=i;
      }else if(_controller.offset >= _controller.position.maxScrollExtent){
        index = widget.gameList.length-1;
      }
    });
    setState(() {
      currentTabIndex = index.toString();//1
    });
  }
}