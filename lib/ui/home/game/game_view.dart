import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/custom_dialog.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/entity/game.dart';
import 'package:tgp_flutter/entity/game_provider.dart';
import 'package:tgp_flutter/entity/game_provider2.dart';
import 'package:tgp_flutter/entity/game_type.dart';
import 'package:tgp_flutter/entity/user_profile.dart';
import 'package:tgp_flutter/localizations/language_provider.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/home/child_game/child_game.dart';
import 'package:tgp_flutter/ui/home/game/game_view_item.dart';
import 'package:tgp_flutter/ui/home/game/game_view_model.dart';
import 'package:tgp_flutter/ui/home/game/game_web_view.dart';
import 'package:tgp_flutter/ui/login/login.dart';

class GameView extends StatefulWidget {
  GameView();

  @override
  _GameViewState createState() => _GameViewState();
}

class _GameViewState extends BaseState<GameView> {
  var _controller = ScrollController();
  var currentTabIndex = 0;
  GlobalKey<GameViewItemState> gameViewItem = GlobalKey();
  var _vm = GameViewModel();
  var gameName;

  @override
  void initState() {
    _controller.addListener(_scrollListener);
    _vm.getGameProviderList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<GameViewModel>(
        model: _vm,
        builder: (ctx, vm, _) {
          _handleApiState();
          return _vm.gameProviderList == null
              ? buildProgressDialog()
              : Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10.auto, right: 10.auto, bottom: 5.auto),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Container(
                            margin: EdgeInsets.only(right: 10.auto, bottom: 5.auto),
                            child: Column(
                              children: List.generate(_vm.gameTypeList.length, (index) {
                                return Container(
                                  margin: EdgeInsets.only(top: 8.auto),
                                  child: _buildGameTab(index, _vm.gameTypeList[index].getName(context)),
                                );
                              }),
                            ),
                          ),
                        ),
                        Container(
                          child: GameViewItem(
                            gameViewItem,
                            controller: _controller,
                            gameProviderList: _vm.gameProviderList,
                            onGameClick: (game) => _onGameClick(game),
                          ),
                        )
                      ],
                    ),
                  ),
                );
        });
  }

  _buildGameTab(int tabIndex, String title) {
    // var bgImage = tabIndex == currentTabIndex ? "btn_home_game_category_selected_bg" : "btn_home_game_category_bg";
    return InkWell(
      onTap: () {
        _onTabClick(tabIndex);
      },
      child: Container(
        width: (62.5).auto,
        //context.screenWidth/7,
        height: (33.5).auto,
        //context.screenHeight/23,
        decoration: tabIndex == currentTabIndex ? gameTabGradientDecoration : gameTabColorDecoration,
        padding: EdgeInsets.all(3.auto),
        child: Center(
            child: AutoSizeText(
          title,
          style: TextStyle(
              fontSize: 17,
              shadows: [
                tabIndex == currentTabIndex
                    ? Shadow(
                        blurRadius: 1.5,
                        color: Colors.black,
                        offset: Offset(0, 2.0),
                      )
                    : Shadow(),
              ],
              color: tabIndex == currentTabIndex ? CustomColor.theme_label_text_highlight_color : Colors.black),
          minFontSize: 10,
          stepGranularity: 1,
          textAlign: TextAlign.center,
        )),
      ),
    );
  }

  _onTabClick(int tabIndex) {
    var itemHeight = gameViewItem.currentState.itemHeight;
    var des = 0.0;

    _vm.gameProviderList.asMap().forEach((i, element) {
      if (tabIndex > i) {
        des += itemHeight * _vm.gameProviderList[i].length;
      }
    });
    setState(() {
      //  currentTabIndex = tabIndex;
      _controller.animateTo(des, curve: Curves.linear, duration: Duration(milliseconds: 250));
    });
  }

  _scrollListener() {
    var scrollTab = gameViewItem.currentState.itemHeight;
    var des = 0.0;
    var index = 0;

    _vm.gameProviderList.asMap().forEach((i, element) {
      if (_controller.offset >= des) {
        des += scrollTab * _vm.gameProviderList[i].length;
        index = i;
      } else if (_controller.offset >= _controller.position.maxScrollExtent) {
        index = _vm.gameProviderList.length - 1;
      }
    });
    setState(() {
      currentTabIndex = index; //1
    });
  }

  _onGameClick(GameProvider2 gameProvider) {
    if (_vm.userProfile == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) => CustomDialog(
          title: getTranslatedText("login_hint"),
          description: getTranslatedText("login_dialog_des"),
          buttonText1: getTranslatedText("login_or_signup"),
          buttonText2: getTranslatedText("got_it"),
          onClick: this.navigateToLogin,
          onClick2: () {
            Navigator.pop(context);
          },
        ),
      );
    } else
      _navigate(gameProvider.code, gameProvider.gameType);
  }

  navigateToLogin() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushNamed("/login");
    });
  }

  _navigate(String gamePlatformCode, GameType gameType) async {
    if (gameType == GameType.Slot || gameType == GameType.EGame || gameType == GameType.Fishing) {
      //navigate to child game
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChildGame(
                      gamePlatformCode: gamePlatformCode,
                      gameType: gameType,
                    )));
      });
    } else {
      //navigate to game web
      /*ProgressDialog.show(context);
      await _vm.getGameList(gamePlatformCode, gameType);
      ProgressDialog.hide();*/
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => GameWeb(gamePlatformCode: gamePlatformCode, gameType: gameType)));
      });
    }
  }

  _handleApiState() {
    handleApiState(_vm.getGameProviderListApiState, isAutoHideLoading: false, onSuccess: () {});
    handleApiState(_vm.getGameApiState, onSuccess: () {});
  }
}
