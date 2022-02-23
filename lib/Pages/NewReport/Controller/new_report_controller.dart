import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:paakaar/Pages/ReportFromUser/Controller/report_from_user_controller.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/project_request_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';

class NewReportController extends GetxController {
  final ProjectRequestUtils requests = ProjectRequestUtils();
  TextEditingController reportMessageController = TextEditingController();
  ReportFromUserController? reportFromUserController;

  @override
  void onInit() {
    reportFromUserController = Get.arguments['controller'];
    super.onInit();
  }

  void sendReport() async {
    EasyLoading.show();
    ApiResult result =
        await requests.sendNewReport(report: reportMessageController.text);
    EasyLoading.dismiss();
    if (result.isDone) {
      ViewUtils.showSuccessDialog('گزارش شما با موفقیت ثبت شد');
      reportFromUserController!.getAllReport();
      Get.back();
      Get.back();
    } else {
      ViewUtils.showErrorDialog('در ارسال گزارش خطایی ره داد');
    }
  }
}
