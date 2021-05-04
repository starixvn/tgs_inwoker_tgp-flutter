import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tgp_flutter/custom/color_button.dart';
import 'package:tgp_flutter/custom/custom_dialog.dart';
import 'package:tgp_flutter/entity/deposit_order.dart';
import 'package:tgp_flutter/extension/format.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';

import 'deposit_view_model.dart';
import 'deposit_web.dart';

class DepositOrderView extends StatefulWidget {
  final String method;
  final DepositOrder deposit;
  final String id;
  final String name;

  DepositOrderView({Key key, this.method, this.deposit, this.id, this.name}) : super(key: key);

  @override
  _DepositOrderViewState createState() => _DepositOrderViewState();
}

class _DepositOrderViewState extends BaseState<DepositOrderView> {
  File uploadImage;
  var _vm = DepositViewModel();

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return ProviderWidget<DepositViewModel>(
        model: _vm,
        builder: (ctx, vm, _) {
          _handleApiState();
          return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.grey[100],
              appBar: _buildAppBar(),
              body: ListView(
                children: [
                  Container(
                    decoration: BoxDecoration(color: Colors.white),
                    padding: EdgeInsets.only(left: 15.auto, right: 15.auto, top: 15.auto),
                    child: Column(
                      children: [
                        Container(
                          //decoration: BoxDecoration(color: Colors.white),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "金额",
                            style: TextStyle(fontSize: 13.auto, color: CustomColor.grey),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            //"10.00",
                            Format().currencySymbolWithDecimalFormat(widget.deposit.amount),
                            style: TextStyle(
                                fontSize: (38.5).auto,
                                color: CustomColor.theme_bar_gradient_2,
                                fontWeight: FontWeight.w400),
                            //"¥ $amount"
                          ),
                        ),
                        Divider(
                          thickness: (1.0).auto,
                          color: CustomColor.very_light_pink_four,
                        ),
                        _buildText("存款方式", widget.method),
                        _buildText("存款通道", widget.deposit.methodName),
                        //_buildText("订单编号", "ssss"),
                        _buildText("汇款账户名", widget.name),
                        _buildText("收款银行名称", widget.deposit.channelName),
                        _buildText("收款银行账户", widget.deposit.bankAccountName),
                        _buildText("收款银行账号", widget.deposit.bankAccount),
                        _buildUploadTextRow(),
                        uploadImage == null
                            ? Container()
                            : Container(
                                alignment: Alignment.centerRight,
                                child: SizedBox(height: 80, child: Image.file(uploadImage)))
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    child: Image.asset(
                      "images/order_bg.png",
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15.auto, right: 15.auto),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                          onPressed: () {},
                          color: CustomColor.grey,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.auto),
                            child: Text(
                              "取消订单",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        RaisedButton(
                            onPressed: () => {_vm.uploadDepositImage(uploadImage.path, widget.id)},
                            color: CustomColor.grey,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.auto),
                              child: Text(
                                "上传凭证",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      ],
                    ),
                  )
                ],
              ));
        });
  }

  _buildAppBar() => AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: gradientDecoration,
        ),
        centerTitle: true,
        title: Text(
          "存款",
          style: TextStyle(fontSize: 20.auto, color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      );

  _buildText(String title, String content) => Container(
        margin: EdgeInsets.only(top: 15.auto),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 13.auto, color: CustomColor.grey),
            ),
            Text(
              content,
              style: TextStyle(fontSize: 13.auto, color: Colors.black),
            )
          ],
        ),
      );

  _buildUploadTextRow() => Container(
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            //bg image
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "请完成转账后立即上传凭证以便后台核实",
              style: TextStyle(fontSize: 10.auto, color: CustomColor.grey),
            ),
            ColorButton(
              text: Text(
                "选择凭证",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 13.auto),
              ),
              width: 70.auto,
              height: 30.auto,
              onClick: () {
                chooseImage();
              },
              isEnabled: true,
              color: CustomColor.theme_bar_gradient_2,
              radius: 9.6,
            )
          ],
        ),
      );

  Future<void> chooseImage() async {
    File choosedImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      uploadImage = choosedImage;
    });
  }

  _handleApiState() {
    handleApiState(_vm.uploadDepositImageApiState, onSuccess: () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (BuildContext context) => CustomDialog(
              title: "上传成功",
              description: "",
              buttonText1: "确认",
              onClick: () {
                Navigator.pop(
                  context,
                );
                Navigator.pop(
                  context,
                );
              }),
        );
      });
    });
  }
}
