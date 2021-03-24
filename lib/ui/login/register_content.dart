
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tgp_flutter/custom/button.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/data/provider/input_validation_provider.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/ui/login/login_password_text_form_field.dart';
import 'package:tgp_flutter/ui/login/login_text_form_field.dart';
import 'package:tgp_flutter/ui/login/login_view_model.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/constants.dart' as Constants;
import 'dart:math' as math;

import '../../src/custom_color.dart';

class RegisterContent extends StatefulWidget {
  @override
  _RegisterContentState createState() => _RegisterContentState();
}

class _RegisterContentState extends State<RegisterContent> {
  bool _obscurePassword=true , _obscureConfirmPassword=true;
  var username = TextEditingController();
  var password = TextEditingController();
  var confirmPassword = TextEditingController();
  var pay = TextEditingController();
  var confirmPay = TextEditingController();
  var invitationCode = TextEditingController();
  InputValidationProvider validate = new InputValidationProvider();
  LoginViewModel _vm = LoginViewModel();

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    confirmPassword.dispose();
    invitationCode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<LoginViewModel>(
      model: _vm,
      builder: (ctx,vm,_){
        _handleApiState();
        return Container(
          child: Column(
            children: [
              LoginTextFormField(
                icon: SvgPicture.asset(
                  "images/login/ic_login_username.svg",
                  height: 20.auto,
                ),
                hintText:Constants.signup_username_hint,
                onChanged:(value){

                },
                onFieldSubmitted:(value){

                },
                controller:username,
                width:context.screenWidth,
                textInputType:TextInputType.text,
                textInputAction:TextInputAction.next,
              ),
              Container(
                margin: EdgeInsets.only(top: 10.auto),
                child: LoginPasswordTextFormField(
                  icon: SvgPicture.asset(
                    "images/login/ic_login_password.svg",
                    height: 20.auto,
                  ),
                  hintText:Constants.password_hint,
                  onChanged:(value){

                  },
                  onFieldSubmitted:(value){

                  },
                  controller:password,
                  width:context.screenWidth,
                  textInputType:TextInputType.visiblePassword,
                  textInputAction:TextInputAction.next,
                  onShowPassword: (){
                    setState(() =>
                    this._obscurePassword =
                    !this._obscurePassword);

                  },
                  obscurePassword: _obscurePassword,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.auto),
                child: LoginPasswordTextFormField(
                  icon: SvgPicture.asset(
                    "images/login/ic_login_password.svg",
                    height: 20.auto,
                  ),
                  hintText:Constants.confirm_password_hint,
                  onChanged:(value){

                  },
                  onFieldSubmitted:(value){

                  },
                  controller:confirmPassword,
                  width:context.screenWidth,
                  textInputType:TextInputType.visiblePassword,
                  textInputAction:TextInputAction.next,
                  onShowPassword: (){
                    setState(() =>
                    this._obscureConfirmPassword =
                    !this._obscureConfirmPassword);

                  },
                  obscurePassword: _obscureConfirmPassword,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.auto),
                child: LoginTextFormField(
                  icon: SvgPicture.asset(
                    "images/login/ic_login_pig.svg",
                    height: 20.auto,
                  ),
                  hintText:Constants.pay_hint,
                  onChanged:(value){

                  },
                  onFieldSubmitted:(value){

                  },
                  controller:pay,
                  width:context.screenWidth,
                  textInputType:TextInputType.text,
                  textInputAction:TextInputAction.next,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.auto),
                child: LoginTextFormField(
                  icon: SvgPicture.asset(
                    "images/login/ic_login_pig.svg",
                    height: 20.auto,
                  ),
                  hintText:Constants.confirm_pay_hint,
                  onChanged:(value){

                  },
                  onFieldSubmitted:(value){

                  },
                  controller:confirmPay,
                  width:context.screenWidth,
                  textInputType:TextInputType.text,
                  textInputAction:TextInputAction.next,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.auto),
                child: LoginTextFormField(
                  icon: SvgPicture.asset(
                    "images/login/ic_login_promotion.svg",
                    height: 20.auto,
                  ),
                  hintText:Constants.promotion_hint,
                  onChanged:(value){

                  },
                  onFieldSubmitted:(value){

                  },
                  controller:invitationCode,
                  width:context.screenWidth,
                  textInputType:TextInputType.text,
                  textInputAction:TextInputAction.next,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 70.auto,bottom: 10.auto),
                child: Button(
                  title:"立即注册",
                  onClick:(){
                    register();
                  },
                  isEnabled:true,
                  isGrey: false,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  
  register() {
    if(!validate.validateUsernameLength(username.text)) {
      setState(() {
        CustomToast.show(Constants.username_error_msg);
      });
    }else if(!validate.validatePasswordLength(password.text)) {
      setState(() {
        CustomToast.show(Constants.password_error_msg);
      });
    }else if(password.text != confirmPassword.text){
      setState(() {
        CustomToast.show(Constants.confirm_password_error_msg);
      });
    }else if(!validate.validatePassword(password.text)){
      setState(() {
        CustomToast.show(Constants.password_validate_error_msg);
      });
    }else if(pay.text != confirmPay.text){
      setState(() {
        CustomToast.show(Constants.confirm_pay_error_msg);
      });
    } else{
      _vm.register(username.text, password.text,confirmPassword.text, "CNY", invitationCode.text);
    }
  }
  
  _handleApiState() {
    if(_vm.registerApiState == null) return;
    if((_vm.registerApiState?.isError ?? false) && !_vm.isRegisterResultHandled){
      CustomToast.show(_vm.registerApiState.error);
    }
    if(!_vm.isLoading){
      //CustomProgressDialog.hide();
    }
    if(_vm.registerApiState.isSuccess){
      WidgetsBinding.instance.addPostFrameCallback((_){
        Navigator.of(context).pushNamed("/home");
      });
    }
    _vm.markAsLoginResultHandled();
  }
}
