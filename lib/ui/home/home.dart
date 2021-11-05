 import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tgp_flutter/custom/custom_dialog.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/entity/game_provider2.dart';
import 'package:tgp_flutter/entity/language.dart';
import 'package:tgp_flutter/entity/user_profile.dart';
import 'package:tgp_flutter/environment_config.dart';
import 'package:tgp_flutter/localizations/language_provider.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/route_path.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/home/game/game_view_model.dart';
import 'package:tgp_flutter/ui/home/home_user_info_view.dart';
import 'package:tgp_flutter/ui/home/home_view_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:marquee/marquee.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/ui/login/login.dart';

import 'game/game_view.dart';

class Home extends StatefulWidget {
  final bool isFirstRun;

  Home({this.isFirstRun});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends BaseState<Home> {
  List<String> imgList = [
    '1',
    '2',
    //'images/banner_2.jpg'
  ];

  // String marquee = "《GD真人维护公告》GD真人将于 7 月 2 8 日 09:00 至 14:00 进行维护 维护期间不提供游戏相关服务。若有问题欢迎与在线客服联系 如有问题欢迎与在线客服联系，谢谢";
  ScrollController controller = ScrollController();
  var currentTabIndex = "0";
  UserProfile user;

  var itemHeightRatio = 335 / 90;
  var _vm = HomeViewModel();
  var _gameViewModel = GameViewModel();

  @override
  void initState() {
    _initData();
    super.initState();
  }

  _initData() {
    _vm.getAnnouncement();
    _vm.getBanner();
    _vm.resumeIfNeed();
    _gameViewModel.getGameProviderList(isRefresh: true);
  }

  Widget build(BuildContext context) {
    return ProviderWidget<HomeViewModel>(
        model: _vm,
        builder: (ctx, vm, _) {
          _handleApiState();
          return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              body: _vm.bannerList == null ? buildProgressDialog(_vm.brandLogoUrl) : _buildWidget());
        });
  }

  _buildWidget() => Column(
        children: [
          Stack(children: [_buildImageSlider(), _buildBorderCorner()]),
          _buildMarqueeRow(),
          HomeUserInfoView(
            userProfile: _vm.userProfile,
            wallet: _vm.totalBalance,
            onLoginTap: () => navigateToLogin(),
            onRefreshHomePage: () => _initData(),
          ),
          GameView(
            vm: _gameViewModel,
            onRefreshHomePage: () => _initData(),
          )
        ],
      );

  _buildImageSlider() => Container(
        height: context.screenHeight / 5,
        child: _vm.bannerList == null || _vm.bannerList.isEmpty
            ? _buildEmptyContainer()
            : ImageSlideshow(
                initialPage: 0,
                indicatorColor: CustomColor.theme_bar_gradient_2,
                indicatorBackgroundColor: Colors.grey,
                children: List.generate(
                    _vm.bannerList?.length,
                    (index) => CachedNetworkImage(
                          placeholder: (context, url) => _buildEmptyContainer(),
                          imageUrl: _vm.bannerList[index].mobileUrl ?? "",
                          //handling error
                          fit: BoxFit.fill,
                          errorWidget: (context, url, error) => _buildEmptyContainer(),
                        )),
                isLoop: true,
                autoPlayInterval: 3000),
      );

  _buildEmptyContainer() => Container(
        color: CustomColor.very_light_pink_four,
      );

  _buildBorderCorner() => Positioned(
        top: context.screenHeight / 5.2,
        child: Container(
          width: context.screenWidth,
          height: context.screenHeight,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              )),
        ),
      );

  _buildMarqueeRow() => Row(
        children: [
          Container(
            width: context.screenWidth / 7,
            padding: EdgeInsets.only(left: 10.auto),
            child: AutoSizeText(
              getTranslatedText("notice"),
              style: TextStyle(fontWeight: FontWeight.w600),
              maxFontSize: 13,
              minFontSize: 5,
              maxLines: 1,
              stepGranularity: 1,
            ),
          ),
          _buildTextMarquee()
        ],
      );

  _buildTextMarquee() {
    var announcement = _removeMultiLine(parseHtmlString(_vm.announcement));
    return Expanded(
      child: Container(
        decoration: BoxDecoration(color: CustomColor.theme_bar_gradient_1, borderRadius: BorderRadius.circular(10.0)),
        margin: EdgeInsets.only(left: 10.auto, right: 10.auto),
        height: 18.auto,
        child: announcement.isEmpty
            ? Container()
            : Marquee(
                text: announcement,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.auto,
                ),
                scrollAxis: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.center,
                blankSpace: 5.auto,
                pauseAfterRound: Duration(seconds: 1),
                showFadingOnlyWhenScrolling: false),
      ),
    );
  }

  _removeMultiLine(String text) {
    return text.replaceAll("\n", " ");
  }

  navigateToLogin() async {
    var result = await Navigator.of(context).pushNamed(RoutePath.login);
    if (result) _initData();
  }

  _displayDialog() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var loginLater = prefs.getBool("login_later") ?? false;
    if (_vm.userProfile == null && !loginLater) {
      showDialog(
        context: context,
        builder: (BuildContext context) => CustomDialog(
          title: getTranslatedText("login_expired"),
          description: getTranslatedText("login_again"),
          buttonText1: getTranslatedText("login"),
          buttonText2: getTranslatedText("no"),
          onClick: this.navigateToLogin,
          onClick2: () {
            prefs.setBool("login_later", true);
            Navigator.pop(context);
          },
        ),
      );
    }
  }

  _handleApiState() {
    if (widget.isFirstRun != null && widget.isFirstRun) {
      if (_vm.isNotLogin) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          navigateToLogin();
        });
        _vm.markIsNotLogin();
      } else if (_vm.isExpired) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _displayDialog();
        });
      }
    }
    handleApiState(_vm.getBasicInfoApiState, isAutoHideLoading: false, onSuccess: () {});
    handleApiState(_vm.getAnnouncementApiState, isAutoHideLoading: false, onSuccess: () {});
    handleApiState(_vm.getBannerApiState, isAutoHideLoading: false, onSuccess: () {});
  }

  _handleGameApiState() {
    handleApiState(_gameViewModel.getGameProviderListApiState, isAutoHideLoading: false, onSuccess: () {});
    handleApiState(_gameViewModel.getGameApiState, onSuccess: () {});
  }
}
