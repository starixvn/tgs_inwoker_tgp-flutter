import 'package:flutter/material.dart';
import 'package:tgp_flutter/localizations/language_provider.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/home/home.dart';
import 'package:tgp_flutter/ui/promotion/promotion_item.dart';
import 'package:tgp_flutter/ui/promotion/promotion_view_model.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';

class PromotionPage extends StatefulWidget {
  @override
  _PromotionState createState() => _PromotionState();
}

class _PromotionState extends BaseState<PromotionPage> {
  var tabList = [
    {"id": "0", "text": "热门优惠"},
    {"id": "1", "text": "存提款"},
    {"id": "2", "text": "真人优惠"},
    {"id": "3", "text": "棋牌优惠"},
    {"id": "4", "text": "体育优惠"},
    {"id": "5", "text": "彩票优惠"},
    {"id": "6", "text": "电子优惠"},
  ];

  var height, width, ratio;
  var currentTabIndex = 0;
  var currentBottomIndex = 1;
  PromotionViewModel _vm = PromotionViewModel();
  var imgDomain = "https://static.sixfeliz.com/";
  BuildContext key = GlobalKey().currentContext;

  @override
  void initState() {
    super.initState();
    _vm.getPromotionList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return ProviderWidget<PromotionViewModel>(
        model: _vm,
        builder: (ctx, vm, _) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              flexibleSpace: Container(
                decoration: gradientDecoration,
              ),
              title: Text(
                getTranslatedText("promotion_center"),
                style: TextStyle(fontSize: 20.auto),
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => Home()), (Route<dynamic> route) => false);
                },
              ),
            ),
            body: ListView(
              children: [
                PromotionItem(imagePath: "images/game/livegame_ag.png"),
                PromotionItem(imagePath: "images/game/livegame_ag.png"),
                PromotionItem(imagePath: "images/game/livegame_ag.png"),
              ],
            ),
          );
        });
  }
}
