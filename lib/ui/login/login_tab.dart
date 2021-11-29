import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tgp_flutter/environment_config.dart';
import 'package:tgp_flutter/localizations/language_provider.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/login/login_content.dart';
import 'package:tgp_flutter/ui/login/phone_re_verification/phone_re_verification.dart';
import 'package:tgp_flutter/ui/login/register_content.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';

class LoginTab extends StatefulWidget {
  @override
  _LoginTabState createState() => _LoginTabState();
}

class _LoginTabState extends BaseState<LoginTab> with TickerProviderStateMixin {
  int tabIndex = 0;
  String username, password;
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: tabIndex,
      length: _isHKJP() ? 3 : 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40.auto,
          width: context.screenWidth,
          margin: EdgeInsets.symmetric(vertical: 20.auto),
          color: CustomColor.theme_button_disable_bg,
          child: TabBar(
            controller: tabController,
            onTap: (index) {
              setState(() {
                tabIndex = index;
              });
            },
            indicator: BoxDecoration(
              gradient: LinearGradient(
                colors: [CustomColor.theme_bar_gradient_2, CustomColor.theme_bar_gradient_1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            tabs: _isHKJP()
                ? [
                    // first tab [you can add an icon using the icon property]
                    _buildTab("login"),
                    _buildTab("register"),
                    _buildTab("phone_re-verify"),
                  ]
                : [
                    // first tab [you can add an icon using the icon property]
                    _buildTab("login"),
                    _buildTab("register"),
                  ],
          ),
        ),
        Container(
            height: context.screenHeight - 250.auto,
            width: context.screenWidth,
            child: TabBarView(
              controller: tabController,
              children: _isHKJP()
                  ? [
                      LoginContent(),
                      RegisterContent(
                        onSubmitUsernameAndPassword: (value) => _navigateToPhoneReVerification(value),
                      ),
                      _isHKJP()
                          ? PhoneReVerification(
                              username: username,
                              password: password,
                            )
                          : Container()
                    ]
                  : [
                      LoginContent(),
                      RegisterContent(
                        onSubmitUsernameAndPassword: (value) => _navigateToPhoneReVerification(value),
                      ),
                    ],
            ))
      ],
    );
  }

  _buildTab(String text) => Tab(
        child: AutoSizeText(
          getTranslatedText(text),
          style: TextStyle(color: Colors.white),
          maxFontSize: 14,
          minFontSize: 5,
          stepGranularity: 1,
          maxLines: 1,
        ),
      );

  _navigateToPhoneReVerification(List<String> list) {
    setState(() {
      username = list[0];
      password = list[1];
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      tabController.animateTo(2);
    });
  }

  _isHKJP() => EnvironmentConfig.appTitleName == "HKJP" || EnvironmentConfig.isShowSmsVerification;
}
