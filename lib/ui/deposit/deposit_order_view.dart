import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tgp_flutter/custom/color_button.dart';
import 'package:tgp_flutter/custom/custom_dialog.dart';
import 'package:tgp_flutter/custom/gradient_button.dart';
import 'package:tgp_flutter/entity/deposit_redirect.dart';
import 'package:tgp_flutter/entity/deposit_redirect_applepay.dart';
import 'package:tgp_flutter/entity/manual_deposit_order.dart';
import 'package:tgp_flutter/entity/promotion.dart';
import 'package:tgp_flutter/extension/format.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';

import 'deposit_view_model.dart';
import 'deposit_web.dart';

class DepositOrderView extends StatefulWidget {
  final String? method;
  final String? id;
  final DepositRedirect? depositRedirect;
  final String? depositAmount;
  final String? depositChannel;
  final String? promotionName;
  final String? transName;
  final DepositRedirectApplePay? depositRedirectApplePay;
  final String? exchangeRate;
  final String? expectedAmount;

  DepositOrderView(
      {this.method,
      this.id,
      this.depositRedirect,
      this.depositAmount,
      this.depositChannel,
      this.promotionName,
      this.transName,
      this.depositRedirectApplePay,
      this.exchangeRate,
      this.expectedAmount});

  @override
  _DepositOrderViewState createState() => _DepositOrderViewState();
}

class _DepositOrderViewState extends BaseState<DepositOrderView> {
  var _vm = DepositViewModel();

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return ProviderWidget<DepositViewModel>(
        model: _vm,
        builder: (ctx, vm, _) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.grey[100],
              appBar: _buildAppBar(),
              body: _buildLeepayOrder());
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
                    widget.depositAmount!,
                    style: TextStyle(
                        fontSize: (38.5).auto, color: CustomColor.theme_bar_gradient_2, fontWeight: FontWeight.w400),
                    //"¥ $amount"
                  ),
                ),
                Divider(
                  thickness: (1.0).auto,
                  color: CustomColor.very_light_pink_four,
                ),
                widget.depositRedirect != null
                    ? _buildOrderText("order_no", widget.depositRedirect!.formId)
                    : _buildOrderText("order_no", widget.depositRedirectApplePay!.formId),
                _buildText("payment_type", widget.method!),
                _buildText("payment_channel", widget.depositChannel!),
                if (widget.exchangeRate != null) _buildText("exchange_rate", widget.exchangeRate!),
                if (widget.expectedAmount != null) _buildText("expected_amount", widget.expectedAmount!),
                if (widget.transName != null) _buildText("transfer_name", widget.transName ?? ""),
                if (widget.promotionName != null) _buildText("promotion_picker", widget.promotionName ?? ""),
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
                  onClick: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DepositWeb(
                                url: widget.depositRedirect != null
                                    ? widget.depositRedirect!.paymentUrl
                                    : widget.depositRedirectApplePay!.paymentUrl,
                                brandLogoUrl: _vm.brandLogoUrl,
                              )))))
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
                content,
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
            content,
            style: TextStyle(fontSize: 13.auto, color: Colors.black),
            minFontSize: 2,
            maxLines: 1,
            textAlign: TextAlign.end,
          ),
        ],
      ),
    );
  }
}
