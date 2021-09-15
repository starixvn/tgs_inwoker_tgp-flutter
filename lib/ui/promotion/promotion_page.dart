import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:tgp_flutter/custom/custom_dialog.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/localizations/language_provider.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/home/home.dart';
import 'package:tgp_flutter/ui/promotion/promotion_item.dart';
import 'package:tgp_flutter/ui/promotion/promotion_view_model.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';

class PromotionPage extends StatefulWidget {
  @override
  _PromotionState createState() => _PromotionState();
}

class _PromotionState extends BaseState<PromotionPage> {
  var height, width, ratio;
  var currentTabIndex = 0;
  var currentBottomIndex = 1;
  PromotionViewModel _vm = PromotionViewModel();
  BuildContext key = GlobalKey().currentContext;

  @override
  void initState() {
    super.initState();
    _vm.getPromotionList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return ProviderWidget<PromotionViewModel>(
        model: _vm,
        builder: (ctx, vm, _) {
          _handleApiState();
          return Scaffold(appBar: _buildAppBar(), body: _buildPromotion());
        });
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

  _buildPromotion() {
    if (_vm.promotionList == null)
      return buildProgressDialog(_vm.brandLogoUrl);
    else if (_vm.promotionList.isEmpty) {
      return Container(
        margin: EdgeInsets.only(left: 11.auto, right: 11.auto, top: 10.auto),
        height: 150.auto,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                child: Image.asset(
                  "images/promotion/promo_empty.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(
                  left: 15.auto,
                  right: 15.auto,
                ),
                width: context.screenWidth / 2.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GradientText(
                      getTranslatedText("promotion_empty1"),
                      style: TextStyle(fontSize: context.screenWidth / 25, fontWeight: FontWeight.bold),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff446597),
                          Color(0xff282828),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    GradientText(
                      getTranslatedText("promotion_empty2"),
                      //getTranslatedText("promotion_empty"),
                      style: TextStyle(fontSize: context.screenWidth / 25, fontWeight: FontWeight.bold),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff446597),
                          Color(0xff282828),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ))
          ],
        ),
      );
    } else {
      return ListView(
        padding: EdgeInsets.only(bottom: 10.auto),
        children: List.generate(_vm.promotionList.length, (index) {
          return PromotionItem(
              imagePath: "promotion_BN_${(index % 3 + 1).toString()}", promotion: _vm.promotionList[index], vm: _vm);
        }),
      );
    }
  }

  _handleApiState() {
    handleApiState(_vm.joinPromotionApiState, onSuccess: () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (BuildContext context) => CustomDialog(
            title: null,
            description: getTranslatedText("join_success"),
            buttonText1: getTranslatedText("confirm"),
            onClick: () {
              Navigator.pop(
                context,
              );
              Navigator.pop(
                context,
              );
            },
            onClick2: () {},
          ),
        );
      });
    }, onError: (errorMsg) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (BuildContext context) => CustomDialog(
            title: null,
            description: getTranslatedText("promotion_joined"),
            buttonText1: getTranslatedText("confirm"),
            onClick: () {
              Navigator.pop(
                context,
              );
              Navigator.pop(
                context,
              );
            },
            onClick2: () {},
          ),
        );
      });
    });
    handleApiState(_vm.getPromotionListApiState, onSuccess: () {});
  }
}
