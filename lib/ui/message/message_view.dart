import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tgp_flutter/custom/custom_progress_dialog.dart';
import 'package:tgp_flutter/entity/message.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/src/custom_color.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/message/message_view_model.dart';

import 'message_item.dart';

class MessageView extends StatefulWidget {
  @override
  _MessageViewState createState() => _MessageViewState();
}

class _MessageViewState extends BaseState<MessageView> {
  var isEditing = false, isSelected = false, isLoading = false;
  var _vm = MessageViewModel();
  List<String> selectedMessageList = [];
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ProgressDialog.show(context);
      _vm.getMessageList();
    });
    _controller.addListener(_scrollListener);
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
              title: Text(
                getTranslatedText("message_center"),
                style: TextStyle(fontSize: 16.auto),
              ),
              actions: [
                Visibility(
                  visible: _vm.messageList != null && _vm.messageList.isNotEmpty,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isEditing = !isEditing;
                        selectedMessageList = [];
                      });
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 15.auto),
                        alignment: Alignment.center,
                        child: Text(
                          isEditing ? getTranslatedText("cancel") : getTranslatedText("edit"),
                          style: TextStyle(fontSize: 12.auto),
                        )),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: _buildBottomNavigationBar(),
            body: _vm.messageList == null
                ? Container()
                : ListView(controller: _controller, padding: EdgeInsets.all(8.0), children: [
                    Column(
                      children: List.generate(_vm.messageList.length, (index) {
                        return MessageItem(
                            message: _vm.messageList[index],
                            isEditing: isEditing,
                            onSelected: (message) => _onSelected(message),
                            onReadMessage: (id) {
                              //ProgressDialog.show(context);
                              _vm.readMessage([id]); //call api silently
                            },
                            selectedMessageList: selectedMessageList ?? []);
                      }),
                    ),
                    Visibility(
                        visible: _vm.endRecord?false:isLoading,
                        child: Container(alignment: Alignment.center, child: CircularProgressIndicator())),
                    Visibility(
                        visible: _vm.endRecord && _vm.messageList.isNotEmpty,
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(bottom: 10.auto),
                          child: Text(
                            getTranslatedText("no_more"),
                            style: TextStyle(fontSize: 12.auto, color: CustomColor.grey),
                          ),
                        ))
                  ]),
          );
        });
  }

  _buildBottomNavigationBar() => Visibility(
        visible: !(selectedMessageList == null || selectedMessageList.isEmpty),
        child: BottomAppBar(
            color: CustomColor.theme_button_disable_bg,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    ProgressDialog.show(context);
                    _vm.readMessage(selectedMessageList);
                    setState(() {
                      selectedMessageList = [];
                      isEditing = false;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 10.auto, bottom: 10.auto, left: 15.auto),
                    child: Text(
                      getTranslatedText("mark_as_read"),
                      style: TextStyle(color: Colors.white, fontSize: 12.auto),
                    ),
                  ),
                ),
                /*InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.only(top: 10.auto, bottom: 10.auto, right: 15.auto),
                    child: Text(
                      getTranslatedText("delete"),
                      style: TextStyle(color: Colors.white, fontSize: 12.auto),
                    ),
                  ),
                ),*/
              ],
            )),
      );

  _onSelected(Message _selectedMessage) {
    setState(() {
      isSelected = !isSelected;
      if (isSelected)
        selectedMessageList.add(_selectedMessage.id);
      else {
        selectedMessageList.removeWhere((element) => element == _selectedMessage.id);
      }
    });
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
      });
      _vm.getMessageList(isLoadMore: true);
    }
  }

  _handleApiState() {
    handleApiState(_vm.getMessageListApiState, onSuccess: () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if(isLoading){
          setState(() {
            isLoading = false;
          });
        }
      });
    });
    handleApiState(_vm.readMessageApiState, onSuccess: () {});
  }
}
