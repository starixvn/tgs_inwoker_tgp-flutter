import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/home/child_game/child_game_platform.dart';

class ChildGame extends StatefulWidget{
  @override
  _ChildGameState createState() => _ChildGameState();
}

class _ChildGameState extends BaseState<ChildGame> with SingleTickerProviderStateMixin{
  var _groupTabController;
  var _groupTabIndex = 0;
  var _groupTabList =
  [
    "全部游戏",
    "最新游戏",
    "热门游戏",
    "收藏游戏",
    "捕鱼游戏",
    "历史游戏"
  ];

  @override
  void initState() {
    _groupTabController = TabController(length: _groupTabList.length, vsync: this, initialIndex: _groupTabIndex);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          flexibleSpace: Container(
            decoration: gradientDecoration,
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(getTranslatedText("slotgame_title"??""),
            style: TextStyle(fontSize: 16.auto),
          ),
        ),
        body: Column(
          children: [
            Container(
              color: CustomColor.theme_button_disable_bg,
              constraints: BoxConstraints(maxHeight: 35.auto),
              child: TabBar(
                controller: _groupTabController,
                isScrollable: true,
                unselectedLabelColor: Colors.white,
                labelColor: CustomColor.theme_label_text_highlight_color,
                indicatorColor: CustomColor.theme_label_text_highlight_color,
                indicatorWeight: 3,
                onTap: (index){
                  setState(() {
                    _groupTabIndex = index;
                  });
                },
                unselectedLabelStyle: TextStyle(
                    color: CustomColor.grey
                ),
                tabs: _groupTabList.map((item) {
                  return Tab(
                    child: Text(item,
                        style: TextStyle(
                          fontFamily: 'PingFang',
                          fontSize: 14.auto,
                        )),
                  );
                }).toList(),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _groupTabController,
                children: [
                  ChildGamePlatform(),
                  ChildGamePlatform(),
                  ChildGamePlatform(),
                  ChildGamePlatform(),
                  ChildGamePlatform(),
                  ChildGamePlatform(),
                ],
              ),
            ),
          ],
        )
    );
  }
}


