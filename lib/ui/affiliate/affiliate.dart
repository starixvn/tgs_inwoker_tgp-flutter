import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tgp_flutter/custom/color_button.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/environment_config.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/my_behavior.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/affiliate/affiliate_view_model.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/message/message_view.dart';
import 'package:tgp_flutter/ui/profile/profile_bottom_item.dart';
import 'package:tgp_flutter/ui/profile_info/profile_info.dart';

class Affiliate extends StatefulWidget {
  @override
  _AffiliateState createState() => _AffiliateState();
}

class _AffiliateState extends BaseState<Affiliate> {
  var isEditing = false, isSelected = false;
  AffiliateViewModel _vm = AffiliateViewModel();
  String? affiliateUrl;

  @override
  void initState() {
    if (_vm.userProfile.playerCode != null)
      affiliateUrl = EnvironmentConfig.url + "a/${_vm.userProfile.playerCode}?do=register";
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
            Text(
              getTranslatedText("affiliate_qr_code"),
              style: TextStyle(fontSize: 16.auto),
              textAlign: TextAlign.center,
            ),
            Container(
              margin: EdgeInsets.only(top: 20.auto),
              height: 120.auto,
              width: 120.auto,
              child: QrImage(
                data: affiliateUrl!,
                version: QrVersions.auto,
                size: 150.0,
              ),
            ),
            _buildReferIdText(),
            _buildIdLink(),
            //_buildProfileItem()
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
          getTranslatedText("affiliate"),
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
                getTranslatedText("my_refer_id"),
                style: TextStyle(color: CustomColor.theme_button_disable_bg, fontSize: 16.auto),
              ),
            ),
            Text(
              _vm.userProfile.playerCode ?? "",
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
            Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.only(right: 3.auto),
                child: Text(
                  getTranslatedText("affiliate_link"),
                  style: TextStyle(color: CustomColor.theme_button_disable_bg, fontSize: 16.auto),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                child: AutoSizeText(
                  affiliateUrl ?? "",
                  style: TextStyle(
                    color: CustomColor.theme_bar_gradient_2,
                  ),
                  maxFontSize: 11,
                  maxLines: 2,
                  stepGranularity: 1,
                  minFontSize: 5,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: InkWell(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: affiliateUrl ?? ""));
                  CustomToast.show(getTranslatedText("copy_text"));
                },
                child: Container(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.only(left: 3.auto),
                  height: 25.auto,
                  child: ColorButton(
                    text: Text(
                      getTranslatedText("copy"),
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
                ),
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
