import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:tgp_flutter/custom/color_button.dart';
import 'package:tgp_flutter/custom/custom_dialog.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/entity/promotion.dart';
import 'package:tgp_flutter/extension/format.dart';
import 'package:tgp_flutter/localizations/language_provider.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/route_path.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/home/home.dart';
import 'package:tgp_flutter/ui/promotion/promotion_item.dart';
import 'package:tgp_flutter/ui/promotion/promotion_view_model.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:html/parser.dart';

class PromotionItemDetails extends StatefulWidget {
  final String imagePath;
  final Promotion promotion;
  final PromotionViewModel vm;

  PromotionItemDetails({
    required this.imagePath,
    required this.promotion,
    required this.vm,
  });

  @override
  _PromotionItemDetailsState createState() => _PromotionItemDetailsState();
}

class _PromotionItemDetailsState extends BaseState<PromotionItemDetails> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: ListView(
        children: [
          _buildPromotionImage(),
          Container(
              margin: EdgeInsets.only(left: 10.auto, right: 10.auto, top: 15.auto),
              child: Text(
                "【${getTranslatedText("promotion_condition")}】",
                style:
                    TextStyle(color: CustomColor.theme_bar_gradient_1, fontSize: 14.auto, fontWeight: FontWeight.bold),
              )),
          _buildPromotionText(
              "${getTranslatedText("promotion_person")}：\n VIP" + (widget.promotion.vipLevels ?? []).join(", VIP")),
          _buildPromotionText("${getTranslatedText("promotion_time")}：\n " +
              Format().dateTimeFormat(widget.promotion.from) +
              " - " +
              Format().dateTimeFormat(widget.promotion.to)),
          _buildPromotionContentText(
              parseHtmlString(widget.promotion.localization?.content ?? widget.promotion.content ?? "")),
          _buildPromotionTermsText(widget.promotion.terms),
          _buildJoinButton()
        ],
      ),
    );
  }

  _replace(String text) {
    return text.replaceAll("\n", "").replaceAll("\\", "");
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
        margin: EdgeInsets.only(left: 10.auto, right: 10.auto, top: 15.auto, bottom: 20.auto),
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

  _buildPromotionImage() {
    var imageUrl = (widget.promotion.localization?.mobileBanner) ?? widget.promotion.mobileBanner;
    return imageUrl == null || imageUrl.isEmpty
        ? Container()
        : CachedNetworkImage(
            height: 150.auto,
            placeholder: (context, url) => Container(
                  color: CustomColor.very_light_pink_four,
                ),
            imageUrl: imageUrl,
            //handling error
            errorWidget: (context, url, error) => Container(
                  color: CustomColor.very_light_pink_four,
                ),
            fit: BoxFit.fill);
  }

  _onClick() {
    if (widget.vm.userProfile == null) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Navigator.of(context).pushNamed("/login");
      });
      return;
    } else {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Navigator.of(context).pushNamed(RoutePath.deposit);
      });
    }
  }

  _buildPromotionText(String displayText) => Container(
        margin: EdgeInsets.only(left: 10.auto, right: 10.auto, top: 15.auto),
        child: Text(displayText),
      );

  _buildPromotionContentText(String? displayText) => Container(
        margin: EdgeInsets.only(left: 10.auto, right: 10.auto, top: 15.auto),
        child: Text(
          displayText ?? "",
          style: TextStyle(color: CustomColor.theme_bar_gradient_1),
        ),
      );

  _buildPromotionTermsText(String? displayText) => Container(
        margin: EdgeInsets.only(left: 10.auto, right: 10.auto, top: 15.auto),
        child: RichText(
            text: HTML.toTextSpan(
          context,
          displayText ?? "",
          defaultTextStyle: TextStyle(fontSize: 12.auto),
          overrideStyle: <String, TextStyle>{
            'p': TextStyle(fontSize: 15.auto),
            'span': TextStyle(fontSize: 15.auto),
          },
        )),
      );
}
