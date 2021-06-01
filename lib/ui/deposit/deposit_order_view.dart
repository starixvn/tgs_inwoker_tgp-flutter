import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tgp_flutter/custom/color_button.dart';
import 'package:tgp_flutter/custom/custom_dialog.dart';
import 'package:tgp_flutter/custom/gradient_button.dart';
import 'package:tgp_flutter/entity/deposit_redirect.dart';
import 'package:tgp_flutter/entity/manual_deposit_order.dart';
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
  final String id;
  final ManualDepositOrder manualDepositOrder;
  final DepositRedirect depositRedirect;
  final String payUsername;
  final String depositAmount;
  final String depositChannel;
  final String orderNo;

  DepositOrderView(
      {Key key,
      this.method,
      this.id,
      this.manualDepositOrder,
      this.depositRedirect,
      this.payUsername,
      this.depositAmount,
      this.depositChannel,
      this.orderNo})
      : super(key: key);

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
              body: widget.depositRedirect != null ? _buildLeepayOrder() : _buildManualDepositOrder());
        });
  }

  _buildAppBar() => AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: gradientDecoration,
        ),
        centerTitle: true,
        title: Text(
          getTranslatedText("deposit"),
          style: TextStyle(fontSize: 20.auto, color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      );

  _buildManualDepositOrder() => ListView(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.white),
            padding: EdgeInsets.only(left: 15.auto, right: 15.auto, top: 15.auto, bottom: 15.auto),
            child: Column(
              children: [
                Container(
                  //decoration: BoxDecoration(color: Colors.white),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    getTranslatedText("amount"),
                    style: TextStyle(fontSize: 13.auto, color: CustomColor.grey),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    //"10.00",
                    widget.depositAmount,
                    style: TextStyle(
                        fontSize: (38.5).auto, color: CustomColor.theme_bar_gradient_2, fontWeight: FontWeight.w400),
                    //"¥ $amount"
                  ),
                ),
                Divider(
                  thickness: (1.0).auto,
                  color: CustomColor.very_light_pink_four,
                ),
                _buildText("deposit_method", widget.method),
                _buildText("deposit_channel", widget.manualDepositOrder.methodName),
                _buildOrderText("order_no", widget.orderNo),
                _buildText("pay_username", widget.payUsername),
                _buildText("receiver_bank", widget.depositChannel),
                _buildText("receiver_bank_account", widget.manualDepositOrder.bankAccountName),
                _buildText("receiver_bank_number", widget.manualDepositOrder.bankAccount),
                _buildUploadTextRow(),
                uploadImage == null
                    ? Container()
                    : Container(
                        alignment: Alignment.centerRight, child: SizedBox(height: 80, child: Image.file(uploadImage)))
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15.auto, right: 15.auto, top: 10.auto),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GradientButton(
                    title: getTranslatedText("upload_prof"),
                    onClick: () => _vm.uploadDepositImage(uploadImage.path, widget.id),
                    isEnabled: uploadImage == null ? false : true,
                    radius: 4.8,
                    height: 44.5),
                Container(
                    margin: EdgeInsets.only(top: 10.auto),
                    child: GradientButton(
                        title: getTranslatedText("cancel_deposit"),
                        onClick: () => Navigator.pop(context),
                        isEnabled: true,
                        radius: 4.8,
                        height: 44.5))
                /*RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: CustomColor.grey,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.auto),
                    child: Text(
                      getTranslatedText("cancel_deposit"),
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
                        getTranslatedText("upload_prof"),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    )),*/
              ],
            ),
          )
        ],
      );

  _buildLeepayOrder() => ListView(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.white),
            padding: EdgeInsets.only(left: 15.auto, right: 15.auto, top: 15.auto, bottom: 15.auto),
            child: Column(
              children: [
                Container(
                  //decoration: BoxDecoration(color: Colors.white),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    getTranslatedText("amount"),
                    style: TextStyle(fontSize: 13.auto, color: CustomColor.grey),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    //"10.00",
                    widget.depositAmount,
                    style: TextStyle(
                        fontSize: (38.5).auto, color: CustomColor.theme_bar_gradient_2, fontWeight: FontWeight.w400),
                    //"¥ $amount"
                  ),
                ),
                Divider(
                  thickness: (1.0).auto,
                  color: CustomColor.very_light_pink_four,
                ),
                _buildOrderText("order_no", widget.depositRedirect.formId),
                _buildText("deposit_method", widget.method),
                _buildText("deposit_channel", widget.depositChannel),
                uploadImage == null
                    ? Container()
                    : Container(
                        alignment: Alignment.centerRight, child: SizedBox(height: 80, child: Image.file(uploadImage)))
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 15.auto, right: 15.auto, top: 10.auto),
              child: GradientButton(
                  title: getTranslatedText("done"),
                  radius: 4.8,
                  height: 44.5,
                  isEnabled: true,
                  onClick: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DepositWeb(url: widget.depositRedirect.paymentUrl)))))
        ],
      );

  _buildOrderText(String title, String content) => Container(
        margin: EdgeInsets.only(top: 15.auto),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                getTranslatedText(title) ?? title,
                style: TextStyle(fontSize: 13.auto, color: CustomColor.grey),
              ),
            ),
            Expanded(
              flex: 8,
              child: AutoSizeText(
                content ?? "",
                style: TextStyle(fontSize: 13.auto, color: Colors.black),
                minFontSize: 2,
                maxLines: 1,
                textAlign: TextAlign.end,
              ),
            )
          ],
        ),
      );

  _buildText(String title, String content) {
    if (content == "BankTransfer")
      content = getTranslatedText("bank_transfer");
    else if (content == "Crypto") content = getTranslatedText("crypto");
    return Container(
      margin: EdgeInsets.only(top: 15.auto),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            getTranslatedText(title) ?? title,
            style: TextStyle(fontSize: 13.auto, color: CustomColor.grey),
          ),
          AutoSizeText(
            content ?? "",
            style: TextStyle(fontSize: 13.auto, color: Colors.black),
            minFontSize: 2,
            maxLines: 1,
            textAlign: TextAlign.end,
          ),
        ],
      ),
    );
  }

  _buildUploadTextRow() => Container(
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            //bg image
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              getTranslatedText("upload_prof_hint"),
              style: TextStyle(fontSize: 10.auto, color: CustomColor.grey),
            ),
            ColorButton(
              text: Text(
                getTranslatedText("pick_prof"),
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
            title: null,
            description: getTranslatedText("upload_success"),
            buttonText1: getTranslatedText("confirm"),
            onClick: () {
              Navigator.pop(
                context,
              );
              Navigator.pop(
                context,
              );
            },
            onClick2: () {
              Navigator.pop(context);
            },
          ),
        );
      });
    });
  }
}
