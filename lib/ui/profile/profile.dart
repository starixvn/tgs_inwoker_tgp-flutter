import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/color_button.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/entity/language.dart';
import 'package:tgp_flutter/entity/user_profile.dart';
import 'package:tgp_flutter/extension/format.dart';
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
         _vm.computeTotalBalance();
      } else {
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
              body: _vm.userProfile == null || _vm.balance == null ? buildProgressDialog() : _buildUserInfoContainer());
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
              getTranslatedText("main_wallet") + " :  ¥ ${Format().currencyWithDecimalFormat(_vm.balance)}",
              style: TextStyle(color: Colors.white, fontSize: (11.2).auto),
              textAlign: TextAlign.start,
            ),
          ),
          Text(
            getTranslatedText("total_balance") + " :"+(_vm.totalBalance != null ? "¥ ${Format().currencyWithDecimalFormat(_vm.totalBalance ?? 0.0)}": "-"),
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
              ProfileTopItem(title: "deposit", imagePath: "ic_deposit", routePath: "deposit"),
              ProfileTopItem(title: "transfer", imagePath: "ic_transfer", routePath: "wallet_transfer"),
              ProfileTopItem(title: "withdrawal", imagePath: "ic_withdraw", routePath: "withdraw"),
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
                  _buildProfileBottomItem("profile_detail", "ic_profile_user_detail", "profile_info", 0),
                  _buildProfileBottomItem("message_center", "ic_message", "message", 0, isMessage: false),
                  _buildProfileBottomItem("bet_history", "ic_bet_transaction", "transaction", 0),
                  _buildProfileBottomItem("deposit_history", "ic_account_detail", "transaction", 1),
                  _buildProfileBottomItem("withdrawal_history", "ic_account_detail", "transaction", 2),
                  _buildProfileBottomItem("transfer_history", "ic_account_detail", "transaction", 3),
                  _buildProfileBottomItem("manage_card", "ic_card_detail", "main_card", 0),
                  _buildProfileBottomItem("customer_service", "ic_customer_service", "customer_service", 0),
                  //_buildProfileBottomItem("frequent_question", "ic_profile_question", "frequent_question", 0),
                  _buildProfileBottomItem("language", "ic_lang", "language", 0),
                ],
              ),
              _buildLogoutButton()
            ],
          ),
        ),
      );

  _buildProfileBottomItem(String title, String imagePath, String routePath, int navigationID,
          {bool isMessage = false}) =>
      ProfileBottomItem(
        title: getTranslatedText(title),
        imagePath: imagePath,
        routePath: routePath,
        navigationID: navigationID,
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
          .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Login()), (Route<dynamic> route) => false);
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
