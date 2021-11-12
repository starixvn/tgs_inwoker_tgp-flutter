import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tgp_flutter/entity/language_option.dart';
import 'package:tgp_flutter/environment_config.dart';
import 'package:tgp_flutter/localizations/language_provider.dart';
import 'package:tgp_flutter/localizations/my_localizations.dart';
import 'package:tgp_flutter/main_view_model.dart';
import 'package:tgp_flutter/my_behavior.dart';
import 'package:tgp_flutter/network/event_result.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/route_path.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/blacklisted_user/blacklisted_user.dart';
import 'package:tgp_flutter/ui/card/add_card.dart';
import 'package:tgp_flutter/ui/card/main_card.dart';
import 'package:tgp_flutter/ui/customer_service/customer_service.dart';
import 'package:tgp_flutter/ui/customer_service/customer_service_qr_code.dart';
import 'package:tgp_flutter/ui/customer_service/customer_service_web_view.dart';
import 'package:tgp_flutter/ui/deposit/deposit.dart';
import 'package:tgp_flutter/ui/forgot_password/forgot_password.dart';
import 'package:tgp_flutter/ui/frequent_question/frequent_question.dart';
import 'package:tgp_flutter/ui/home/home.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/ui/language/language_view.dart';
import 'package:tgp_flutter/ui/login/login.dart';
import 'package:tgp_flutter/ui/login/phone_re_verification/phone_re_verification.dart';
import 'package:tgp_flutter/ui/maintenance/maintenance.dart';
import 'package:tgp_flutter/ui/menu/menu.dart';
import 'package:flutter/services.dart';
import 'package:tgp_flutter/ui/message/message_view.dart';
import 'package:tgp_flutter/ui/profile/animated_dot.dart';
import 'package:tgp_flutter/ui/profile/profile.dart';
import 'package:tgp_flutter/ui/profile_info/address/address.dart';
import 'package:tgp_flutter/ui/profile_info/email/edit_email.dart';
import 'package:tgp_flutter/ui/profile_info/email/email_verification.dart';
import 'package:tgp_flutter/ui/profile_info/password/edit_password.dart';
import 'package:tgp_flutter/ui/profile_info/pay_password/pay_password.dart';
import 'package:tgp_flutter/ui/profile_info/pay_password/reset_pay_password.dart';
import 'package:tgp_flutter/ui/profile_info/phone/edit_phone.dart';
import 'package:tgp_flutter/ui/profile_info/phone/phone_verification.dart';
import 'package:tgp_flutter/ui/profile_info/profile_info.dart';
import 'package:tgp_flutter/ui/profile_info/qq_account/qq_account.dart';
import 'package:tgp_flutter/ui/profile_info/real_name/real_name_verification.dart';
import 'package:tgp_flutter/ui/profile_info/security/edit_security_answer.dart';
import 'package:tgp_flutter/ui/profile_info/security/edit_security_answer_by_security_answer.dart';
import 'package:tgp_flutter/ui/profile_info/security/security_answer.dart';
import 'package:tgp_flutter/ui/profile_info/wechat/wechat.dart';
import 'package:tgp_flutter/ui/promotion/promotion_item_details.dart';
import 'package:tgp_flutter/ui/promotion/promotion_page.dart';

import 'package:tgp_flutter/ui/referFriend/refer_friend.dart';
import 'package:tgp_flutter/ui/splash/splash.dart';
import 'package:tgp_flutter/ui/transaction/transaction.dart';
import 'package:tgp_flutter/ui/withdraw/withdraw.dart';
import 'package:tgp_flutter/ui/home/child_game/child_game.dart';
import 'package:tgp_flutter/ui/transfer/wallet_transfer.dart';

Future main() async {
  //await DotEnv.load();
  // await DotEnv.load(fileName: ".env");
  // PackageInfo packageInfo = await PackageInfo.fromPlatform();
  // DotEnv.env["appName"] = packageInfo.appName;
  // // String packageName = packageInfo.packageName;
  // // String version = packageInfo.version;
  // // String buildNumber = packageInfo.buildNumber;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) async {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }
}

