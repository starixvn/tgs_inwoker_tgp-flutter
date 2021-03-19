import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/button.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/login/login_text_form_field.dart';
import 'package:tgp_flutter/ui/login/login_view_model.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'dart:math' as math;
import 'package:tgp_flutter/constants.dart' as Constants;

class LoginContent extends StatefulWidget {
  @override
  _LoginContentState createState() =>
      _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  bool _obscurePassword = true;
  bool _isRememberMe = true;
  var username = TextEditingController();
  var password = TextEditingController();
  var _vm = LoginViewModel();

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      username.text = await _vm.getUsername();
      password.text = await _vm.getPassword();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<LoginViewModel>(
        model: _vm,
        builder: (ctx, vm, _) {
          _handleApiState(vm);
          return Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10.auto),
                child: LoginTextFormField(
                  icon: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  hintText:Constants.username_hint,
                  onChanged:(value){

                  },
                  onFieldSubmitted:(value){

                  },
                  controller:username,
                  width:context.screenWidth,
                  textInputType:TextInputType.text,
                  textInputAction:TextInputAction.next,
                ),
              ),
              LoginTextFormField(
                icon: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(math.pi),
                  child: Icon(
                    Icons.lock_open,
                    color: Colors.black,
                  ),
                ),
                hintText:Constants.password_hint,
                onChanged:(value){

                },
                onFieldSubmitted:(value){

                },
                controller:password,
                width:context.screenWidth,
                textInputType:TextInputType.visiblePassword,
                textInputAction:TextInputAction.done,
                onShowPassword: (){
                  setState(() =>
                  this._obscurePassword =
                  !this._obscurePassword);

                },
                obscurePassword: _obscurePassword,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCheckBox(),
                  _buildForgotPassword()
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 50.auto,bottom: 10.auto),
                child: Button(
                  title:"登录",
                  onClick:() =>_login(),
                  isEnabled:true,
                  isGrey: false,
                ),
              ),
              Button(
                title:"先去逛逛",
                onClick:(){
                  Navigator.of(context).pushNamed("/home");
                },
                isEnabled:true,
                isGrey: true,
              )
            ],
          );
        }
    );
  }

  _login() {
    if (username.text == "") {
      setState(() {
        CustomToast.show('请输入用户名');
      });
    } else if (password.text == "") {
      setState(() {
        CustomToast.show('请输入密码');
      });
    } else {
      CustomProgressDialog.show(context);
      _vm.login(username.text,password.text, _isRememberMe);

    }
  }

  _buildForgotPassword() =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //_buildCheckBox(),
          InkWell(
            child: Text(
              '忘記密碼?',
              style: TextStyle(
                color: Colors.black,
                decoration:TextDecoration.underline,
              ),
            ),
          )
        ],
      );

  _buildCheckBox() =>
      Row(
        children: [
          Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: this._isRememberMe,
            checkColor: Colors.white,
            activeColor: Colors.black,
            onChanged: (val) =>
                this.setState(() {
                  this._isRememberMe = !this._isRememberMe;
                }),
          ),
          Text(
            "記住账号",
            style: TextStyle(
                color: Colors.black
            ),
          ),
        ],
      );

  _handleApiState(LoginViewModel vm) {
    if(vm.loginApiState == null) return;
    if(!vm.isLoginResultHandled){
      if ((vm.loginApiState?.isError ?? false) ) {
        CustomProgressDialog.hide();
        CustomToast.show(vm.loginApiState.error);
      }
      if(vm.loginApiState.isSuccess){
        CustomProgressDialog.hide();
        _navigateToHome();
      }
    }
    vm.markAsLoginResultHandled();
  }

  _navigateToHome(){
    WidgetsBinding.instance.addPostFrameCallback((_){
      Navigator.of(context).pushNamedAndRemoveUntil("/home",(Route<dynamic> route) => false);
    });
  }
}