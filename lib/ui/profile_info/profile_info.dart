import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/entity/profile_info_item.dart';
import 'package:tgp_flutter/entity/user_profile.dart';
import 'package:tgp_flutter/entity/wallet_response.dart';
import 'package:tgp_flutter/extension/format.dart';
import 'package:tgp_flutter/my_behavior.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/profile/profile_view_model.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/ui/profile_info/profile_info_view_model.dart';
import 'package:tgp_flutter/ui/transaction/transaction.dart';
import 'package:intl/intl.dart';

class ProfileInfo extends StatefulWidget{
  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState  extends BaseState<ProfileInfo> {
  var _vm = ProfileInfoViewModel();
  UserProfile user;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return ProviderWidget<ProfileInfoViewModel>(
        model: _vm,
        builder: (ctx, vm, _) {
          _handleApiState();
          return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                flexibleSpace: Container(
                  decoration: gradientDecoration,
                ),
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text("个人资料",
                  style: TextStyle(fontSize: 16.auto),
                ),
              ),
              body:ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: new BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        )
                    ),
                    child:SingleChildScrollView(

                      child: Column(
                        children: [
                          _buildInfoCard(
                            "基本资料",
                            [ProfileInfoItem.REAL_NAME, ProfileInfoItem.PHONE_NUMBER, ProfileInfoItem.EMAIL],
                            [
                              _getItemText(/*_vm.userProfile.memberName*/),
                              _getItemText(/*_vm.userProfile.memberPhone*/),
                              _getItemText(/*_vm.userProfile.memberEmail*/)
                            ],
                            ["real_ name_verification","phone_verification","email_verification"],
                          ),
                          _buildInfoCard(
                            "其他资料",
                            [ProfileInfoItem.QQ_NUMBER,ProfileInfoItem.WEIXIN_NUMBER, ProfileInfoItem.ADDRESS],
                            [
                              _getItemText(/*_vm.userProfile.memberQq*/),
                              _getItemText(/*_vm.userProfile.memberWechat*/),
                              _getItemText(/*_vm.userProfile.memberAddress, isShowSet: true*/)
                            ],
                            ["qq_account","wechat","address"],
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.auto),
                            child: _buildInfoCard(
                              "安全中心",
                              [ProfileInfoItem.LOGIN_PASSWORD, ProfileInfoItem.WITHDRAW_PASSWORD, ProfileInfoItem.SECURITY_ANSWER],
                              [
                                _getItemText(/*"", isPassword: true*/),
                                _getItemText(/*_vm.userProfile.memberSafePassword, isShowSet: true*/),
                                _getItemText(/*"", isSecurityAnswer: true*/)
                              ],
                              ["edit_password","withdraw_password",
                                "edit_security_answer"// if no security will navigate to security answer, else will navigate to edit security answer
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
              )
          );
        }
    );
  }

  _buildInfoCard(String title, List<ProfileInfoItem> itemList, List<String> itemDescriptionList, List<String> pathList) =>
      Container(
        margin: EdgeInsets.only(left: 10.auto,right:10.auto, top: 15.auto),
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 5,
          child: Container(
            margin: EdgeInsets.all(20.auto),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 15.auto
                  ),
                ),
                Column(
                    children:List.generate(itemList.length,(index) {
                      return Container(
                        child: _buildInfoItem(
                            itemList[index].getImagePath,
                            itemList[index].displayName,
                            itemDescriptionList[index],
                            pathList[index]
                        ),
                      );
                    })
                ),
              ],
            ),
          ),
        ),
      );

  _buildInfoItem(String imagePath, String itemTitle, String itemDescription, String routePath, {bool isEmpty = false}) =>
      InkWell(
        onTap: (){
          Navigator.of(context).pushNamed("/$routePath");
        },
        child: Container(
          margin: EdgeInsets.only(top: 20.auto),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 10.auto),
                child: ImageIcon(
                  AssetImage(imagePath),
                  size: 20.auto,
                )
                /*Image.asset(imagePath,
                  width: 20.auto,
                ),*/
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemTitle,
                    style: TextStyle(
                        fontSize: 15.auto
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 3.auto),
                    child: Text(
                      itemDescription,
                      style: TextStyle(
                          fontSize: 15.auto,
                          color: isEmpty?CustomColor.grey:CustomColor.theme_bar_gradient_1
                      ),
                    ),
                  )
                ],
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 13.auto,
              ),
            ],
          ),
        ),
      );

  _getItemText(/*String text,*/ {bool isPassword = false, bool isSecurityAnswer = false, bool isShowSet = false}){
    var text = "";
    if(text.isNotEmpty) {
      if (isShowSet) {
        return "已设置";
      } else
        return text;
    }else if(isPassword){
      return "";
    }
    else if(isSecurityAnswer){
      return "已设置";
    }
    else {
      return "未设置";
    }
  }

  _handleApiState() {
    /* if(_vm.logoutApiState == null) return;
    if ((_vm.logoutApiState?.isError ?? false) ) {
      CustomToast.show(_vm.logoutApiState.error);
    }
    if(!_vm.logoutApiState.isLoading){
      CustomProgressDialog.hide();
    }
    if(_vm.logoutApiState.isSuccess){
      _vm.markAsNavigated();
    }*/
  }

}
