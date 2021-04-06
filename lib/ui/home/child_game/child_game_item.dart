import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/entity/game.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/home/home_view_model.dart';

class ChildGameItem extends StatefulWidget{
  final bool isFavourite;
  final Game game;

  ChildGameItem({
    this.isFavourite,
    this.game,
  });

  @override
  _ChildGameItemState createState() => _ChildGameItemState();
}

class _ChildGameItemState  extends BaseState<ChildGameItem> {
  var _vm = HomeViewModel();

  Widget build(BuildContext context) {
    return ProviderWidget<HomeViewModel>(
        model: _vm,
        builder: (ctx, vm, _) {
          _handleApiState();
          return InkWell(
            onTap: () => _getGameUrl(widget.game.gamePlatformCode, widget.game.id),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Column(
                children:[
                  Container(
                    width: (165.5).auto,
                    height: (131.1).auto,
                    color: CustomColor.grey,
                    /*child: FittedBox(
                    fit: BoxFit.fill,
                    child: Image.asset(
                        "images/promotion_1.png"
                    )
                )*/
                  ),
                  Container(
                    decoration:BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            CustomColor.theme_bar_gradient_1,
                            CustomColor.theme_bar_gradient_2
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        )
                    ),
                    padding: EdgeInsets.only(left: 10.auto, right: 10.auto, top: 5.auto),
                    child: Row(
                      children: [
                        Text(widget.game.name),
                        Spacer(),
                        InkWell(
                          onTap: (){

                          },
                          child: Image.asset(
                            widget.isFavourite?"images/child_game/ic_like.png":"images/child_game/ic_unlike.png",
                            width: 20.auto,
                            height: 20.auto,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  _getGameUrl(String gamePlatformCode, int gameId){
    _vm.getGameUrl(gamePlatformCode, gameId);
    CustomProgressDialog.show(context);
  }

  _handleApiState(){
    handleApiState(_vm.getGameUrlApiState, onSuccess: (){
      CustomToast.show(_vm.getGameUrlApiState.result.url);
    });
  }
}