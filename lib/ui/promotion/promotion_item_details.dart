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
              Image.asset(
                "images/promotion/${widget.imagePath}.jpg",
                fit: BoxFit.fitWidth,
              ),
              Container(
                margin: EdgeInsets.only(left: 15.auto, right: 15.auto, top: 15.auto, bottom: 15.auto),
                width: 150.auto,
                child: Text(
                  widget.promotion.name,
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

  _buildPromotionDescriptionText() {
    String description;
    switch (widget.imagePath) {
      case "promo1":
        description =
            "每日存款并完成有效投注额任务，即可领最高8，888元彩金。活动累计可获得最高96,658元彩金。活动期间如会员使用虚拟币存款，切虚拟币存款金额占当天终存款金额的50%，则每日存款彩金可获得最高25%加增";
        break;
      case "promo2":
        description = "活動期間，會員投注指定中超賽事，有效投注額滿足活動要求，即可瓜分對應彩池比例，彩池獎金888萬！保底彩金8元！僅需一倍流水即可取款！";
        break;
      case "promo3":
        description = "活動期間，會員每日投注亞博棋牌場館，有效投注額到達以下關卡檔位，即可獲得對應關卡獎勵，且闖關獎勵可以累積獲得，最高1,888元彩金。僅需一倍流水即可取款！";
        break;
      default:
        description = "活動期間，會員每日投注亞博棋牌場館，有效投注額到達以下關卡檔位，即可獲得對應關卡獎勵，且闖關獎勵可以累積獲得，最高1,888元彩金。僅需一倍流水即可取款！";
        break;
    }
    return Container(
      margin: EdgeInsets.only(left: 10.auto, right: 10.auto, top: 10.auto),
      child: Text(description),
    );
  }

  _buildJoinButton() => Container(
        margin: EdgeInsets.only(left: 10.auto, right: 10.auto, top: 15.auto),
        child: ColorButton(
          text: Text(
            "Join",
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
}
