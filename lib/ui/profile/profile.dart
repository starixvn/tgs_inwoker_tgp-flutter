import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/color_button.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/entity/user_profile.dart';
import 'package:tgp_flutter/extension/format.dart';
import 'package:tgp_flutter/localizations/language_provider.dart';
import 'package:tgp_flutter/my_behavior.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/profile/profile_bottom_item.dart';
import 'package:tgp_flutter/ui/profile/profile_top_item.dart';
import 'package:tgp_flutter/ui/profile/profile_view_model.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';

class Profile extends StatefulWidget{
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends BaseState<Profile> {
  var _vm = ProfileViewModel();
  UserProfile user;
  var level, imagePath;
  var currentBottomIndex = 4;
  var mainWallet;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(_vm.userProfile !=null) {
        user = _vm.userProfile;
        _vm.getWalletBalance();
        //_getVipDetails();
      }
      else{
        Navigator.of(context).pushNamed("/login");
      }
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return ProviderWidget<ProfileViewModel>(
        model: _vm,
        builder: (ctx, vm, _) {
          _handleApiState();
          return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              body: _vm.userProfile==null || _vm.wallet == null
                  ? Center(child: CircularProgressIndicator(),)
                  :Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        CustomColor.theme_bar_gradient_2, BlendMode.color
                    ),
                    image: AssetImage(
                        "images/profile/profile_top_background.png"),
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter,
                  ),
                ),
                child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10.auto, left: 50.auto, right: 50.auto, bottom: 20.auto),
                        child: Row(
                          children: [
                            Container(
                                width: 65.auto,
                                height: 65.auto,
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                            "images/profile/profile_image.png"
                                        )
                                    )
                                )
                            ),
                            _buildUserDetails(),
                          ],
                        ),
                      ),
                      _buildProfileTopItem(),
                      _buildGridViewLayout(),
                    ]
                ),
              )
            // : Container()
          );
        }
    );
  }

  _buildUserDetails() => Container(
    margin: EdgeInsets.only(left: 20.auto),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_vm.userProfile.username??"",
            style: TextStyle(
              color: Colors.white,
              fontSize: (19.2).auto,
            ),
            textAlign: TextAlign.left,
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 3.auto, bottom: 3.auto),
            //"¥ ${widget.userProfile?.balance}",
            child: Text(getTranslatedText("main_wallet")+" :  ¥ ${Format().currencyWithDecimalFormat(_vm.wallet.main)}",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: (11.2).auto
              ),
              textAlign: TextAlign.start,
            ),
          ), Text(getTranslatedText("total_balance")+" : ¥ 0.00",//"总资金  "+(_vm.totalBalance != null ? "¥ "+ Format().currencyWithDecimalFormat(_vm.totalBalance) : "-"),
            style: TextStyle(
                color: Colors.white,
                fontSize: (11.2).auto
            ),
            textAlign: TextAlign.start,
          )
        ]
    ),
  );

  _buildProfileTopItem() => Container(
    margin: EdgeInsets.only(left: 15.auto, right:15.auto),
    child: Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ProfileTopItem(title:getTranslatedText("deposit") ,imagePath:"ic_deposit", routePath:"deposit"),
          ProfileTopItem(title:getTranslatedText("transfer"),imagePath:"ic_transfer", routePath:"wallet_transfer"),
          ProfileTopItem(title:getTranslatedText("withdrawal"),imagePath:"ic_withdraw", routePath:"withdraw"),
        ],
      ),
    ),
  );

  _buildGridViewLayout() => Expanded(
    child: ScrollConfiguration(
      behavior: MyBehavior(),
      child: ListView(
        padding: EdgeInsets.only(
            left: 25.auto, right: 25.auto, bottom: 10.auto, top:20.auto),
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
              ProfileBottomItem(title: getTranslatedText("profile_detail"), imagePath:"ic_profile_user_detail", routePath:"profile_info", navigationID: 0,),
              ProfileBottomItem(title: getTranslatedText("message_center"), imagePath:"ic_message",routePath:"message", navigationID: 0,),
              ProfileBottomItem(title: getTranslatedText("transfer_history"), imagePath:"ic_account_detail",routePath:"transaction", navigationID: 0,),
              ProfileBottomItem(title: getTranslatedText("bet_history"), imagePath:"ic_bet_transaction",routePath:"transaction", navigationID: 1,),
              ProfileBottomItem(title: getTranslatedText("manage_card"), imagePath:"ic_card_detail",routePath:"main_card", navigationID: 0,),
              ProfileBottomItem(title: getTranslatedText("refer_friend"), imagePath:"ic_refer_friend",routePath:"refer_friend", navigationID: 0,),
              ProfileBottomItem(title: getTranslatedText("frequent_question"), imagePath:"ic_profile_question",routePath:"frequent_question", navigationID: 0,),
              ProfileBottomItem(title: getTranslatedText("language"), imagePath:"ic_lang",routePath:"language", navigationID: 0,),
            ],
          ),
          _buildLogoutButton()
        ],
      ),
    ),
  );

  _buildLogoutButton() => Container(
      padding: EdgeInsets.only(bottom: 10.auto),
      child: ColorButton(
        text:Text(
          getTranslatedText("logout"),
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: 16.auto
          ),
        ),
        onClick: () => _logout(),
        isEnabled: true,
        color: CustomColor.theme_bar_gradient_2,
        radius:9.4,
      )
  );

  _handleApiState() {
    handleApiState(_vm.logoutApiState, onSuccess:(){
      _navigateToLogin();
    });
  }

  _navigateToLogin(){
    WidgetsBinding.instance.addPostFrameCallback((_){
      //navigate to login and remove all previous route,
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    });
  }

  _logout() {
    CustomProgressDialog.show(context);
    _vm.logout();
  }
}
