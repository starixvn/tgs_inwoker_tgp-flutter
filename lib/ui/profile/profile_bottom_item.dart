import 'package:animated_widgets/widgets/opacity_animated.dart';
import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:animated_widgets/widgets/size_animated.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/extension/navigate_without_animation.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/transaction/transaction.dart';

import 'animated_dot.dart';

class ProfileBottomItem extends StatefulWidget {
  final String title;
  final String imagePath;
  final Widget route;
  final bool isMessage;

  ProfileBottomItem({Key key, this.title, this.imagePath, this.route, this.isMessage})
      : super(key: key);

  @override
  _ProfileBottomItemState createState() => _ProfileBottomItemState();
}

class _ProfileBottomItemState extends BaseState<ProfileBottomItem> with TickerProviderStateMixin {
  int _count = 0;

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _navigate(),
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.9),
        ),
        elevation: 5,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              //margin: EdgeInsets.symmetric(vertical: 13,horizontal: 10),
              margin: EdgeInsets.only(left: 5.auto, right: 5.auto, top: 10.auto, bottom: 5.auto),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [_buildImageIcon(), _buildProfileBottomItemText()],
              ),
            ),
            Visibility(visible: widget.isMessage, child: _buildNotification()),
          ],
        ),
      ),
    );
  }

  _buildImageIcon() => ImageIcon(
        AssetImage("images/profile/${widget.imagePath}.png"),
        size: 27.auto,
      );

  _buildProfileBottomItemText() => Container(
        padding: EdgeInsets.only(top: 10.auto),
        child: AutoSizeText(
          widget.title,
          style: TextStyle(fontSize: 10),
          textAlign: TextAlign.center,
          minFontSize: 5,
          stepGranularity: 1,
          maxLines: 1,
        ),
      );

  _navigate() => WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).push(NavigateWithoutAnimation(widget: widget.route));
      });

  _buildNotification() => Positioned(top: 15, right: 20, child: AnimatedDot());
}
