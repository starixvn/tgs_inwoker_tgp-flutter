import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/custom/outline_border_button.dart';
import 'package:tgp_flutter/entity/user_profile.dart';
import 'package:tgp_flutter/extension/format.dart';
import 'package:tgp_flutter/my_behavior.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/profile/profile_view_model.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:intl/intl.dart';

class Profile extends StatefulWidget{
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var _vm = ProfileViewModel();
  UserProfile user;
  var level, imagePath;
  var currentBottomIndex = 4;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    /*if(_vm.userProfile !=null) {
      user = _vm.userProfile;
      _vm.getTotalBalance();
      _getVipDetails();
    }
    else{
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushNamed("/login");
      });
    }*/
    return ProviderWidget<ProfileViewModel>(
        model: _vm,
        builder: (ctx, vm, _) {
          _handleApiState(vm);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: /*_vm.userProfile!=null ?*/
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                image: DecorationImage(
                  image: AssetImage(
                      "images/profile/profile_top_background.png"),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                ),
              ),
              child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 30.auto),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            imagePath ??"images/vip/ic_vip0.png",
                            width: 15.auto,
                            height: 15.auto,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 5.auto, right: 8.auto),
                            child: Text("VIP"+level.toString(),
                              style: TextStyle(
                                  fontSize: 12.auto,
                                  color: CustomColor.sand_brown
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 10.auto, left: 50.auto, right: 50.auto, bottom: 30.auto),
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
                          Container(
                            margin: EdgeInsets.only(left: 6.auto),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(/*user.memberUsername ??*/ "",
                                    style: TextStyle(
                                      color: CustomColor.sand_brown,
                                      fontSize: 18.auto,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 3.auto, bottom: 3.auto),
                                    //"¥ ${widget.userProfile?.balance}",
                                    child: Text("主帐户 ",// ¥ ${Format().currencyWithDecimalFormat(double.parse(user?.balance))}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13.auto
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ), Text("",//"总资金  "+(_vm.totalBalance != null ? "¥ "+ Format().currencyWithDecimalFormat(_vm.totalBalance) : "-"),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13.auto
                                    ),
                                    textAlign: TextAlign.start,
                                  )
                                ]
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 11.auto, horizontal: 18.auto),
                      margin: EdgeInsets.only(left: 15.auto, right: 15.auto, bottom: 1.5.auto),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildDrawerMenuItem("存款","ic_deposit_profile", "deposit"),
                          _buildDrawerMenuItem("转账","ic_transfer_profile", "wallet_transfer"),
                          _buildDrawerMenuItem("提款","ic_withdraw_profile", "withdraw"),
                          _buildDrawerMenuItem("VIP","ic_vip_action_profile", "vip"),
                          _buildDrawerMenuItem("红利","ic_bonus_profile", ""),
                        ],
                      ),
                    ),
                    Expanded(
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
                                _buildGridLayoutCard("个人资料", "ic_profile_user_detail", "profile_info"),
                                _buildGridLayoutCard("我的信息", "ic_message",""),
                                _buildGridLayoutCard("账户明细", "ic_account_detail","transaction"),
                                _buildGridLayoutCard("投注明细", "ic_bet_transaction","transaction", isBetTransaction: true),
                                _buildGridLayoutCard("管理银行卡", "ic_card_detail","main_card"),
                                _buildGridLayoutCard("推荐好友", "ic_refer_friend",""),
                                _buildGridLayoutCard("关于我们", "ic_about_us","about_us"),
                                _buildGridLayoutCard("系统相关", "ic_system_detail","system"),
                              ],
                            ),
                            Container(
                                padding: EdgeInsets.only(bottom: 10.auto),
                                child: OutlineBorderButton(
                                  title: "退出登录",
                                  onClick:() {
                                    _logout(vm);
                                  },
                                  isEnabled:true,
                                  width:context.screenWidth,
                                  color:Colors.black54,
                                  fontSize: 15.auto,
                                )
                            )
                          ],
                        ),
                      ),
                    )
                  ]
              ),
            )/*:Container(),*/
          );
        }
    );
  }

  _buildDrawerMenuItem(String title, String image, String routePath) =>InkWell(
    onTap:() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushNamed("/$routePath");
      });
    },
    child: Column(
      children: [
        Image.asset(
          "images/profile/$image.png",
          width: 25.auto,
          height: 30.auto,
        ),
        Text(title,
          style: TextStyle(
              fontSize: 10.auto
          ),
        )
      ],
    ),
  );

  _buildGridLayoutCard(String title, String image, String routePath, {bool isBetTransaction =false}) => InkWell(
    onTap: (){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if(isBetTransaction){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Transaction(
                        tabIndex: 1,
                      )
              ));
        }
        else{
          Navigator.of(context).pushNamed("/$routePath");
        }
      });
    },
    child: Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      child: Container(
        //margin: EdgeInsets.symmetric(vertical: 13,horizontal: 10),
        margin: EdgeInsets.only(left: 10.auto, right: 10.auto, top:15.auto),
        child: Column(
          children: [
            Image.asset("images/profile/$image.png",
              height:22.auto,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.auto),
              child: Text(title,
                style: TextStyle(
                    fontSize: 11.auto
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );

  _getVipDetails(){
    switch(user.memberLevelId){
      case 1: {
        level =0;
        imagePath = "images/vip/ic_vip0.png";
        break;
      }
      case 2: {
        level =1;
        imagePath = "images/vip/ic_vip1.png";
        break;
      }
      case 3: {
        level =2;
        imagePath = "images/vip/ic_vip2.png";
        break;
      }
      case 4: {
        level =3;
        imagePath = "images/vip/ic_vip3.png";
        break;
      }
      case 5: {
        level =4;
        imagePath = "images/vip/ic_vip4.png";
        break;
      }
      case 6: {
        level =5;
        imagePath = "images/vip/ic_vip5.png";
        break;
      }
      default:{
        imagePath = "images/vip/ic_vip0.png";
      }
    }
  }
  _handleApiState(ProfileViewModel vm) {
    if(vm.logoutApiState == null) return;
    if ((vm.logoutApiState?.isError ?? false) ) {
      CustomToast.show(vm.logoutApiState.error);
    }
    if(!vm.logoutApiState.isLoading){
      CustomProgressDialog.hide();
    }
    if(vm.logoutApiState.isSuccess){
      _vm.markAsNavigated();
      _navigateToLogin();
    }
  }

  _navigateToLogin(){
    WidgetsBinding.instance.addPostFrameCallback((_){
      //navigate to login and remove all previous route,
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    });
  }

  _logout(ProfileViewModel vm) {
    CustomProgressDialog.show(context);
    vm.logout();
  }
}
