import 'package:flutter/material.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/base_state.dart';

class PromotionItem extends StatefulWidget {
  final String imagePath;

  PromotionItem({
    Key key,
    this.imagePath,
  }) : super(key: key);

  @override
  _PromotionItemState createState() => _PromotionItemState();
}

class _PromotionItemState extends BaseState<PromotionItem> {
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildPromotionImage(),
        _buildPromotionTag(),
        _buildPromotionText(),
      ],
    );
  }

  _buildPromotionImage() => Container(
        margin: EdgeInsets.only(left: 11.auto, right: 11.auto, top: 10.auto),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            widget.imagePath,
            fit: BoxFit.fill,
          ),
        ),
      );

  _buildPromotionTag() => Positioned(
        top: 10,
        left: 3,
        child: Container(
          child: Image.asset(
            "images/promotion/ic_promotion_tag_refer.png",
            height: 31.auto,
          ),
        ),
      );

  _buildPromotionText() => Positioned(
        bottom: 0,
        child: Container(
            width: context.screenWidth - 20.auto,
            margin: EdgeInsets.only(left: 10.auto, right: 10.auto),
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              color: CustomColor.theme_bar_gradient_2.withOpacity(0.85),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: Text(
              "欢迎优惠",
              style: TextStyle(color: Colors.white, fontSize: (12.5).auto),
            )),
      );
}