class _MyAppState extends BaseState<MyApp> {
  final appTitle = EnvironmentConfig.appTitleName;
  Locale _locale;
  var _vm = MainViewModel();
  var firstInit = true;

  var langList;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
  }

/*  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {*/
  _getLocale() {
    LanguageProvider().getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
  }

  /*);
    super.didChangeDependencies();
  }*/

  Future<EventResult<List<LanguageOption>>> initData() async {
    if (firstInit) {
      await _vm.getAuthToken();
      await _vm.getLanguageOption();
      _vm.getApiError();
      _vm.getBrandLogo();
      setState(() {
        firstInit = false;
      });
      _getLocale();
      langList = LanguageProvider().list.map((e) => e.locale).toList();
      return _vm.getLanguageApiState;
    } else
      return EventResult.loading();
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    _handleApiState();
    return FutureBuilder(
        future: initData(),
        builder: (BuildContext context, AsyncSnapshot<EventResult<List<LanguageOption>>> snapshot) {
          if (!snapshot.hasData) {
            return MaterialApp(debugShowCheckedModeBanner: false, home: Splash());
          }
          else if (snapshot.data.isMaintenance) {
            return MaterialApp(debugShowCheckedModeBanner: false, home: Maintenance(isShowCS: true));
          }
          else {
            return GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                  currentFocus.focusedChild.unfocus();
                }
              },
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: appTitle,
                initialRoute: '/',
                routes: {
                  RoutePath.empty: (context) => MyHomePage(),
                  RoutePath.home: (context) => MyHomePage(),
                  RoutePath.login: (context) => Login(),
                  RoutePath.menu: (context) => Menu(),
                  RoutePath.profile: (context) => Profile(),
                  RoutePath.promotion: (context) => PromotionPage(),
                  RoutePath.childGame: (context) => ChildGame(),
                  RoutePath.deposit: (context) => Deposit(),
                  RoutePath.walletTransfer: (context) => WalletTransfer(),
                  RoutePath.withdraw: (context) => Withdraw(),
                  RoutePath.transaction: (context) => Transaction(),
                  RoutePath.mainCard: (context) => MainCard(),
                  RoutePath.message: (context) => MessageView(),
                  RoutePath.frequentQuestion: (context) => FrequentQuestion(),
                  RoutePath.referFriend: (context) => ReferFriend(),
                  RoutePath.profileInfo: (context) => ProfileInfo(),
                  RoutePath.realNameVerification: (context) => RealNameVerification(),
                  RoutePath.phoneVerification: (context) => PhoneVerification(),
                  RoutePath.editPhone: (context) => EditPhone(),
                  RoutePath.emailVerification: (context) => EmailVerification(0),
                  RoutePath.qqAccount: (context) => QQAccount(),
                  RoutePath.wechat: (context) => Wechat(),
                  RoutePath.address: (context) => Address(),
                  RoutePath.editPassword: (context) => EditPassword(),
                  RoutePath.resetPayPassword: (context) => ResetPayPassword(),
                  RoutePath.payPassword: (context) => PayPassword(),
                  RoutePath.securityAnswer: (context) => SecurityAnswer(),
                  RoutePath.editSecurityAnswer: (context) => EditSecurityAnswer(),
                  RoutePath.editSecurityAnswerBySecurityAnswer: (context) => EditSecurityAnswerBySecurityAnswer(),
                  RoutePath.forgotPassword: (context) => ForgotPassword(),
                  RoutePath.language: (context) => LanguageView(),
                  RoutePath.addCard: (context) => AddCard(),
                  RoutePath.customerService: (context) => CustomerService(),
                  RoutePath.promotionItemDetails: (context) => PromotionItemDetails(),
                  RoutePath.csWebView: (context) => CustomerServiceWebView(),
                  RoutePath.csQrCode: (context) => CustomerServiceQrCode(),
                  RoutePath.maintenance: (context) => Maintenance(),
                  RoutePath.blacklistedUser: (context) => BlacklistedUser(),
                  RoutePath.phoneReVerification: (context) => PhoneReVerification(),
                  RoutePath.editEmail: (context) => EditEmail(),
                },
                localizationsDelegates: [
                  MyLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate
                ],
                // MyHomePage(title: appTitle),
                supportedLocales: langList,
                locale: _locale,
                localeResolutionCallback: (locale, supportedLocales) {
                  for (var supportedLocale in supportedLocales) {
                    if (supportedLocale.languageCode == locale.languageCode &&
                        supportedLocale.scriptCode == locale.scriptCode) {
                      return supportedLocale;
                    }
                  }
                  return supportedLocales.first;
                },
              ),
            );
          }
        });
  }

  _handleApiState() {
    handleApiState(_vm.getLanguageApiState, isAutoHideLoading: false, onSuccess: () {});
  }
}

