import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/home/child_game/child_game_platform_tab_bar_view.dart';
import 'package:tgp_flutter/ui/base_state.dart';

class ChildGamePlatform extends StatefulWidget{
  @override
  _ChildGamePlatformState createState() => _ChildGamePlatformState();
}

class _ChildGamePlatformState  extends BaseState<ChildGamePlatform> with SingleTickerProviderStateMixin{
  var _platformTabController;
  var platformTabIndex = 0;
  var _platformTabList =
  [
    "全部",
    "AG",
    "BBIN",
    "JDB",
    "MG"
  ];

  @override
  void initState() {
    _platformTabController = TabController(length: _platformTabList.length, vsync: this, initialIndex: platformTabIndex);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Column(
        children:[
          Container(
            margin: EdgeInsets.symmetric(vertical: 8.auto,horizontal: 5.auto),
            constraints: BoxConstraints(maxHeight: 30.auto),
            child: TabBar(
              controller: _platformTabController,
              isScrollable: false,
              unselectedLabelColor: CustomColor.theme_button_disable_bg,
              labelColor: CustomColor.theme_button_disable_bg,
              indicatorWeight: 3,
              onTap: (index){
                setState(() {
                  platformTabIndex = index;
                });
              },
              indicator: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color:CustomColor.theme_button_disable_bg
                    ),
                      borderRadius: BorderRadius.circular(15.auto),
                  ),
              ),
              unselectedLabelStyle: TextStyle(
                  color: CustomColor.theme_button_disable_bg
              ),
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
          ),
          Expanded(
            child: TabBarView(
              controller: _platformTabController,
              children: [
                ChildGamePlatformTabBarView(),
                ChildGamePlatformTabBarView(),
                ChildGamePlatformTabBarView(),
                ChildGamePlatformTabBarView(),
                ChildGamePlatformTabBarView(),
              ],
            ),
          ),
        ]
    );
  }
}


