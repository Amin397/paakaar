import 'package:paakaar/Models/Auth/user.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/project_request_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:flutter/material.dart';
import 'package:frefresh/frefresh.dart';

class BookmarksController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final FRefreshController bookmarksRefreshController =
      FRefreshController();

  late List<UserModel> listOfBookmarks;
  RxBool isBookmarksLoaded = false.obs;
  Future<void> allBookmarks() async {
    ApiResult result = await ProjectRequestUtils.instance.myBookmarks();
    if (result.isDone) {
      listOfBookmarks = UserModel.listFromJson(result.data);
      isBookmarksLoaded.value = false;
      isBookmarksLoaded.value = true;
    } else {
      ViewUtils.showErrorDialog(
        result.data.toString(),
      );
    }
  }

  @override
  void onInit() {
    allBookmarks();
    super.onInit();
  }
}
