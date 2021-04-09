import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tgp_flutter/entity/message.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/message/message_view_model.dart';

import 'message_item.dart';

class MessageView extends StatefulWidget{
  @override
  _MessageViewState createState() => _MessageViewState();
}

class _MessageViewState extends BaseState<MessageView> {
  var isEditing = false, isSelected = false;
  var _vm = MessageViewModel();
  var messageList;
  List<Message> selectedMessageList = [];

  @override
  void initState() {
    _vm.getMessageList();
    super.initState();
  }

  Widget build(BuildContext context) {
    return ProviderWidget<MessageViewModel>(
        model: _vm,
        builder: (ctx, vm, _) {
          _handleApiState();
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
              title: Text(getTranslatedText("message_center"),
                style: TextStyle(fontSize: 16.auto),
              ),
              actions: [
                InkWell(
                  onTap: () {
                    setState(() {
                      isEditing = !isEditing;
                    });
                  },
                  child: Container(
                      margin: EdgeInsets.only(right: 15.auto),
                      alignment: Alignment.center,
                      child: Text(
                        isEditing ? "取消" : "编辑",
                        style: TextStyle(fontSize: 12.auto),
                      )
                  ),
                ),
              ],
            ),
            bottomNavigationBar: _buildBottomNavigationBar(),
            body: _vm.messageList ==null
                ?Center(child: CircularProgressIndicator(),)
                :Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: List.generate(_vm.messageList.length, (index) {
                  return Container(
                    child: MessageItem(
                      message: _vm.messageList[index],
                      isEditing: isEditing,
                      onSelected: (isSelected, message) => _onSelected(isSelected, message),
                    ),
                  );
                }),
              ),
            ),
          );
        });
  }

  _buildBottomNavigationBar() => Visibility(
    visible: !(selectedMessageList==null|| selectedMessageList.isEmpty),
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

  _onSelected(bool isSelected, Message _selectedMessage){
    setState(() {
      if(isSelected) selectedMessageList.add(_selectedMessage);
      else {
        selectedMessageList.removeWhere((element) => element.id == _selectedMessage.id);
      }
      print(selectedMessageList);
    });
  }

  _handleApiState(){
    handleApiState(_vm.getMessageListApiState, isAutoHideLoading: false, onSuccess:(){
    });
  }
}


