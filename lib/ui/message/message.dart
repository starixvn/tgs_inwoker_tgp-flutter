import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';

import 'message_item.dart';

class Message extends StatefulWidget{
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends BaseState<Message> {
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            MessageItem(
              title: "活动名称",
              text: "活动内容活动内容活动内容活动内容活动内容活动内容活动内容活动内容活动内容活动内容",
              date: "YYYY-MM-DD",
              isEditing: isEditing,
              isSelected: isSelected,
              onChanged: (){
                setState(() {
                  isSelected = ! isSelected;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

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


