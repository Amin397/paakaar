import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/project_request_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'ticket_controller.dart';

class NewTicketController extends GetxController {
  final ProjectRequestUtils requests = ProjectRequestUtils();

  TextEditingController titleController = TextEditingController();
  TextEditingController messageController = TextEditingController();


  TicketController? ticketController;



  @override
  void onInit() {
    ticketController = Get.arguments['controller'];
    super.onInit();
  }

  void sendTicket() async {
    if(titleController.text != ''){
      if(messageController.text != ''){
        EasyLoading.show();
        ApiResult result = await requests.sendNewTicket(
          title: titleController.text,
          message: messageController.text,
        );
        EasyLoading.dismiss();

        if (result.isDone) {
          ViewUtils.showSuccessDialog(
            'تیکت شما با موفقیت ثبت شد',
          );
          ticketController!.getTicketData();
          // Future.delayed(const Duration(seconds: 5) , (){
          Get.back();
          Get.back();
          update();
          // });
        } else {
          ViewUtils.showErrorDialog(
            'ثبت تیکت با خطا مواجه شد',
          );
        }
      }else{
        ViewUtils.showErrorDialog(
          'برای ثبت تیکت باید متن تیکت را وارد کنید',
        );
      }
    }else{
      ViewUtils.showErrorDialog(
        'برای ثبت تیکت باید عنوان را وارد کنید',
      );
    }
  }
}
