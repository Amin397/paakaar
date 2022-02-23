import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:frefresh/frefresh.dart';
import 'package:paakaar/Pages/Ticket/Model/ticket_room_model.dart';
import 'package:paakaar/Pages/Ticket/View/close_ticket_alert.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/project_request_utils.dart';
import 'package:paakaar/Utils/routing_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';

class TicketController extends GetxController {
  final ProjectRequestUtils requests = ProjectRequestUtils();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final FRefreshController expertsRefreshController = FRefreshController();

  List<TicketRoomModel> ticketsRoomList = [];
  RxBool isLoaded = false.obs;

  void unFocus() {
    Focus.of(Get.context!).requestFocus(FocusNode());
  }


  myMessage() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // RemoteNotification? notification = message.notification;
      if (message is RemoteMessage) {
        // startChat();
        getTicketData();
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




  @override
  void onInit() {
    myMessage();
    getTicketData();
    super.onInit();
  }

  getTicketData() async {
    ticketsRoomList.clear();
    ApiResult result = await requests.getTicketsRoom();
    for (var o in result.data) {
      ticketsRoomList.insert(0, TicketRoomModel.fromJson(o));
    }
    update();
    isLoaded.value = true;
  }

  void closeTicket({TicketRoomModel? model}) async {
    EasyLoading.show();
    ApiResult result =
        await requests.closeTicketMessage(id: model!.id.toString());
    EasyLoading.dismiss();
    if (result.isDone) {
      model.isClosed = 1;
      ViewUtils.showSuccessDialog(
        'تیکت شما باموفقیت بسته شد',
      );
      update();
    } else {
      ViewUtils.showErrorDialog(
        'بستن تیکت با خطا مواجه شد',
      );
    }
  }

  void deleteMessageAlert({TicketRoomModel? model}) async {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        content: CloseTicketAlert(
          controller: this,
          model: model,
        ),
      ),
    );
  }

  void deleteTicket({TicketRoomModel? model}) async {
    // Get.back();
    EasyLoading.show();
    ApiResult result =
        await requests.deleteTicketRoom(id: model!.id.toString());
    EasyLoading.dismiss();
    if (result.isDone) {
      ticketsRoomList.remove(model);
      ViewUtils.showSuccessDialog(
        'تیکت روم شما با موفقیت حذف شد',
      );
      update();
    } else {
      ViewUtils.showErrorDialog(
        'خطایی رخ داد',
      );
    }
  }
}