class MyHomePage extends StatefulWidget {
  final bool isFirstRun;
  final int index;

  MyHomePage({this.isFirstRun, this.index});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends BaseState<MyHomePage> {
  int currentBottomIndex = 0;
  List _page;

  @override
  void initState() {
    if (widget.index != null) currentBottomIndex = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _page = [
      Home(
        isFirstRun: widget.isFirstRun ?? false,
      ),
      PromotionPage(),
      Menu(),
      CustomerService(),
      Profile(),
    ];
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: Scaffold(
        body: Center(
          child: _page[currentBottomIndex],
        ),
        bottomNavigationBar: Visibility(
          visible: currentBottomIndex != 2,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [CustomColor.theme_bar_gradient_1, CustomColor.theme_bar_gradient_2],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: BottomAppBar(
              color: CustomColor.theme_bar_gradient_1,
              child: Container(
                decoration: gradientDecoration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildBottomBarItem(0, "ic_home", "home"),
                    _buildBottomBarItem(1, "ic_promotion", "promotion"),
                    _buildBottomBarItem(2, "ic_menu", ""),
                    _buildBottomBarItem(3, "ic_customer_service", "customer_service"),
                    _buildBottomBarItem(4, "ic_profile", "my_profile", isNewMessage: false),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildBottomBarItem(int index, String imagePath, String title, {bool isNewMessage = false}) => Expanded(
        child: Stack(
          children: [
            _buildNotification(isNewMessage),
            SizedBox(
              height: 58.auto,
              width: context.screenWidth / 5,
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  onTap: () {
                    if (index == 1) {
                      Navigator.of(context).pushNamed("/promotion");
                    } else if (index == 3) {
                      Navigator.of(context).pushNamed(RoutePath.customerService);
                    } else {
                      setState(() {
                        currentBottomIndex = index;
                      });
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      index != 2 ? _buildImageIcon(imagePath, index, isNewMessage) : _buildMenuIcon(imagePath, index),
                      Visibility(
                        visible: index != 2,
                        child: Container(
                          margin: EdgeInsets.only(top: 3.auto),
                          child: AutoSizeText(
                            getTranslatedText(title),
                            style: TextStyle(
                              fontSize: 11.auto,
                              color: currentBottomIndex == index ? Colors.yellow : Colors.white,
                            ),
                            minFontSize: 5,
                            stepGranularity: 1,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  _buildImageIcon(String imagePath, int index, bool isNewMessage) => ImageIcon(
        AssetImage("images/bottom_navigation_bar/$imagePath.png"),
        size: 23.auto,
        color: currentBottomIndex == index ? Colors.yellow : Colors.white,
      );

  _buildMenuIcon(String imagePath, int index) => CircleAvatar(
        backgroundColor: CustomColor.theme_title_text_color,
        child: ImageIcon(
          AssetImage("images/bottom_navigation_bar/$imagePath.png"),
          size: 41.auto,
          color: currentBottomIndex == index ? Colors.yellow : Colors.white,
        ),
      );

  _buildNotification(bool isNewMessage) => Visibility(
      visible: isNewMessage,
      child: Positioned(
          top: context.screenWidth / 100,
          right: context.screenWidth / 30,
          child: AnimatedDot(
            color: CustomColor.theme_label_text_highlight_color,
          )));
}
