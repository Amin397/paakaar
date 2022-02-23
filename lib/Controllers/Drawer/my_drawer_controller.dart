import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:paakaar/Controllers/MainPage/dashboard_controller.dart';
import 'package:paakaar/Controllers/Services/show_alert_modal/show_call_out_alert.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/project_request_utils.dart';
import 'package:paakaar/Utils/routing_utils.dart';

class MyDrawerController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final ProjectRequestUtils requests = ProjectRequestUtils();

  DashboardController dashboardController = Get.find();

  void getCanAddAdd() async {
    EasyLoading.show();
    ApiResult result = await requests.getCanAddAd();
    EasyLoading.dismiss();
    if (result.isDone) {
      if (result.data is int) {
        if (result.data == 0) {
          deleteMessageAlert(
            message: 'با توجه به درجه عضویت شما امکان ثبت آگهی رایگان دارید',
            id: 0,
            ad: true,
          );
        } else {
          deleteMessageAlert(
            message:
                '  تعداد آگهی های رایگان شما به پایان رسیده و برای ثبت آگهی جدید باید ' +
                    result.data.toString() +
                    ' تومان پرداخت کنید',
            id: 1,
            ad: true,
          );
        }
      } else {
        deleteMessageAlert(
          message:
              'متاسفانه شما به علت اتمام تعداد آگهی های رایگان و غیر رایگان امکان ثبت آگهی ندارید',
          id: 2,
          ad: true,
        );
      }
    }
  }


  void getCanAddCall() async {
    EasyLoading.show();
    ApiResult result = await requests.getCanAddCall();
    EasyLoading.dismiss();
    if (result.isDone) {
      if (result.data is int) {
        if (result.data == 0) {
          deleteMessageAlert(
            message: 'با توجه به درجه عضویت شما امکان ثبت فراخوان رایگان دارید',
            id: 0,
          );
        } else {
          deleteMessageAlert(
            message:
            '  تعداد فراخوان های رایگان شما به پایان رسیده و برای ثبت فراخوان جدید باید ' +
                result.data.toString() +
                ' تومان پرداخت کنید',
            id: 1,
          );
        }
      } else {
        deleteMessageAlert(
          message:
          'متاسفانه شما به علت اتمام تعداد فراخوان های رایگان و غیر رایگان امکان ثبت فراخوان ندارید',
          id: 2,
        );
      }
    }
  }

  void deleteMessageAlert({String? message, int? id, bool? ad}) async {

    showDialog(
      context: Get.context!,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        content: ShowCallOutAlert(
          message: message,
        ),
      ),
    ).then((value) {


      print('=============');
      print(value);
      print('=============');

      if(value['back']){

      }else{
        if (ad!) {
          if (id == 0) {
            scaffoldKey.currentState?.openEndDrawer();
            Get.toNamed(
              RoutingUtils.adAdd.name,
            );
          } else if (id == 1) {
            scaffoldKey.currentState?.openEndDrawer();
            Get.toNamed(
              RoutingUtils.adAdd.name,
            );
          }
        } else {
          if (id == 0) {
            Get.toNamed(
              RoutingUtils.addCallOut.name,
              arguments: {
                'field': dashboardController.listOfFields,
              },
            );
          } else if (id == 1) {
            Get.toNamed(
              RoutingUtils.addCallOut.name,
              arguments: {
                'field': dashboardController.listOfFields,
              },
            );
          }
        }
      }

    });
  }
}
