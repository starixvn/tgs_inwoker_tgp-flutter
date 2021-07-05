import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/color_button.dart';
import 'package:tgp_flutter/custom/custom_dialog.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/entity/promotion.dart';
import 'package:tgp_flutter/extension/format.dart';
import 'package:tgp_flutter/localizations/language_provider.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/home/home.dart';
import 'package:tgp_flutter/ui/promotion/promotion_item.dart';
import 'package:tgp_flutter/ui/promotion/promotion_view_model.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';

class PromotionItemDetails extends StatefulWidget {
  final String imagePath;
  final Promotion promotion;
  final PromotionViewModel vm;

  PromotionItemDetails({Key key, this.imagePath, this.promotion, this.vm}) : super(key: key);

  @override
  _PromotionItemDetailsState createState() => _PromotionItemDetailsState();
}

class _PromotionItemDetailsState extends BaseState<PromotionItemDetails> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: ListView(
        children: [
          Stack(
            children: [
              widget.promotion.promotionLocalization?.mobileBanner==null && widget.promotion.mobileBanner==null
                  ? Container()
                  : CachedNetworkImage(
                      placeholder: (context, url) => Container(
                            color: CustomColor.very_light_pink_four,
                          ),
                      imageUrl: widget.promotion.promotionLocalization.mobileBanner,
                      //handling error
                      fit: BoxFit.fill),
              Container(
                margin: EdgeInsets.only(left: 15.auto, right: 15.auto, top: 15.auto, bottom: 15.auto),
                width: 150.auto,
                child: Text(
                  _getPromotionTitleName(),
                  style: TextStyle(color: Colors.white, fontSize: 19.auto),
                ),
              )
            ],
          ),
          Container(
              margin: EdgeInsets.only(left: 10.auto, right: 10.auto, top: 15.auto),
              child: Text(
                "【${getTranslatedText("promotion_condition")}】",
                style:
                    TextStyle(color: CustomColor.theme_bar_gradient_1, fontSize: 14.auto, fontWeight: FontWeight.bold),
              )),
          Container(
            margin: EdgeInsets.only(left: 10.auto, right: 10.auto, top: 15.auto),
            child: Text("${getTranslatedText("promotion_person")}：\n VIP" + widget.promotion.vipLevels.join(", VIP")),
          ),
          Container(
            margin: EdgeInsets.only(left: 10.auto, right: 10.auto, top: 15.auto),
            child: Text("${getTranslatedText("promotion_time")}：\n " +
                Format().dateTimeFormat(widget.promotion.from) +
                " - " +
                Format().dateTimeFormat(widget.promotion.to)),
          ),
          //_buildPromotionDescriptionText(),
          _buildJoinButton()
        ],
      ),
    );
  }

  _buildAppBar() => AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: gradientDecoration,
        ),
        title: Text(
          getTranslatedText("promotion_center"),
          style: TextStyle(fontSize: 20.auto),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      );

  _buildJoinButton() => Container(
        margin: EdgeInsets.only(left: 10.auto, right: 10.auto, top: 15.auto),
        child: ColorButton(
          text: Text(
            getTranslatedText("join"),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16.auto),
          ),
          onClick: () {
            _onClick();
          },
          isEnabled: true,
          color: CustomColor.theme_bar_gradient_2,
          radius: 9.6,
        ),
      );

  _onClick() {
    if (widget.vm.userProfile == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushNamed("/login");
      });
      return;
    }
    ProgressDialog.show(context);
    widget.vm.joinPromotion(widget.promotion.id);
  }

  _getPromotionTitleName() {
    if (widget.promotion.promotionLocalization == null || widget.promotion.promotionLocalization.name.isEmpty)
      return widget.promotion.name;
    else
      return widget.promotion.promotionLocalization.name;
  }
}
