import 'package:flutter/material.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';

class CustomDialog extends StatelessWidget{
  final String title, description, buttonText1, buttonText2;
  final Function onClick;

  CustomDialog({
    this.title,
    this.description,
    this.buttonText1,
    this.buttonText2,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context){
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: context.screenHeight/30,
            horizontal: context.screenWidth/20,
          ),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child:Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              title ==null?
              Container():
              Container(
                padding: EdgeInsets.only(bottom: 13.auto, left: 10.auto),
                alignment: Alignment.topLeft,
                child:Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.auto,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 20.auto, left: 10.auto, right: 10.auto),
                alignment: Alignment.topLeft,
                child: Text(
                  description,
                  style: TextStyle(
                    fontSize: 13.auto,
                    color: Colors.black54,
                  ),
                ),
              ),
              buttonText2 ==null?
              _buildDoneButton(context) :
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDoneButton(context),
                  _buildBackButton(context)
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  _buildDoneButton(BuildContext context) => FlatButton(
    minWidth:context.screenWidth/ 3.5,
    height:context.screenHeight / 15,
    onPressed: () => {
      this.onClick()
    },
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(45)),
    padding: EdgeInsets.all(0.0),
    child: Ink(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffebce91),
              Color(0xffdcb370),
              Color(0xffc59f62),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.all(Radius.circular(45))),
      child: Container(
        constraints:
        BoxConstraints(
          maxWidth: context.screenWidth / 3.5,
          maxHeight: context.screenHeight/ 15,
        ),
        alignment: Alignment.center,
        child: Text(
          buttonText1,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black),
        ),
      ),
    ),
  );

  _buildBackButton(BuildContext context) =>FlatButton(
    minWidth: context.screenWidth / 3.5,
    height:  context.screenHeight / 15,
    //padding: EdgeInsets.all(12),
    onPressed: ()  {
      Navigator.pop(context);
    },
    child: Text(buttonText2?? "uyy"),
    textColor: Colors.red,
    shape: RoundedRectangleBorder(
      side: BorderSide(
          color: Colors.red,
          width: 1.0
      ),
      borderRadius: BorderRadius.all(Radius.circular(45)),
    ),
    color: Colors.white,
  );
}