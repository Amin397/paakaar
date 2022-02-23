import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Models/Calls/ad_model.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/project_request_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:frefresh/frefresh.dart';

class MyAdsController extends GetxController {
  late List<AdModel> listOfAds;
  RxBool isAdsLoaded = false.obs;
  final FRefreshController adRefreshController = new FRefreshController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool isDeleting = false;

  Future<void> getAds() async {
    isAdsLoaded.value = false;
    ApiResult result = await ProjectRequestUtils.instance.getUserAds();
    if (result.isDone) {
      listOfAds = AdModel.listFromJson(result.data);
      isAdsLoaded.value = true;
    } else {
      ViewUtils.showErrorDialog(
        result.data.toString(),
      );
    }
  }

  @override
  void onInit() {
    getAds();
    super.onInit();
  }

  void enterDeletingMode([
    AdModel? ad,
  ]) {
    isDeleting = true;
    if (ad is AdModel) {
      ad.isDeleting = true;
    }
    update();
  }

  void deleteAds() async {
    EasyLoading.show();
    ApiResult result = await ProjectRequestUtils.instance.deleteAds(
      listOfAds
          .where((element) => element.isDeleting)
          .map((e) => e.id)
          .toList(),
    );
    EasyLoading.dismiss();
    if (result.isDone) {
      listOfAds.removeWhere((element) => element.isDeleting);
      isDeleting = false;
      Globals.userStream.deleteAds(
        count: listOfAds

            .toList()
            .length,
      );
      update();
    } else {
      ViewUtils.showErrorDialog(result.data.toString());
    }
  }
}
