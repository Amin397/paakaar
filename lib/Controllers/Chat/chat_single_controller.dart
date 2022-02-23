import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Models/Auth/user.dart';
import 'package:paakaar/Models/Chat/chat_model.dart';
import 'package:paakaar/Models/Chat/messages_model.dart';
import 'package:paakaar/Pages/Chat/Widgets/delete_message_widget.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/project_request_utils.dart';
import 'package:paakaar/Utils/alert_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';

class ChatSingleController extends GetxController {
  myMessage() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // RemoteNotification? notification = message.notification;
      if (message is RemoteMessage) {
        startChat();
        // Get.snackbar(
        //   message.notification?.title ?? '',
        //   message.notification?.body ?? '',
        //   backgroundColor: Colors.white.withOpacity(0.9),
        // );
        // startChat();

        // chat.messages.add(MessageModel(id: id, title: title, sender: sender, receiver: receiver, isRead: isRead, timestamp: timestamp, time: time))
      }
    });
  }

  void startChat() async {
    ApiResult result = await ProjectRequestUtils.instance.startChat(
      targetId: chat.user.id!,
    );
    if (result.isDone) {
      print(result.data);
      chat = ChatModel.fromJson(result.data);
      scrollController.animateTo(
        scrollController.position.maxScrollExtent + 50.0,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeIn,
      );
      update();
    } else {
      ViewUtils.showErrorDialog(
        result.data,
      );
    }
  }

  late ChatModel chat;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController messageTextController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  int numLines = 0;

  @override
  void onInit() {
    myMessage();
    chat = Get.arguments['chat'];
    startChat();
    // sendMessage();
    Future.delayed(const Duration(milliseconds: 150), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent + 50.0,
        duration: const Duration(milliseconds: 275),
        curve: Curves.easeIn,
      );
    });
    super.onInit();
  }

  void sendMessage() async {
    chat.messages.add(
      MessageModel(
        id: 0,
        title: messageTextController.text,
        sender: Globals.userStream.user!.id!,
        receiver: chat.user.id!,
        isRead: false,
        timestamp: DateTime.now(),
        time: "${DateTime.now().hour}:${DateTime.now().minute}",
      ),
    );
    scrollController.animateTo(
      scrollController.position.maxScrollExtent + 50.0,
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeIn,
    );
    update();
    messageTextController.clear();
    Focus.of(Get.context!).requestFocus(
      FocusNode(),
    );
    ApiResult result = await ProjectRequestUtils.instance.sendMessage(
      chat.messages.last,
    );
    if (result.isDone) {
      chat.messages.last.id = result.data;
    } else {
      ViewUtils.showErrorDialog(
        result.data.toString(),
      );
      chat.messages.removeLast();
    }
    update();
  }

  void unFocus() {
    Focus.of(Get.context!).requestFocus(FocusNode());
  }

  void deleteMessageAlert({MessageModel? message, UserModel? user}) async {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        content: DeleteMessage(
          controller: this,
          messageId: message,
        ),
      ),
    );
  }

  void deleteMessage({MessageModel? message}) async {
    ApiResult result = await ProjectRequestUtils.instance
        .deleteMessage(id: message!.id.toString());
    if (result.isDone) {
      unFocus();
      chat.messages.remove(message);
      update();
    } else {}
  }
}
