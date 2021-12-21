import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/entity/game.dart';
import 'package:tgp_flutter/entity/game_provider2.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/home/child_game/child_game_platform_tab_bar_view.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/home/game/game_view_model.dart';

class ChildGamePlatform extends StatefulWidget {
  final List<Game>? gameList;
  final bool isSearching;
  final Function(String) onFilterPlatform;
  final String initialPlatformCode;
  final GameViewModel vm;

  ChildGamePlatform({
    this.gameList,
    this.isSearching = false,
    required this.onFilterPlatform,
    required this.initialPlatformCode,
    required this.vm,
  });

  @override
  _ChildGamePlatformState createState() => _ChildGamePlatformState();
}

class _ChildGamePlatformState extends BaseState<ChildGamePlatform> with SingleTickerProviderStateMixin {
  late TabController _platformTabController;
  var platformTabIndex = 0;
  List<Map<String, String>> _platformTabList = [
    {"name": "all", "code": "ALL"}
  ];
  var isFirst;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _platformTabController.dispose();
    super.dispose();
  }

  getPlatformList() {
    List<Map<String, String>> list = [
      {"name": "all", "code": "ALL"}
    ];
    widget.vm.platformList!.asMap().forEach((index, value) {
      list.add({"name": value.name ?? "", "code": value.code ?? ""});
      if (value.code == widget.initialPlatformCode) {
        platformTabIndex = index + 1;
      }
    });
    _platformTabList = list;
    _platformTabController = TabController(length: list.length, vsync: this, initialIndex: platformTabIndex);
  }

  Widget build(BuildContext context) {
    return Column(children: [
      _buildPlatformTabBar(),
      Expanded(
          child: ChildGamePlatformTabBarView(
        gameList: widget.gameList!,
        isDisabled: widget.isSearching,
        vm: widget.vm,
      )),
    ]);
  }

  _buildPlatformTabBar() {
    getPlatformList();
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.auto, horizontal: 5.auto),
      constraints: BoxConstraints(maxHeight: 30.auto),
      width: context.screenWidth,
      child: TabBar(
        controller: _platformTabController,
        isScrollable: true,
        unselectedLabelColor: CustomColor.theme_button_disable_bg,
        labelColor: CustomColor.theme_button_disable_bg,
        indicatorWeight: 3,
        onTap: (index) {
          setState(() {
            platformTabIndex = index;
          });
          widget.onFilterPlatform(_platformTabList[index]["code"]!);
        },
        indicator: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: CustomColor.theme_button_disable_bg),
            borderRadius: BorderRadius.circular(15.auto),
          ),
        ),
        unselectedLabelStyle: TextStyle(color: CustomColor.theme_button_disable_bg),
        tabs: _platformTabList.map<Widget>((item) {
          return Tab(
            child: Text(item["code"] == "ALL" ? getTranslatedText(item["name"]!) : item["name"],
                style: TextStyle(
                  fontFamily: 'PingFang',
                  fontSize: 14.auto,
                )),
          );
        }).toList(),
      ),
    );
  }
}
