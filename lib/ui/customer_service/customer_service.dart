import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tgp_flutter/custom/custom_picker_dialog.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/custom/gradient_button.dart';
import 'package:tgp_flutter/entity/brand_communication.dart';
import 'package:tgp_flutter/environment_config.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/ui/customer_service/customer_service_qr_code.dart';
import 'package:tgp_flutter/ui/customer_service/customer_service_view_model.dart';
import 'package:tgp_flutter/ui/customer_service/customer_service_web_view.dart';

class CustomerService extends StatefulWidget {
  @override
  _CustomerServiceState createState() => _CustomerServiceState();
}

class _CustomerServiceState extends BaseState<CustomerService> {
  CustomerServiceViewModel _vm = CustomerServiceViewModel();
  var isShowing = false;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _vm.getBrandCommunication();
      _vm.getLiveChatUrl(getCurrentLanguage().apiCode ?? "en-US");
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return ProviderWidget<CustomerServiceViewModel>(
        model: _vm,
        builder: (ctx, vm, _) {
          _handleApiState();
          return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                flexibleSpace: Container(
                  decoration: gradientDecoration,
                ),
                centerTitle: true,
                title: Text(
                  getTranslatedText("customer_service"),
                  style: TextStyle(fontSize: 20.auto),
                ),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              body: _vm.communicationList == null
                  ? buildProgressDialog(_vm.brandLogoUrl)
                  : Stack(
                      children: [
                        Container(
                          width: context.screenWidth,
                          height: context.screenHeight,
                          padding: EdgeInsets.only(top: 230.auto, left: 20.auto, right: 20.auto),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                alignment: Alignment.topCenter, image: AssetImage(getBgImage()), fit: BoxFit.cover),
                          ),
                          child: Column(children: [
                            buildLiveChatRow(),
                            Column(
                              children: List.generate(_vm.communicationList!.length, (index) {
                                return Container(
                                  child: _buildCSRow(_vm.communicationList![index].type, "cs_join", "cs_qr_code",
                                      "support-" + (_vm.communicationList![index].type ?? "").toLowerCase(),
                                      qrCode: _vm.communicationList![index]),
                                );
                              }),
                            )
                          ]),
                        ),
                      ],
                    ));
        });
  }

  getBgImage() {
    String code = getCurrentLanguage().apiCode;
    if (code == "zh-CN" || code == "zh-TW")
      return "images/support/cs_bg/${getCurrentLanguage().apiCode}/customer_service.png";
    else
      return "images/support/cs_bg/en-US/customer_service.png";
  }

  buildLiveChatRow() => Visibility(
        visible: _vm.liveChatUrl == null ? false : true,
        child: InkWell(
          onTap: () {
            //ProgressDialog.show(context, _vm.brandLogoUrl);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CustomerServiceWebView(
                          url: _vm.liveChatUrl!,
                          brandLogoUrl: _vm.brandLogoUrl,
                        )));
          },
          child: Container(
            padding: EdgeInsets.only(left: 20.auto, right: 20.auto),
            margin: EdgeInsets.only(top: 15.auto),
            height: 40.auto,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child:
                      /*ImageIcon(
                    AssetImage("images/support/support_call.png"),
                    size: 23.auto,
                    color: CustomColor.theme_bar_gradient_1,
                  ),*/
                      SvgPicture.asset(
                    "images/support/support-call.svg",
                    height: 23.auto,
                    color: CustomColor.theme_bar_gradient_1,
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    margin: EdgeInsets.only(left: 10.auto),
                    child: Text(
                      getTranslatedText("online_cs"),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    getTranslatedText("contact"),
                    textAlign: TextAlign.end,
                    style: TextStyle(color: CustomColor.theme_bar_gradient_1),
                  ),
                )
              ],
            ),
          ),
        ),
      );

  _buildCSRow(String? title, String text, String routePath, String? imagePath, {BrandCommunication? qrCode}) => InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.only(left: 20.auto, right: 20.auto),
          margin: EdgeInsets.only(top: 15.auto),
          height: 40.auto,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child:
                    /*ImageIcon(
                  AssetImage("images/support/$imagePath.png"),
                  size: 23.auto,
                  color: CustomColor.theme_bar_gradient_1,
                ),*/
                    SvgPicture.asset(
                  "images/support/$imagePath.svg",
                  height: 23.auto,
                  color: CustomColor.theme_bar_gradient_1,
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.only(left: 10.auto),
                  child: Text(
                    getTranslatedText(title) ?? title,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  ((qrCode!.appId) ?? qrCode.phone) ?? "",
                  // getTranslatedText(text),
                  style: TextStyle(color: CustomColor.theme_bar_gradient_1),
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: qrCode.appId ?? qrCode.phone));
                    CustomToast.show(getTranslatedText("copy_text"));
                  },
                  child: ImageIcon(
                    AssetImage("images/support/ic_copy.png"),
                    size: 23.auto,
                    color: CustomColor.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  _buildQrCodeDialog(BrandCommunication qrCode) {
    return Dialog(
      elevation: 5,
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 80.auto),
      child: Container(
        width: 50.auto,
        height: 170.auto,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: 10.auto),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          QrImage(
            data: qrCode.qrCodeUrl!,
            version: QrVersions.auto,
            size: 150.0,
          ),
          Text(
            qrCode.type ?? "",
            textAlign: TextAlign.center,
          )
        ]),
      ),
    );
  }

  _showDialog(BrandCommunication qrCode) {
    showDialog(context: context, builder: (_) => _buildQrCodeDialog(qrCode));
  }

  _handleApiState() {
    handleApiState(_vm.getBrandCommunicationApiState, isAutoHideLoading: false, onSuccess: () {});
    handleApiState(_vm.getLiveChatUrlApiState, isAutoHideLoading: false, onSuccess: () {});
  }
}
