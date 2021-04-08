import 'package:flutter/material.dart';
import 'package:tgp_flutter/entity/game.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/home/child_game/child_game.dart';
import 'package:tgp_flutter/ui/home/home_view_model.dart';

class GameContent extends StatefulWidget {
  final ScrollController controller;
  final List<List<Game>> list;
  final Function onClick;

  GameContent({
    @required
    this.controller,
    this.list,
    this.onClick
  });

  @override
  _GameContentState createState() => _GameContentState();
}

class _GameContentState extends BaseState<GameContent> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(right:5.auto,),
        decoration: BoxDecoration(
            color: CustomColor.very_light_pink_four,
            borderRadius: BorderRadius.circular(5.auto)
        ),
        child: RawScrollbar(
          isAlwaysShown: true,
          thumbColor: CustomColor.theme_bar_gradient_2,
          thickness: 3.5,
          radius: Radius.circular(1.4),
          controller: widget.controller,
          child: ListView(
              padding: EdgeInsets.only(right: 5.auto),
              controller: widget.controller,
              children: widget.list.expand((element) => element).toList().asMap().entries.map((item) => Container(
                  padding: EdgeInsets.only(left: (8.5).auto, right: 5.auto, top: (12.5).auto, bottom: 5.auto),
                  child: GestureDetector(
                      onTap: (){
                        widget.onClick(item.value.gamePlatformCode, item.value.id);
                      },
                      child:/*AspectRatio(
                      aspectRatio: 335/90,
                      child: Image.asset(
                        'images/game/$item',
                      ),
                    ),
                           */ Container(
                          width: 335.auto,
                          height: 90.auto,
                          color: Colors.blue,
                          alignment: Alignment.center,
                          child:Text(
                            item.value.name+" / "+item.key.toString(),
                          )
                      )
                  )
              )).toList()
          ),
        ),
      ),
    );
  }

  _navigateToChildGame( int gameType){
    var code = gameType<4?"SBO":"HABA";
   // _vm.getGameList(code, gameType);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ChildGame(
                    gamePlatformCode: code,
                    gameType: gameType,
                  )
          ));
    });
  }

}