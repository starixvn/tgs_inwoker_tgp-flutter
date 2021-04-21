import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tgp_flutter/entity/game.dart';
import 'package:tgp_flutter/entity/game_provider2.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/home/child_game/child_game_platform_tab_bar_view.dart';
import 'package:tgp_flutter/ui/base_state.dart';

class ChildGamePlatform extends StatefulWidget {
  final List<GameProvider2> platformList;
  final List<Game> gameList;
  final bool isSearching;
  final Function(int) onFilterPlatform;
  final String initialPlatformCode;

  ChildGamePlatform({this.platformList, this.gameList, this.isSearching, this.onFilterPlatform, this.initialPlatformCode});

  @override
  _ChildGamePlatformState createState() => _ChildGamePlatformState();
}

class _ChildGamePlatformState extends BaseState<ChildGamePlatform> with SingleTickerProviderStateMixin {
  var _platformTabController;
  var platformTabIndex = 0;
  var _platformTabList = ["全部"];

  @override
  void initState() {
    initData();
    _platformTabController =
        TabController(length: widget.platformList.length + 1, vsync: this, initialIndex: platformTabIndex);
    super.initState();
  }

  initData(){
    widget.platformList.asMap().forEach((index, value)  {
      _platformTabList.add(value.name);
      if(value.code == widget.initialPlatformCode){
        platformTabIndex = index+1;
      }
    });;
  }

  Widget build(BuildContext context) {
    return Column(children: [
      _buildPlatformTabBar(),
      Expanded(
          child: ChildGamePlatformTabBarView(
        gameList: widget.gameList,
        isDisabled: widget.isSearching,
      )),
    ]);
  }

  _buildPlatformTabBar() => Container(
        margin: EdgeInsets.symmetric(vertical: 8.auto, horizontal: 5.auto),
        constraints: BoxConstraints(maxHeight: 30.auto),
        width: context.screenWidth,
        child: TabBar(
          controller: _platformTabController,
          isScrollable: true,
          unselectedLabelColor: CustomColor.theme_button_disable_bg,
          labelColor: CustomColor.theme_button_disable_bg,
          indicatorWeight: 3,
          onTap: (index) => widget.onFilterPlatform(index),
          indicator: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: CustomColor.theme_button_disable_bg),
              borderRadius: BorderRadius.circular(15.auto),
            ),
          ),
          unselectedLabelStyle: TextStyle(color: CustomColor.theme_button_disable_bg),
          tabs: _platformTabList.map((item) {
            return Tab(
              child: Text(item,
                  style: TextStyle(
                    fontFamily: 'PingFang',
                    fontSize: 14.auto,
                  )),
            );
          }).toList(),
        ),
      );
}
