import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tgp_flutter/localizations/language_provider.dart';
import 'package:tgp_flutter/localizations/my_localizations.dart';
import 'package:tgp_flutter/my_behavior.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/home/home.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/ui/login/login.dart';
import 'package:tgp_flutter/ui/menu/menu.dart';
import 'package:flutter/services.dart';
import 'package:tgp_flutter/ui/profile/profile.dart';
import 'package:tgp_flutter/ui/promotion/promotion_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:tgp_flutter/ui/splash/splash.dart';

Future main() async {
  //await DotEnv.load();
  await DotEnv.load(fileName: ".env");
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
        home:Splash(),
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
  final bool isFirstRun;

  MyHomePage({
    this.isFirstRun
  });

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends BaseState<MyHomePage> {
  int currentBottomIndex = 0;

  List _page;
  @override
  void initState() {
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
      Login(),
      Profile(),
    ];
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
