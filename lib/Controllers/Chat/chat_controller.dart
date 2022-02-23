import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frefresh/frefresh.dart';
import 'package:paakaar/Models/Auth/user.dart';
import 'package:paakaar/Models/Chat/chat_model.dart';
import 'package:paakaar/Pages/Chat/Widgets/delete_message_widget.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/project_request_utils.dart';

class ChatController extends GetxController {
  late List<ChatModel> listOfChats;
  RxBool isChatsLoaded = false.obs;
  final FRefreshController refreshController = new FRefreshController();

  final TextEditingController searchController = new TextEditingController();

  Timer? timer;

  void unFocus() {
    Focus.of(Get.context!).requestFocus(FocusNode());
  }


  void deleteMessageAlert({ChatModel? user}) async {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        content: DeleteMessage(
          controller: this,
          chat: user,
        ),
      ),
    );
  }

  Future<void> getChats() async {
    // this.isChatsLoaded.value = false;
    ApiResult result = await ProjectRequestUtils.instance.allMessages();
    if (result.isDone) {
      this.listOfChats = ChatModel.listFromJson(
        result.data,
      );
      this.isChatsLoaded.value = false;
      this.isChatsLoaded.value = true;
    }
  }

  @override
  void onInit() {
    this.getChats();
    this.setTimer();
    super.onInit();
  }

  @override
  void onClose() {
    this.timer?.cancel();
    super.onClose();
  }

  void setTimer() {
    this.timer = Timer.periodic(Duration(minutes: 5), (timer) {
      this.getChats();
    });
  }



  void deleteChat({ChatModel? userId}) async {
    ApiResult result = await ProjectRequestUtils.instance.deleteChat(
      id: userId!.user.id.toString(),
    );
    if (result.isDone) {
      unFocus();
      listOfChats.remove(userId);
      update();
    } else {}
  }
}
