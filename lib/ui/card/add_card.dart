import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/color_button.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_text_form_field.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/extension/format.dart';
import 'package:tgp_flutter/my_behavior.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'card_view_model.dart';

class AddCard extends StatefulWidget {
  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends BaseState<AddCard> {
  var _bankNumController = TextEditingController(), _passController = TextEditingController();
  var _vm = CardViewModel();
  var isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return ProviderWidget<CardViewModel>(
        model: _vm,
        builder: (ctx, vm, _) {
          _handleApiState();
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                elevation: 0,
                leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(
                        context,
                      );
                    }),
                title: Text(
                  "管理银行卡",
                  style: TextStyle(fontSize: 20.auto),
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(40),
                  child: Container(
                      margin: EdgeInsets.symmetric(vertical: 20.auto),
                      alignment: Alignment.center,
                      child: Text(
                        "¥ 0.00",
                        /*_vm.mainAccountBalance ==null?"-":"¥ ${Format().currencyWithDecimalFormat(
                            _vm.mainAccountBalance)}"*/
                        style: TextStyle(fontSize: 16.auto, color: Colors.white),
                      )),
                ),
                flexibleSpace: Image(
                  image: AssetImage("images/home_user_info_bottom_bar_background.png"),
                  fit: BoxFit.scaleDown,
                ),
                backgroundColor: Colors.transparent,
              ),
              body: Container(
                padding: EdgeInsets.only(
                  left: 10.auto,
                  right: 10.auto,
                  top: 5.auto,
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: ListView(
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 20.auto, bottom: 10.auto),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "添加银行卡",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )),
                    CustomTextFormField(
                      title: "银行卡号",
                      hintText: "请输入银行卡号",
                      onChanged: (value) => _onTextChange(value),
                      onFieldSubmitted: (value) => _onTextChange(value),
                      controller: _bankNumController,
                      focusNode: null,
                      width: context.screenWidth - 70.auto,
                      textInputType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.auto),
                      child: CustomTextFormField(
                        title: "提款密码",
                        hintText: "请输入提款密码",
                        onChanged: (value) => _onTextChange(value),
                        onFieldSubmitted: (value) => _onTextChange(value),
                        controller: _passController,
                        focusNode: null,
                        width: context.screenWidth - 70.auto,
                        textInputType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                    _getHintText(),
                    ColorButton(
                      text: Text(
                        "确定",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 16.auto),
                      ),
                      onClick: () {
                        _onClick();
                      },
                      isEnabled: isButtonEnabled,
                      color: CustomColor.theme_bar_gradient_2,
                      radius: 9.6,
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  _getHintText() => Container(
        margin: EdgeInsets.only(top: 2.auto, bottom: 20.auto),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/card/ic_hint.png",
              width: 15.auto,
              height: 15.auto,
            ),
            Container(
              margin: EdgeInsets.only(left: 5.auto),
              child: Text(
                "资讯加密处理，仅用银行验证",
                style: TextStyle(fontSize: 9.auto, color: Colors.red),
              ),
            )
          ],
        ),
      );

  _onTextChange(String value) {
    if (_bankNumController.text.isNotEmpty && _passController.text.isNotEmpty) {
      setState(() {
        isButtonEnabled = true;
      });
    } else {
      setState(() {
        isButtonEnabled = false;
      });
    }
  }

  _onClick() {
    /* ProgressDialog.show(context);
    _vm.addCard(_bankNumController.text, _passController.text);*/
  }

  _handleApiState() {
    /*if (_vm.addCardApiState == null) {
      return;
    }
    if ((_vm.addCardApiState?.isError ?? false)) {
      CustomToast.show(_vm.addCardApiState.error);
       ProgressDialog.hide();
      FocusScope.of(context).requestFocus(FocusNode());
      _vm.resetApiState(isAddCardApiState: true);
    }
    if((_vm.addCardApiState?.isSuccess ?? false)){
      _vm.resetApiState(isAddCardApiState: true);
       ProgressDialog.hide();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed('/main_card');
        Navigator.of(context).popAndPushNamed("/main_card");
      });
    }*/
  }
}
