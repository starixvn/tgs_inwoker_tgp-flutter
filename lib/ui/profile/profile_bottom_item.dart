import 'package:flutter/material.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/custom/custom_toast.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';


class ProfileBottomItem extends StatefulWidget{
  final String title;
  final String imagePath;
  final String routePath;

  ProfileBottomItem({Key key,
    this.title,
    this.imagePath,
    this.routePath,
  }) : super(key: key);
  @override
  _ProfileBottomItemState createState() => _ProfileBottomItemState();
}

class _ProfileBottomItemState extends State<ProfileBottomItem> {
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        /*WidgetsBinding.instance.addPostFrameCallback((_) {
        if(isBetTransaction){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Transaction(
                        tabIndex: 1,
                      )
              ));
        }
        else{
          Navigator.of(context).pushNamed("/$routePath");
        }
      });*/
      },
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: Container(
          //margin: EdgeInsets.symmetric(vertical: 13,horizontal: 10),
          margin: EdgeInsets.only(left: 10.auto, right: 10.auto, top: 15.auto),
          child: Column(
            children: [
              ImageIcon(
              AssetImage("images/profile/${widget.imagePath}.png"),
                size: 27.auto,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.auto),
                child: Text(widget.title,
                  style: TextStyle(
                      fontSize: 11.auto
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
