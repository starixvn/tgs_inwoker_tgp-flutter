import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/color_button.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/entity/language.dart';
import 'package:tgp_flutter/entity/user_profile.dart';
import 'package:tgp_flutter/extension/format.dart';
import 'package:tgp_flutter/extension/navigate_without_animation.dart';
import 'package:tgp_flutter/localizations/language_provider.dart';
import 'package:tgp_flutter/my_behavior.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/card/main_card.dart';
import 'package:tgp_flutter/ui/deposit/deposit.dart';
import 'package:tgp_flutter/ui/frequent_question/frequent_question.dart';
import 'package:tgp_flutter/ui/language/language_view.dart';
import 'package:tgp_flutter/ui/login/login.dart';
import 'package:tgp_flutter/ui/message/message_view.dart';
import 'package:tgp_flutter/ui/profile/profile_bottom_item.dart';
import 'package:tgp_flutter/ui/profile/profile_top_item.dart';
import 'package:tgp_flutter/ui/profile/profile_view_model.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/ui/profile_info/profile_info.dart';
import 'package:tgp_flutter/ui/referFriend/refer_friend.dart';
import 'package:tgp_flutter/ui/transaction/transaction.dart';
import 'package:tgp_flutter/ui/transfer/wallet_transfer.dart';
import 'package:tgp_flutter/ui/withdraw/withdraw.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends BaseState<Profile> {
  var _vm = ProfileViewModel();
  var currentBottomIndex = 4;
  var mainWallet;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_vm.userProfile != null) {
        //_vm.getWalletBalance();
        //_getVipDetails();
      } else {
        Navigator.of(context).push(NavigateWithoutAnimation(widget: Login()));
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
              body: _vm.userProfile == null || _vm.wallet == null ? buildProgressDialog() : _buildUserInfoContainer());
        });
  }

  _buildUserInfoContainer() => Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            colorFilter: ColorFilter.mode(CustomColor.theme_bar_gradient_2, BlendMode.color),
            image: AssetImage("images/profile/profile_top_background.png"),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Column(children: [
          Padding(
            padding: EdgeInsets.only(top: 10.auto, left: 50.auto, right: 50.auto, bottom: 10.auto),
            child: Row(
              children: [
                Container(
                    width: 65.auto,
                    height: 65.auto,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill, image: AssetImage("images/profile/profile_image.png")))),
                _buildUserInfoText(),
              ],
            ),
          ),
          _buildProfileTopItem(),
          _buildGridViewLayout(),
        ]),
      );

  _buildUserInfoText() => Container(
        margin: EdgeInsets.only(left: 20.auto),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            _vm.userProfile.username ?? "",
            style: TextStyle(
              color: Colors.white,
              fontSize: (19.2).auto,
            ),
            textAlign: TextAlign.left,
          ),
          Padding(
            padding: EdgeInsets.only(top: 3.auto, bottom: 3.auto),
            //"¥ ${widget.userProfile?.balance}",
            child: Text(
              getTranslatedText("main_wallet") + " :  ¥ ${Format().currencyWithDecimalFormat(_vm.wallet.main)}",
              style: TextStyle(color: Colors.white, fontSize: (11.2).auto),
              textAlign: TextAlign.start,
            ),
          ),
          Text(
            getTranslatedText("total_balance") + " : ¥ 0.00",
            //"总资金  "+(_vm.totalBalance != null ? "¥ "+ Format().currencyWithDecimalFormat(_vm.totalBalance) : "-"),
            style: TextStyle(color: Colors.white, fontSize: (11.2).auto),
            textAlign: TextAlign.start,
          )
        ]),
      );

  _buildProfileTopItem() => Container(
        margin: EdgeInsets.only(left: 15.auto, right: 15.auto),
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
              ProfileTopItem(title: getTranslatedText("deposit"), imagePath: "ic_deposit", route: Deposit()),
              ProfileTopItem(title: getTranslatedText("transfer"), imagePath: "ic_transfer", route: WalletTransfer()),
              ProfileTopItem(title: getTranslatedText("withdrawal"), imagePath: "ic_withdraw", route: Withdraw()),
            ],
          ),
        ),
      );

  _buildGridViewLayout() => Expanded(
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: ListView(
            padding: EdgeInsets.only(left: 25.auto, right: 25.auto, bottom: 10.auto, top: 20.auto),
            shrinkWrap: true,
            primary: false,
            physics: AlwaysScrollableScrollPhysics(),
            children: [
              GridView.count(
                padding: EdgeInsets.only(bottom: 30.auto),
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisSpacing: 15.auto,
                mainAxisSpacing: 15.auto,
                children: [
                  _buildProfileBottomItem("profile_detail", "ic_profile_user_detail", ProfileInfo()),
                  _buildProfileBottomItem("message_center", "ic_message", MessageView(), isMessage: true),
                  _buildProfileBottomItem("transfer_history", "ic_account_detail", Transaction()),
                  _buildProfileBottomItem(
                      "bet_history",
                      "ic_bet_transaction",
                      Transaction(
                        tabIndex: 1,
                      )),
                  _buildProfileBottomItem("manage_card", "ic_card_detail", MainCard()),
                  _buildProfileBottomItem("refer_friend", "ic_refer_friend", ReferFriend()),
                  _buildProfileBottomItem("frequent_question", "ic_profile_question", FrequentQuestion()),
                  _buildProfileBottomItem("language", "ic_lang", LanguageView()),
                ],
              ),
              _buildLogoutButton()
            ],
          ),
        ),
      );

  _buildProfileBottomItem(
    String title,
    String imagePath,
    Widget route,
  {bool isMessage = false}
  ) =>
      ProfileBottomItem(
        title: getTranslatedText(title),
        imagePath: imagePath,
        route: route,
        isMessage: isMessage,
      );

  _buildLogoutButton() => Container(
      padding: EdgeInsets.only(bottom: 10.auto),
      child: ColorButton(
        text: Text(
          getTranslatedText("logout"),
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 16.auto),
        ),
        onClick: () => _logout(),
        isEnabled: true,
        color: CustomColor.theme_bar_gradient_2,
        radius: 9.4,
      ));

  _logout() {
    ProgressDialog.show(context);
    _vm.logout();
  }

  _navigateToLogin() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //navigate to login and remove all previous route,
      Navigator.of(context)
          .pushAndRemoveUntil(NavigateWithoutAnimation(widget: Login()), (Route<dynamic> route) => false);
    });
  }

  _handleApiState() {
    handleApiState(_vm.logoutApiState, onSuccess: () {
      _navigateToLogin();
    }, onError: (error, errorCode) {
      _navigateToLogin();
    });
    handleApiState(_vm.getWalletBalanceApiState, isAutoHideLoading: false, onSuccess: () {});
  }
}
