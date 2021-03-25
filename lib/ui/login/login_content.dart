import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tgp_flutter/custom/button.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/entity/language.dart';
import 'package:tgp_flutter/localizations/language_provider.dart';
import 'package:tgp_flutter/main.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/login/login_password_text_form_field.dart';
import 'package:tgp_flutter/ui/login/login_text_form_field.dart';
import 'package:tgp_flutter/ui/login/login_view_model.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'dart:math' as math;

class LoginContent extends StatefulWidget {
  final child;
  LoginContent({this.child, Key key}):super(key:key);

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
  final GlobalKey key = GlobalKey();

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

  void _changeLanguage(Language language) async {
    Locale _locale = await LanguageProvider().setLocale(language);
    MyApp.setLocale(context, _locale);
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
                  icon: SvgPicture.asset(
                    "images/login/ic_login_username.svg",
                    matchTextDirection: true,
                    height: 20.auto,
                  ),
                  hintText: getTranslatedText("enter_username_hint"),
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
              LoginPasswordTextFormField(
                icon: SvgPicture.asset(
                  "images/login/ic_login_password.svg",
                  height: 20.auto,
                ),
                hintText:getTranslatedText("enter_password_hint"),
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
                  title: getTranslatedText("login"),
                  onClick:() =>_login(),
                  isEnabled:true,
                  isGrey: false,
                ),
              ),
              Button(
                title:getTranslatedText("login_later"),
                onClick:(){
                  Navigator.of(context).pushNamedAndRemoveUntil("/home",
                      ModalRoute.withName("/login"));
                },
                isEnabled:true,
                isGrey: true,
              ),
              _buildLanguageText()
            ],
          );
        }
    );
  }

  getTranslatedText(String key) => LanguageProvider().getTranslated(context, key);

  _login() {
    if (username.text == "") {
      setState(() {
        CustomToast.show(getTranslatedText("enter_username_hint"));
      });
    } else if (password.text == "") {
      setState(() {
        CustomToast.show(getTranslatedText("enter_password_hint"));
      });
    } else {
      CustomProgressDialog.show(context);
      _vm.login(username.text,password.text, _isRememberMe);

    }
  }

  _buildLanguageText() {
    var list = LanguageProvider().list;
    var deviceLanguage = list.singleWhere((e) => e.locale == Localizations.localeOf(context));
    return Container(
      margin: EdgeInsets.only(top: 10.auto),
      child: IntrinsicHeight(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(list.length, (index) {
              return Row(
                children: [
                  InkWell(
                      onTap: () {
                        _changeLanguage(list[index]);
                      },
                      child: Text(
                        list[index].name,
                        style: TextStyle(
                            color: deviceLanguage == list[index]?CustomColor.theme_bar_gradient_2:Colors.black
                        ),
                      )
                  ),
                  VerticalDivider(
                    color: Colors.black,
                  )
                ],

              );
            }),
          )
      ),
    );
  }

  _buildForgotPassword() =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //_buildCheckBox(),
          InkWell(
            child: Text(
              getTranslatedText("forgot_password_with_question_mark"),
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
           getTranslatedText("rmb_password"),
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