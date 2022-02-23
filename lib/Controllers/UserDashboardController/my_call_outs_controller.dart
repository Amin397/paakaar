import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Models/Calls/call_model.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/project_request_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:frefresh/frefresh.dart';

class MyCallOutsController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final FRefreshController callOutsRefreshController = FRefreshController();

  final ProjectRequestUtils requests = ProjectRequestUtils.instance;
  late List<CallModel> listOfCallOuts;
  RxBool isCallOutsLoaded = false.obs;

  bool isDeleting = false;

  Future<void> getCallOuts() async {
    isCallOutsLoaded.value = false;
    ApiResult result = await requests.getUserCallOuts();
    if (result.isDone) {
      listOfCallOuts = CallModel.listFromJsonForMyCallOut(result.data);
      isCallOutsLoaded.value = true;
    } else {
      ViewUtils.showErrorDialog(
        result.data.toString(),
      );
    }
  }

  void enterDeletingMode([
    CallModel? callOut,
  ]) {
    isDeleting = true;
    if (callOut is CallModel) {
      callOut.isDeleting = true;
    }
    update();
  }

  void deleteCalls() async {
    EasyLoading.show();
    ApiResult result = await ProjectRequestUtils.instance.deleteCallOuts(
      listOfCallOuts
          .where((element) => element.isDeleting)
          .map((e) => e.id)
          .toList(),
    );
    EasyLoading.dismiss();
    if (result.isDone) {
      listOfCallOuts.removeWhere((element) => element.isDeleting);
      isDeleting = false;
      Globals.userStream.deleteCallOut(
        count: listOfCallOuts
            .toList()
            .length,
      );
      update();
    } else {
      ViewUtils.showErrorDialog(result.data.toString());
    }
  }

  @override
  void onInit() {
    getCallOuts();
    super.onInit();
  }
}
