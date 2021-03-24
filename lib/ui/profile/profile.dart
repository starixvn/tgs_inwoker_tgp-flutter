import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/entity/user_profile.dart';
import 'package:tgp_flutter/my_behavior.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/profile/profile_bottom_item.dart';
import 'package:tgp_flutter/ui/profile/profile_top_item.dart';
import 'package:tgp_flutter/ui/profile/profile_view_model.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';

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
                            Container(
                              margin: EdgeInsets.only(left: 20.auto),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(_vm.userProfile.username,
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
                                      child: Text("主帐户 : ¥ 0.00",// ¥ ${Format().currencyWithDecimalFormat(double.parse(user?.balance))}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: (11.2).auto
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ), Text("总资金 : ¥ 0.00",//"总资金  "+(_vm.totalBalance != null ? "¥ "+ Format().currencyWithDecimalFormat(_vm.totalBalance) : "-"),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: (11.2).auto
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
                              ProfileTopItem(title:"存款",imagePath:"ic_deposit", routePath:""),
                              ProfileTopItem(title:"转账",imagePath:"ic_transfer", routePath:""),
                              ProfileTopItem(title:"提款",imagePath:"ic_withdraw", routePath:""),
                            ],
                          ),
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
                                  ProfileBottomItem(title:"个人资料", imagePath:"ic_profile_user_detail", routePath:""),
                                  ProfileBottomItem(title:"消息中心", imagePath:"ic_message",routePath:""),
                                  ProfileBottomItem(title:"转换记录", imagePath:"ic_account_detail",routePath:""),
                                  ProfileBottomItem(title:"投注明细", imagePath:"ic_bet_transaction",routePath:""),
                                  ProfileBottomItem(title:"管理银行卡", imagePath:"ic_card_detail",routePath:""),
                                  ProfileBottomItem(title:"推荐好友", imagePath:"ic_refer_friend",routePath:""),
                                  ProfileBottomItem(title:"常见问题", imagePath:"ic_profile_question",routePath:""),
                                  ProfileBottomItem(title:"语言", imagePath:"ic_lang",routePath:""),
                                ],
                              ),
                              Container(
                                  padding: EdgeInsets.only(bottom: 10.auto),
                                  child: ElevatedButton(
                                      child: Text(
                                          "退出登录",
                                          style: TextStyle(fontSize: (16.3).auto)
                                      ),
                                      style: ButtonStyle(
                                          //foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                          backgroundColor: MaterialStateProperty.all<Color>(CustomColor.theme_bar_gradient_2),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular((9.4).auto),
                                              )
                                          )
                                      ),
                                      onPressed: () => null
                                  )
                              )
                            ],
                          ),
                        ),
                      )
                    ]
                ),
              )
          );
        }
    );
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
