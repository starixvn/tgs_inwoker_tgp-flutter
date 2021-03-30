import 'package:flutter/material.dart';
import 'package:tgp_flutter/localizations/language_provider.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/login/login_content.dart';
import 'package:tgp_flutter/ui/login/register_content.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';

class LoginTab extends StatefulWidget{
  @override
  _LoginTabState createState() => _LoginTabState();
}

class _LoginTabState extends BaseState<LoginTab>{
  int tabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            height: 40.auto,
            width: context.screenWidth,
            margin: EdgeInsets.symmetric(vertical: 20.auto),
            color: CustomColor.theme_button_disable_bg,
            child: TabBar(
              onTap: (index){
                setState(() {
                  tabIndex = index;
                });
              },
              indicator: BoxDecoration(
                gradient: LinearGradient(colors: [
                  CustomColor.theme_bar_gradient_2,
                  CustomColor.theme_bar_gradient_1
                ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              tabs: [
                // first tab [you can add an icon using the icon property]
                Tab(
                  child: Text(
                    getTranslatedText("login"),
                    style: TextStyle(
                      fontSize: 14.auto,
                      color: Colors.white
                    ),
                  ),
                ),
                // second tab [you can add an icon using the icon property]
                Tab(
                  child: Text(
                    getTranslatedText("register"),
                    style: TextStyle(
                        fontSize: 14.auto,
                      color: Colors.white
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: tabIndex == 0 ? LoginContent() : RegisterContent(),
          )
        ],
      ),
    );
  }
}