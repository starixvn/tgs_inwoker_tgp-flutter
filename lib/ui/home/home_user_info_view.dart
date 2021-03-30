import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/color_button.dart';
import 'package:tgp_flutter/entity/user_profile.dart';
import 'package:tgp_flutter/localizations/language_provider.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/ui/base_state.dart';

class HomeUserInfoView extends StatefulWidget {
  final UserProfile userProfile;
  final String imagePath;
  final void Function() onLoginTap;

  HomeUserInfoView({
    @required
    this.userProfile,
    this.imagePath,
    this.onLoginTap
  });

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
            Container(
              width: context.screenWidth,
              padding: EdgeInsets.only(top: 5.auto, left: 10.auto, right: 10.auto, bottom: 5.auto),
              child: Row(
                children: [
                  Text(
                    (widget.userProfile != null
                        ?getTranslatedText("welcome_back")
                        :getTranslatedText("home_login_hint"))??"",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.auto
                    ),
                  ),
                  widget.userProfile != null ? Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        widget.userProfile.username,
                        style: TextStyle(
                            color: CustomColor.theme_label_text_highlight_color,
                            fontSize: 10.auto
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        margin: EdgeInsets.only(left:5.auto),
                        child: Image.asset(
                          widget.imagePath,
                          width: 20.auto,
                          height: 20.auto,
                        ),
                      )
                    ],
                  ) : Wrap(),
                  Spacer(),
                  Text(
                    getTranslatedText("profile_detail"),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.auto
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5.auto, bottom:5.auto, left: 10.auto, right: 10.auto),
              color: CustomColor.theme_color_1_40.withOpacity(0.4),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                  widget.userProfile != null ? Expanded(
                      child:  Column(
                        children: [
                          Text(
                            //"¥ ${widget.userProfile?.balance}",
                            "¥ 0.00",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.auto,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                          Text(
                            getTranslatedText("main_wallet"),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.auto
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                  ):
                  _buildLoginRegisterButton(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildHomeIcon("ic_deposit", getTranslatedText("deposit") ),
                      _buildHomeIcon("ic_transfer", getTranslatedText("transfer")),
                      _buildHomeIcon("ic_withdraw", getTranslatedText("withdrawal"))
                    ],
                  ),
                ],
              ),

            ),
          ],
        ),
      ),
    );
  }

  _buildLoginRegisterButton(){
    var string = getTranslatedText("login_or_signup").split("/");
    var loginString = string[0];
    var registerString = "/"+string[1];
    return Container(
      padding: EdgeInsets.only(top:10.auto, bottom: 10.auto),
      child: ColorButton(
        onClick: () => widget.onLoginTap(),
        text: RichText(
          text: TextSpan(
              style: TextStyle(
                  fontSize: 12.auto,
                  fontWeight: FontWeight.bold
              ),
              children: [
                TextSpan(
                    text: loginString,
                    style: TextStyle(
                        color: CustomColor.theme_label_text_highlight_color,
                        fontSize: (11.8).auto
                    )
                ),
                TextSpan(
                    text: registerString,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: (11.8).auto
                    )
                )
              ]
          ),
        ),
        border:BorderSide(
            color: Colors.white,
            width: 1.5
        ),
        radius: 15.7,
        width: 82.auto,
        color: CustomColor.theme_circle_button_bg,
        isEnabled: true,
      ),
    );
  }

  _buildHomeIcon(String imagePath, String title) =>
      Container(
        margin: EdgeInsets.only(left: 20.auto),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: CustomColor.theme_circle_button_bg,
              child: Center(
                  child: Image.asset("images/home/$imagePath.png")
              ),
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: (13.5).auto,
                shadows: [
                  Shadow(
                    blurRadius:1.5,
                    color: Colors.black,
                    offset: Offset(0, 2.0),
                  ),
                ],
              ),

            )
          ],
        ),
      );

/* _navigateToDeposit() => Navigator.of(context).pushNamed("/login");
  _navigateToTransfer() => Navigator.of(context).pushNamed("/login");
  _navigateToWithdraw() => Navigator.of(context).pushNamed("/login");*/
}