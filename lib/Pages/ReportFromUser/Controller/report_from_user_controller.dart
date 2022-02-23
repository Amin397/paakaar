import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:paakaar/Pages/ReportFromUser/Model/report_model.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/project_request_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Widgets/get_confirmation_dialog.dart';

class ReportFromUserController extends GetxController {
  final ProjectRequestUtils requests = ProjectRequestUtils();


  List<ReportModel> reportList = [];
  RxBool isLoaded = false.obs;

  @override
  void onInit() {
    getAllReport();
    super.onInit();
  }

  void getAllReport() async {
    ApiResult result = await requests.getAllReports();
    if (result.isDone) {
      reportList = ReportModel.listFromJson(result.data);
      isLoaded.value = true;
      update();
    } else {
      ViewUtils.showErrorDialog(
        'دریافت لیست گزارش ها با خطا مواجه شد',
      );
    }
  }

  void removeReport({ReportModel? report}) async{
    bool? isConfirmed =
        await GetConfirmationDialog.show(
      text: "آیا از حذف این گزارش مطمین هستید؟",
    );
    if(isConfirmed){
      EasyLoading.show();
      ApiResult result = await requests.removeReport(id:report!.reportId.toString());
      EasyLoading.dismiss();
      if(result.isDone){
        reportList.remove(report);
        update();
      }else{
        ViewUtils.showErrorDialog();
      }
    }
  }
}
