import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/color_button.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/my_behavior.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/message/message_view.dart';
import 'package:tgp_flutter/ui/profile/profile_bottom_item.dart';
import 'package:tgp_flutter/ui/profile_info/profile_info.dart';

class ReferFriend extends StatefulWidget {
  @override
  _ReferFriendState createState() => _ReferFriendState();
}

class _ReferFriendState extends BaseState<ReferFriend> {
  var isEditing = false, isSelected = false;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[100],
      appBar: _buildAppBar(),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 50.auto),
              height: 120.auto,
              width: 120.auto,
              color: CustomColor.theme_bar_gradient_1,
            ),
            _buildReferIdText(),
            _buildIdLink(),
            _buildProfileItem()
          ],
        ),
      ),
    );
  }

  _buildAppBar() => AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: gradientDecoration,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "推荐朋友",
          style: TextStyle(fontSize: 16.auto),
        ),
      );

  _buildReferIdText() => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(width: 1, color: CustomColor.theme_button_disable_bg)),
        padding: EdgeInsets.only(
          left: 10.auto,
          right: 5.auto,
          top: 10.auto,
          bottom: 10.auto,
        ),
        margin: EdgeInsets.only(top: 20.auto),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 10.auto),
              child: Text(
                "My Refer ID",
                style: TextStyle(color: CustomColor.theme_button_disable_bg, fontSize: 16.auto),
              ),
            ),
            Text(
              "m1189",
              style: TextStyle(color: CustomColor.theme_bar_gradient_2, fontSize: 16.auto),
            )
          ],
        ),
      );

  _buildIdLink() => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(width: 1, color: CustomColor.theme_button_disable_bg)),
        padding: EdgeInsets.only(
          left: 10.auto,
          right: 5.auto,
          top: 10.auto,
          bottom: 10.auto,
        ),
        margin: EdgeInsets.only(top: 20.auto),
        child: Row(
          children: [
            Container(
                margin: EdgeInsets.only(right: 10.auto),
                width: 20.auto,
                height: 20.auto,
                child: Image.asset("images/referFriend/ic_link.png")),
            Text(
              "yg.ck881.com/en-US/a/m1189",
              style: TextStyle(color: CustomColor.theme_bar_gradient_2, fontSize: 14.auto),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.zero,
              height: 25.auto,
              child: ColorButton(
                text: Text(
                  "COPY",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 14.auto),
                ),
                onClick: () => {},
                isEnabled: true,
                color: CustomColor.theme_bar_gradient_2,
                radius: 20,
                width: 50.auto,
                padding: MaterialStateProperty.all(EdgeInsets.zero),
              ),
            )
          ],
        ),
      );

  _buildProfileItem() => Expanded(
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: ListView(
            padding: EdgeInsets.only(left: 10.auto, right: 10.auto, bottom: 20.auto, top: 20.auto),
            shrinkWrap: true,
            primary: false,
            physics: AlwaysScrollableScrollPhysics(),
            children: [
              GridView.count(
                padding: EdgeInsets.only(bottom: 10.auto),
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisSpacing: 25.auto,
                mainAxisSpacing: 20.auto,
                children: [
                  ProfileBottomItem(
                    title: getTranslatedText("profile_detail"),
                    imagePath: "ic_profile_user_detail",
                    routePath: "profile_info",
                    navigationID: 0,
                    isMessage: false,
                  ),
                  ProfileBottomItem(
                    title: getTranslatedText("message_center"),
                    imagePath: "ic_message",
                    routePath: "profile_info",
                    navigationID: 0,
                    isMessage: false,
                  ),
                  ProfileBottomItem(
                    title: getTranslatedText("transfer_history"),
                    imagePath: "ic_account_detail",
                    routePath: "profile_info",
                    navigationID: 0,
                    isMessage: false,
                  ),
                ],
              ),
              _buildButton()
            ],
          ),
        ),
      );

  _buildButton() => Container(
      padding: EdgeInsets.only(bottom: 10.auto, top: 20.auto),
      child: ColorButton(
        text: Text(
          getTranslatedText("download_qr"),
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 16.auto),
        ),
        onClick: () {},
        isEnabled: true,
        color: CustomColor.theme_bar_gradient_2,
        radius: 9.4,
      ));
}
