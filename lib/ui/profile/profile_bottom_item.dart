import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/ui/transaction/transaction.dart';


class ProfileBottomItem extends StatefulWidget{
  final String title;
  final String imagePath;
  final String routePath;
  final int navigationID;

  ProfileBottomItem({Key key,
    this.title,
    this.imagePath,
    this.routePath,
    this.navigationID
  }) : super(key: key);
  @override
  _ProfileBottomItemState createState() => _ProfileBottomItemState();
}

class _ProfileBottomItemState extends BaseState<ProfileBottomItem> {
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if(widget.navigationID==0){
            Navigator.of(context).pushNamed("/${widget.routePath}");
          }
          else{
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Transaction(
                          tabIndex: widget.navigationID,
                        )
                ));
          }
        });
      },
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.9),
        ),
        elevation: 5,
        child: Container(
          //margin: EdgeInsets.symmetric(vertical: 13,horizontal: 10),
          margin: EdgeInsets.only(left: 5.auto, right: 5.auto, top: 10.auto, bottom: 5.auto),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageIcon(
                AssetImage("images/profile/${widget.imagePath}.png"),
                size: 27.auto,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.auto),
                child: AutoSizeText(
                  widget.title,
                  style: TextStyle(
                      fontSize: 10
                  ),
                  textAlign: TextAlign.center,
                  minFontSize: 5,
                  stepGranularity: 1,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
