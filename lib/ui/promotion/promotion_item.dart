import 'package:flutter/material.dart';
import 'package:tgp_flutter/entity/promotion.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/promotion/promotion_item_details.dart';
import 'package:tgp_flutter/ui/promotion/promotion_view_model.dart';

class PromotionItem extends StatefulWidget {
  final String imagePath;
  final Promotion promotion;
  final PromotionViewModel vm;

  PromotionItem({Key key, this.imagePath, this.promotion, this.vm}) : super(key: key);

  @override
  _PromotionItemState createState() => _PromotionItemState();
}

class _PromotionItemState extends BaseState<PromotionItem> {
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PromotionItemDetails(imagePath: widget.imagePath, promotion: widget.promotion, vm: widget.vm)));
      },
      child: Container(
        margin: EdgeInsets.only(left: 11.auto, right: 11.auto, top: 10.auto),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                "images/promotion/${widget.imagePath}.jpg",
                fit: BoxFit.fill,
              ),
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
      ),
    );
  }
}
