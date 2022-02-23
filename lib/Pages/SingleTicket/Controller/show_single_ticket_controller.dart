import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shamsi_date/extensions.dart';
import 'package:paakaar/Pages/Ticket/Model/ticket_room_model.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/project_request_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';

class ShowSingleTicketController extends GetxController {
  final ProjectRequestUtils requests = ProjectRequestUtils();

  TicketRoomModel? model;

  TextEditingController ticketTextController = TextEditingController();

  ScrollController? scrollController;


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

  getTicketData() async {
    ApiResult result = await requests.getTicketsRoom();
    for (var o in result.data) {
      if(TicketRoomModel.fromJson(o).id == model!.id){
        model = TicketRoomModel.fromJson(o);

      }
    }
    update();
    scrollController!.animateTo(
      scrollController!.position.maxScrollExtent + 50.0,
      duration: const Duration(milliseconds: 275),
      curve: Curves.easeIn,
    );
    // isLoaded.value = true;
  }




  @override
  void onInit() {
    myMessage();
    model = Get.arguments['model'];
    scrollController = ScrollController(initialScrollOffset: 0.0);
    Future.delayed(const Duration(milliseconds: 300) , (){
      goToBottom();
    });
    super.onInit();
  }

  void unFocus() {
    Focus.of(Get.context!).requestFocus(FocusNode());
  }

  sendMessage() async {
    DateTime dt = DateTime.now();
    Jalali j = dt.toJalali();
    unFocus();
    print(ticketTextController.text);


    EasyLoading.show();
    ApiResult result = await requests.sendAnswerTicket(
      ticketMessage: ticketTextController.text,
      id: model!.id.toString(),
    );
    EasyLoading.dismiss();
    if (result.isDone) {
      model!.message!.add(
        Message(
          message: ticketTextController.text,
          byAdmin: false,
          date: j.year.toString() + '/' + j.month.toString() + '/' + j.day.toString() ,
        ),
      );
      ticketTextController.text = '';
      goToBottom();
      update();
    } else {
      ViewUtils.showErrorDialog(
        'ارسال تیکت با خطا مواجه شد',
      );
    }
  }

  void goToBottom() {
    scrollController!.animateTo(scrollController!.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }
}
