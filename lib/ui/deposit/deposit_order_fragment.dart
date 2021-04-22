import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:tgp_flutter/extension/navigate_without_animation.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';

import 'deposit_view_model.dart';
import 'deposit_web.dart';

class DepositOrderFragment extends StatefulWidget {
  //final Order order;
  final String params;

  DepositOrderFragment(
      {Key key,
      // this.order,
      this.params})
      : super(key: key);

  @override
  _DepositOrderFragmentState createState() => _DepositOrderFragmentState();
}

class _DepositOrderFragmentState extends BaseState<DepositOrderFragment> with TickerProviderStateMixin {
  DepositViewModel _vm = DepositViewModel();
  AnimationController _controller;
  bool _isQrCodeVisible = false, _isTransferVisible = false, _isNavigatedToWeb = false;
  Uint8List _bytesImage;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    /*_controller = AnimationController(
        vsync: this,
        duration: Duration(
            seconds:
            widget.order.expiredTime) // gameData.levelClock is a user entered number elsewhere in the applciation
    );
    _controller.forward();*/
    _checkPaymentType();
  }

  Widget build(BuildContext context) {
    return ProviderWidget<DepositViewModel>(
        model: _vm,
        builder: (ctx, vm, _) {
          _handleApiState();
          return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.grey[100],
              appBar: AppBar(
                automaticallyImplyLeading: false,
                flexibleSpace: Container(
                  decoration: gradientDecoration,
                ),
                centerTitle: true,
                title: Text(
                  "存款",
                  style: TextStyle(fontSize: 20.auto, color: CustomColor.grey),
                ),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context, NavigateWithoutAnimation());
                  },
                ),
              ),
              body:
                  //_vm.isLoading ? Center(child: CircularProgressIndicator(),) :
                  ListView(
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
                            "¥ 0.00",
                            //"¥ ${widget.order.amount}",
                            style:
                                TextStyle(fontSize: (38.5).auto, color: CustomColor.grey, fontWeight: FontWeight.w400),
                            //"¥ $amount"
                          ),
                        ),
                        Divider(
                          thickness: (1.0).auto,
                          color: CustomColor.very_light_pink_four,
                        ),
                        _buildText("下单时间", " "),
                        _buildText("存款方式", ""),
                        _buildText("订单编号", ""),
                        _isTransferVisible ? _buildText("银行", "") : Container(),
                        _isTransferVisible ? _buildText("账户", "") : Container(),
                        _isTransferVisible ? _buildText("账号", "") : Container(),
                        Container(
                          margin: EdgeInsets.only(top: 15.auto),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "距离此订单有效期",
                                style: TextStyle(fontSize: 13.auto, color: CustomColor.grey),
                              ),
                              /*CountdownTimer(
                                animation: StepTween(
                                  begin: widget.order.expiredTime, // THIS IS A USER ENTERED NUMBER
                                  end: 0,
                                ).animate(_controller),
                              ),*/
                            ],
                          ),
                        ),
                        _isQrCodeVisible
                            ? Container(
                                margin: EdgeInsets.only(top: 15.auto),
                                alignment: Alignment.center,
                                child:
                                    Container() /*Image.memory(Base64Decoder().convert((widget.order.qrcode).substring((widget.order.qrcode).indexOf(",")+1)),
                              height: 120.auto,
                              width: 120.auto,)*/
                                )
                            : Container(),
                      ],
                    ),
                  ),
                  Image.asset(
                    "images/order_bg.png",
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15.auto, right: 15.auto),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                          onPressed: () => cancel(),
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
                            onPressed: () => {
                                  //_vm.depositStatus(widget.order.id, false)
                                },
                            color: CustomColor.grey,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.auto),
                              child: Text(
                                "到账核对",
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

  _handleApiState() {
    /*if (_vm.depositStatusApiState == null) return;
    if ((_vm.depositStatusApiState?.isError ?? false)) {
      CustomToast.show(_vm.depositStatusApiState.error);
    }
    if((_vm.depositStatusApiState?.isSuccess ?? false) && _isNavigatedToWeb){
      WidgetsBinding.instance.addPostFrameCallback((_){
        Navigator.pop(context, ModalRoute.withName('/deposit'));
      });
    }*/
  }

  _checkPaymentType() {
    /*if(widget.order.isQrcode ==1){
      _isQrCodeVisible = true;
    }
    else if(widget.order.isTransfer == 1){
      _isTransferVisible = true;
    }
    else {
      if (!(_isNavigatedToWeb)) {
        if (widget.order.url != null && widget.order.url.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _vm.resetApiState(true, false, false);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DepositWeb(
                          url: widget.order.url,
                          typeTitle: widget.order.typeTitle,
                          params: widget.params,
                        )
                ));
          });
        }
      }
    }*/
  }

  cancel() {
    setState(() {
      _isNavigatedToWeb = true;
      //_vm.depositStatus(widget.order.id, true);
    });
  }
}
