import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_api/extension/format.dart';
import 'package:tgp_flutter/custom/color_button.dart';
import 'package:shared_api/entity/user_profile.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:shared_api/extension/screen_apis.dart';
import 'package:tgp_flutter/ui/base_state.dart';

class HomeUserInfoView extends StatefulWidget {
  final UserProfile userProfile;
  final double wallet;
  final void Function() onLoginTap;

  HomeUserInfoView({@required this.userProfile, this.wallet, this.onLoginTap});

  @override
  _HomeUserInfoViewState createState() => _HomeUserInfoViewState();
}

class _HomeUserInfoViewState extends BaseState<HomeUserInfoView> {
  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      elevation: 5,
      margin: EdgeInsets.all(10.auto),
      child: Container(
        decoration: gradientDecoration,
        child: Column(
          children: [
            _buildTopRowContainer(),
            _buildBottomRowContainer(),
          ],
        ),
      ),
    );
  }

  _buildTopRowContainer() => Container(
        width: context.screenWidth,
        padding: EdgeInsets.only(top: 5.auto, left: 10.auto, right: 10.auto, bottom: 5.auto),
        child: Row(
          children: [
            _buildWelcomeText(),
            Visibility(
                visible: widget.userProfile != null,
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      widget.userProfile?.username ?? "",
                      style: TextStyle(color: CustomColor.theme_label_text_highlight_color, fontSize: 10.auto),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )),
            Spacer(),
            _buildProfileInfoText()
          ],
        ),
      );

  _buildBottomRowContainer() => Container(
        padding: EdgeInsets.only(top: 5.auto, bottom: 5.auto, left: 10.auto, right: 10.auto),
        color: CustomColor.theme_bar_gradient_1.withOpacity(0.4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.userProfile != null ? _buildWalletText() : _buildLoginRegisterButton(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildHomeIcon("ic_deposit", getTranslatedText("deposit"), "deposit"),
                _buildHomeIcon("ic_transfer", getTranslatedText("transfer"), "wallet_transfer"),
                _buildHomeIcon("ic_withdraw", getTranslatedText("withdrawal"), "withdraw")
              ],
            ),
          ],
        ),
      );

  _buildWelcomeText() => Text(
        (widget.userProfile != null ? getTranslatedText("welcome_back") : getTranslatedText("home_login_hint")) ?? "",
        style: TextStyle(color: Colors.white, fontSize: 10.auto),
      );

  _buildProfileInfoText() => Text(
        getTranslatedText("profile_detail"),
        style: TextStyle(color: Colors.white, fontSize: 10.auto),
        textAlign: TextAlign.right,
      );

  _buildWalletText() => Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            child: Column(
        children: [
            AutoSizeText(
            widget.wallet ==null?"-":"${Format().currencyWithDecimalFormat(widget.wallet) ?? 0.0}",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              minFontSize: 10,
              stepGranularity: 1,
            ),
            Text(
              getTranslatedText("main_wallet"),
              style: TextStyle(color: Colors.white, fontSize: 10.auto),
              textAlign: TextAlign.center,
            ),
        ],
      ),
          ));

  _buildLoginRegisterButton() {
    var string = getTranslatedText("login_or_signup").split("/");
    var loginString = string[0];
    var registerString = "/" + string[1];
    return Container(
      padding: EdgeInsets.only(top: 10.auto, bottom: 10.auto),
      child: ColorButton(
        onClick: () => widget.onLoginTap(),
        height: 20.auto,
        text: RichText(
          text: TextSpan(style: TextStyle(fontSize: 12.auto, fontWeight: FontWeight.bold), children: [
            TextSpan(
                text: loginString,
                style: TextStyle(color: CustomColor.theme_label_text_highlight_color, fontSize: (11.8).auto)),
            TextSpan(text: registerString, style: TextStyle(color: Colors.white, fontSize: (11.8).auto))
          ]),
        ),
        border: BorderSide(color: Colors.white, width: 1.5),
        radius: 15.7,
        width: 82.auto,
        color: CustomColor.theme_circle_button_bg,
        isEnabled: true,
      ),
    );
  }

  _buildHomeIcon(String imagePath, String title, String routePath) => InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          if (widget.userProfile == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushNamed("/login");
            });
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushNamed("/$routePath");
            });
          }
        },
        child: Container(
          margin: EdgeInsets.only(left: 20.auto),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: CustomColor.theme_title_text_color,
                child: Center(child: Image.asset("images/home/$imagePath.png")),
              ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: (13.5).auto,
                  shadows: [
                    Shadow(
                      blurRadius: 1.5,
                      color: Colors.black,
                      offset: Offset(0, 2.0),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
