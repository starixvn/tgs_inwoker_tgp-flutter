import 'package:flutter/material.dart';
import 'package:tgp_flutter/my_behavior.dart';
import 'package:tgp_flutter/route/route_path.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/home/home.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/ui/login/login.dart';
import 'package:tgp_flutter/ui/menu/menu.dart';
import 'package:flutter/services.dart';
import 'package:tgp_flutter/ui/splash/splash.dart';
import 'package:tgp_flutter/ui/splash/splash_view_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  final appTitle = 'Drawer Demo';

  @override
  Widget build(BuildContext context) {
    /*SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent
    ));*/
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          currentFocus.focusedChild.unfocus();
        }
      },
      child:MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appTitle,
        initialRoute: '/',
        routes: {
          RoutePath.empty: (context) => Splash(),
          RoutePath.home: (context) => MyHomePage(),
          RoutePath.login: (context) => Login(),
          RoutePath.menu: (context) => Menu(),

        },
        theme: ThemeData(
          primaryColor: CustomColor.theme_bar_gradient_1,
          highlightColor: CustomColor.theme_bar_gradient_2,
        ),//MyHomePage(title: appTitle),
      ),
    );
  }
}

class MyHomePage  extends StatefulWidget{
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentBottomIndex = 0;
  static List<Widget> _page = <Widget>[
    Home(),
    Home(),
    Menu(),
    Login(),
    Login(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: Scaffold(
        body:Center(
          child: _page[currentBottomIndex],
        ),
        bottomNavigationBar:
        Visibility(
          visible: currentBottomIndex!=2,
          child: Container(
            decoration: gradientDecoration,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              unselectedItemColor: Colors.white,
              selectedItemColor: Colors.yellow,
              currentIndex: currentBottomIndex,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              onTap: (int index){
                setState(() {
                  currentBottomIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon:ImageIcon(
                    AssetImage("images/bottom_navigation_bar/ic_home.png"),
                    size: 23.auto,
                  ),
                  title: Text("首页",
                    style: TextStyle(
                      fontSize: 11.auto,
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage("images/bottom_navigation_bar/ic_promotion.png"),
                    size: 23.auto,
                  ),
                  title: Text("优惠",
                    style: TextStyle(
                      fontSize: 11.auto,
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  icon:CircleAvatar(
                    foregroundColor: Colors.white,
                    backgroundColor: CustomColor.theme_circle_button_bg,
                    child: ImageIcon(
                      AssetImage("images/bottom_navigation_bar/ic_menu.png"),
                      size: 25.auto,
                    ),
                  ),
                  title: Text("",
                  ),
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage("images/bottom_navigation_bar/ic_customer_service.png"),
                    size: 23.auto,
                  ),
                  title: Text("客服",
                    style: TextStyle(
                      fontSize: 11.auto,
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage("images/bottom_navigation_bar/ic_profile.png"),
                    size: 23.auto,
                  ),
                  title: Text("我的",
                    style: TextStyle(
                      fontSize: 11.auto,
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
}
