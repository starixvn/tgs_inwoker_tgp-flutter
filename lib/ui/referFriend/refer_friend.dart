import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';

class ReferFriend extends StatefulWidget{
  @override
  _ReferFriendState createState() => _ReferFriendState();
}

class _ReferFriendState extends BaseState<ReferFriend> {
  var isEditing = false, isSelected = false;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: gradientDecoration,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("消息中心",
          style: TextStyle(fontSize: 16.auto),
        ),
        actions: [
          InkWell(
            onTap: (){
              setState(() {
                isEditing = !isEditing;
              });
            },
            child: Container(
                margin: EdgeInsets.only(right: 15.auto),
                alignment: Alignment.center,
                child: Text(
                  isEditing?"取消":"编辑",
                  style: TextStyle(fontSize: 12.auto),
                )
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 120.auto,
              width: 120.auto,
              color: CustomColor.theme_bar_gradient_1,
            ),
            _buildReferIdText(),
          ],
        ),
      ),
    );
  }

  _buildReferIdText() => Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
            width: 1,
            color: CustomColor.theme_button_disable_bg
        )
    ),
    padding: EdgeInsets.only(
      left: 10.auto,
      right: 5.auto,
      top: 10.auto,
      bottom: 10.auto,
    ),
    margin: EdgeInsets.only(top: 20.auto),
    child: Row(
      children: [
        Container(
          margin:EdgeInsets.only(
              right: 10.auto
          ),
          child: Text(
            "My Refer ID",
            style: TextStyle(
                color: CustomColor.theme_button_disable_bg,
                fontSize: 16.auto
            ),
          ),
        ),
        Text(
          "m1189",
          style: TextStyle(
              color: CustomColor.theme_bar_gradient_2,
              fontSize: 16.auto
          ),
        )
      ],
    ),
  );

  _buildIdLink() => Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
            width: 1,
            color: CustomColor.theme_button_disable_bg
        )
    ),
    padding: EdgeInsets.only(
      left: 10.auto,
      right: 5.auto,
      top: 10.auto,
      bottom: 10.auto,
    ),
    margin: EdgeInsets.only(top: 20.auto),
    child: Row(
      children: [
        Container(
          margin:EdgeInsets.only(
              right: 10.auto
          ),
          child: Text(
            "My Refer ID",
            style: TextStyle(
                color: CustomColor.theme_button_disable_bg,
                fontSize: 16.auto
            ),
          ),
        ),
        Text(
          "m1189",
          style: TextStyle(
              color: CustomColor.theme_bar_gradient_2,
              fontSize: 16.auto
          ),
        )
      ],
    ),
  );

  _buildBottomNavigationBar() => Visibility(
    visible: isSelected,
    child: BottomAppBar(
        color: CustomColor.theme_button_disable_bg,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: (){

              },
              child: Container(
                padding: EdgeInsets.only(top: 10.auto, bottom: 10.auto, left: 15.auto),
                child: Text(
                  "标示已读",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.auto
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: (){

              },
              child: Container(
                padding: EdgeInsets.only(top: 10.auto, bottom: 10.auto, right: 15.auto),
                child: Text(
                  "删除",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.auto
                  ),
                ),
              ),
            ),
          ],
        )
    ),
  );
}


