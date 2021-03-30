import 'package:flutter/material.dart';
import 'package:tgp_flutter/entity/user_profile.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/ui/base_state.dart';

class GameContent extends StatefulWidget {
  final ScrollController controller;
  final List<List< String>> list;

  GameContent({
    @required
    this.controller,
    this.list
  });

  @override
  _GameContentState createState() => _GameContentState();
}

class _GameContentState extends BaseState<GameContent> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(right:5.auto, bottom: 5.auto),
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
              children: widget.list.expand((element) => element).toList().map((item) => Container(
                  padding: EdgeInsets.only(left: (8.5).auto, right: 5.auto, top: (12.5).auto, bottom: 5.auto),
                  child: GestureDetector(
                    onTap: () => _navigateToChildGame(),
                    child:AspectRatio(
                      aspectRatio: 335/90,
                      child: Image.asset(
                        'images/game/$item',
                      ),
                    ),
                  )
              )).toList()
          ),
        ),
      ),
    );
  }

  _navigateToChildGame(){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushNamed("/child_game");
    });
  }
}