import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/custom_dialog.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/entity/user_profile.dart';
import 'package:tgp_flutter/localizations/language_provider.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/home/home_user_info_view.dart';
import 'package:tgp_flutter/ui/home/home_view_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:marquee/marquee.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';

import 'game/game_view.dart';


class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends BaseState<Home> {
  List<String> imgList = [
    'images/banner_1.jpg',
    //'images/banner_2.jpg'
  ];
  String marquee = "《GD真人维护公告》GD真人将于 7 月 2 8 日 09:00 至 14:00 进行维护 维护期间不提供游戏相关服务。若有问题欢迎与在线客服联系 如有问题欢迎与在线客服联系，谢谢";
  ScrollController controller = ScrollController();
  var currentTabIndex = "0";
  var tabList;
  UserProfile user;

  //livegame =4, qipai =5, slotgame =4, sport =2, lottery =1
  var gameList = [
    ['livegame_ag.png',
      'livegame_bbin.png',
      'livegame_dg.png',
      'livegame_mg.png'],
    ['qipai_ky.png',
      'qipai_ap.png',
      'qipai_as.png',
      'qipai_bole.png',
      'qipai_leyou.png'],
    ['sport_stt.png',
      'sport_sabah.png'],
    ['lottery_633.png'],
    ['slotgame_mg.png',
      'slotgame_jdb.png',
      'slotgame_ag.png',
      'slotgame_bbin.png'],
    ['sport_stt.png',
      'sport_sabah.png'],
    ['lottery_633.png'],
  ];
  var tab = [
    {
      "id":"0",
      "text":"cat_sport"
    },
    {
      "id":"1",
      "text":"cat_slotgame"
    },
    {
      "id":"2",
      "text":"cat_table"
    },
    /*{
      "id":"0",
      "text":"cat_livecasino"
    },
    {
      "id":"1",
      "text":"cat_qipai"
    },
    {
      "id":"3",
      "text":"cat_lottery"
    },    {
      "id":"5",
      "text":"cat_laohu"
    },
    {
      "id":"6",
      "text":"cat_fish"
    },*/
  ];

  var itemHeightRatio = 335/90;
  var _vm = HomeViewModel();


  @override
  void initState() {
    //WidgetsBinding.instance.addPostFrameCallback((_) {
      _vm.resumeIfNeed();
    //});
    super.initState();
  }

  Widget build(BuildContext context) {
    return ProviderWidget<HomeViewModel>(
        model: _vm,
        builder: (ctx, vm, _) {
          _handleApiState();
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: _vm.userProfile == null ? Center(child: CircularProgressIndicator()) :
            Column(
              children: [
                Stack(
                    children: [
                      Container(
                        height: context.screenHeight / 3.5,
                        child: _buildImageSlider(),
                      ),
                      Positioned(
                        top: context.screenHeight / 3.7,
                        child: Container(
                          width: context.screenWidth,
                          height: context.screenHeight,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              )
                          ),
                        ),
                      ),
                    ]
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10.auto),
                      child: Text(
                        LanguageProvider().getTranslated(context, "notice"),
                        style: TextStyle(
                            fontSize: (13.5).auto,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    _buildTextMarquee()
                  ],
                ),
                HomeUserInfoView(
                    userProfile: _vm.userProfile,
                    onLoginTap: () {
                      navigateToLogin();
                    }
                ),
                GameView(
                  tabList: tab,
                )
              ],
            ),
          );
        }
    );
  }

  _buildImageSlider() => Swiper(
    itemBuilder: (BuildContext context, int index){
      return AspectRatio(
        aspectRatio: 360/200,
        child: Image.asset(
          imgList[index],
          fit: BoxFit.fill,
        ),
      );
    },
    autoplay: true,
    itemCount: imgList.length,
    pagination: new SwiperPagination(
        alignment: Alignment.bottomCenter,
        margin: new EdgeInsets.all(context.screenHeight/30),
        builder: new DotSwiperPaginationBuilder(
            color: Colors.grey,
            activeColor: Colors.red)
    ),
  );

  _buildTextMarquee() => Expanded(
    child: Container(
      decoration: BoxDecoration(
          color: CustomColor.theme_bar_gradient_1,
          borderRadius: BorderRadius.circular(10.0)
      ),
      margin: EdgeInsets.only(left: 10.auto, right:10.auto),
      height: 18.auto,
      child:Marquee(
        text: marquee,
        style: TextStyle(
          color: Colors.white,
          fontSize: 10.auto,
        ),
        scrollAxis: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        blankSpace: 5.auto,
        pauseAfterRound: Duration(seconds: 1),
      ),
    ),
  );

  navigateToLogin(){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushNamed("/login");
    });
  }

  _displayDialog() async {
    if (_vm.userProfile == null) {
      showDialog(context: context,
        builder: (BuildContext context) => CustomDialog(
          title: "登录已超时",
          description: "请再登录",
          buttonText1: "登录",
          buttonText2: "不了",
          onClick: this.navigateToLogin,
        ),
      );
    }
  }

  _handleApiState(){
    if(_vm.isNotLogin) {
      navigateToLogin();
      _vm.markIsNotLogin();
    }
    else if(_vm.isExpired) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _displayDialog();
      });
    }
  }
}