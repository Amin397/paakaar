import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Models/Auth/user.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:flutter/material.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/project_request_utils.dart';
import 'package:paakaar/Utils/routing_utils.dart';

class UserDashboardController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final ProjectRequestUtils requests = ProjectRequestUtils.instance;

  @override
  void onInit() {
    handleStart();
    getScore();
    super.onInit();
  }

  void handleStart() async {
    final box = GetStorage();
    var userId = box.read('userId');
    if (userId != null) {
      ApiResult result = await requests.getIndividualData(userId.toString());
      if (result.isDone) {
        Globals.userStream.user = UserModel.fromJson(
          result.data,
        );
        Globals.userStream.sync();

        var notif = box.read('notif');
        if (notif != 0 && notif != null) {
          List<dynamic> notifList = jsonDecode(
            box.read('notifList'),
          );
          Globals.notification.setNotification(
            notification: notif,
            messagesList: notifList,
          );
        }
        return;
      }
    }
  }

  void getScore() async {
    ApiResult result = await requests.getDashboardScore();
    if (result.isDone) {
      Globals.userStream.setUserScore(result.data);
    }
  }

  @override
  void onClose() {
    getScore();
    handleStart();
    super.onClose();
  }

  @override
  void onReady() {
    getScore();
    handleStart();
    super.onReady();
  }
}
