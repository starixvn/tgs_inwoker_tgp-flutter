import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tgp_flutter/entity/language.dart';
import 'package:tgp_flutter/localizations/language_provider.dart';
import 'package:tgp_flutter/localizations/my_localizations.dart';
import 'package:tgp_flutter/my_behavior.dart';
import 'package:tgp_flutter/route/route_path.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/card/add_card.dart';
import 'package:tgp_flutter/ui/card/main_card.dart';
import 'package:tgp_flutter/ui/deposit/deposit.dart';
import 'package:tgp_flutter/ui/forgot_password/forgot_password.dart';
import 'package:tgp_flutter/ui/frequent_question/frequent_question.dart';
import 'package:tgp_flutter/ui/home/child_game/child_game.dart';
import 'package:tgp_flutter/ui/home/home.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/ui/home/home_view_model.dart';
import 'package:tgp_flutter/ui/language/language_view.dart';
import 'package:tgp_flutter/ui/login/login.dart';
import 'package:tgp_flutter/ui/login/login_content.dart';
import 'package:tgp_flutter/ui/login/login_view_model.dart';
import 'package:tgp_flutter/ui/menu/menu.dart';
import 'package:flutter/services.dart';
import 'package:tgp_flutter/ui/message/message_view.dart';
import 'package:tgp_flutter/ui/profile/profile.dart';
import 'package:tgp_flutter/ui/profile_info/address/address.dart';
import 'package:tgp_flutter/ui/profile_info/email/email_verification.dart';
import 'package:tgp_flutter/ui/profile_info/email/email_verification.dart';
import 'package:tgp_flutter/ui/profile_info/password/edit_password.dart';
import 'package:tgp_flutter/ui/profile_info/pay_password/pay_password.dart';
import 'package:tgp_flutter/ui/profile_info/pay_password/reset_pay_password.dart';
import 'package:tgp_flutter/ui/profile_info/phone/phone_verification.dart';
import 'package:tgp_flutter/ui/profile_info/phone/phone_verification.dart';
import 'package:tgp_flutter/ui/profile_info/profile_info.dart';
import 'package:tgp_flutter/ui/profile_info/qq_account/qq_account.dart';
import 'package:tgp_flutter/ui/profile_info/real_name/real_name_verification.dart';
import 'package:tgp_flutter/ui/profile_info/security/edit_security_answer.dart';
import 'package:tgp_flutter/ui/profile_info/security/edit_security_answer_by_security_answer.dart';
import 'package:tgp_flutter/ui/profile_info/security/security_answer.dart';
import 'package:tgp_flutter/ui/profile_info/wechat/wechat.dart';
import 'package:tgp_flutter/ui/promotion/promotion_page.dart';
import 'package:tgp_flutter/ui/referFriend/refer_friend.dart';
import 'package:tgp_flutter/ui/splash/splash.dart';
import 'package:tgp_flutter/ui/splash/splash_view_model.dart';
import 'package:tgp_flutter/ui/transaction/transaction.dart';
import 'package:tgp_flutter/ui/transfer/wallet_transfer.dart';
import 'package:tgp_flutter/ui/withdraw/withdraw.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) async {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }

}

class _MyAppState extends BaseState<MyApp> {
  final appTitle = 'Drawer Demo';
  Locale _locale;
  var langList = LanguageProvider().list.map((e) => e.locale).toList();

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      LanguageProvider().getLocale().then((locale) {
        setState(() {
          this._locale = locale;
        });
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
        )
    );
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild.unfocus();
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appTitle,
        initialRoute: '/',
        routes: {
          RoutePath.empty: (context) => Splash(),
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
          RoutePath.emailVerification: (context) => EmailVerification(),
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
          RoutePath.language:(context) => LanguageView(),
          RoutePath.addCard:(context) => AddCard(),
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
}
class MyHomePage  extends StatefulWidget{
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends BaseState<MyHomePage> {
  int currentBottomIndex = 0;
  static List<Widget> _page = <Widget>[
    Home(),
    PromotionPage(),
    Menu(),
    Login(),
    Profile(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  ScrollConfiguration(
      behavior: MyBehavior(),
      child: Scaffold(
        body:Center(
          child: _page[currentBottomIndex],
        ),
        bottomNavigationBar:
        Visibility(
          visible: currentBottomIndex!=2,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  CustomColor.theme_bar_gradient_1,
                  CustomColor.theme_bar_gradient_2
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: BottomAppBar(
              color: CustomColor.theme_bar_gradient_1,
              child: Container(
                decoration: gradientDecoration,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildBottomBarItem(0,"ic_home",  "home"),
                    _buildBottomBarItem(1,"ic_promotion", "promotion"),
                    _buildBottomBarItem(2,"ic_menu", ""),
                    _buildBottomBarItem(3,"ic_customer_service","customer_service"),
                    _buildBottomBarItem(4,"ic_profile",  "my_profile"),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildBottomBarItem(int index, String imagePath, String title) => Expanded(
    child:SizedBox(
      height: 58.auto,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {
            setState(() {
              currentBottomIndex = index;
            });
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              index!=2
                  ? ImageIcon(
                AssetImage("images/bottom_navigation_bar/$imagePath.png"),
                size: 23.auto,
                color: currentBottomIndex==index?Colors.yellow:Colors.white,)
                  :CircleAvatar(
                backgroundColor: CustomColor.theme_circle_button_bg,
                child: ImageIcon(
                  AssetImage("images/bottom_navigation_bar/$imagePath.png"),
                  size: 41.auto,
                  color: currentBottomIndex==index?Colors.yellow:Colors.white,
                ),
              ),
              index==2
                  ?Container()
                  :Container(
                margin: EdgeInsets.only(top: 3.auto),
                child: Text(
                  getTranslatedText(title),
                  style: TextStyle(
                    fontSize: 11.auto,
                    color: currentBottomIndex==index?Colors.yellow:Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),

      ),
    ),
  );
}
