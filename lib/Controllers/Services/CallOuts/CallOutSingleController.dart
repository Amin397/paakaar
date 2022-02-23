import 'package:flutter/material.dart';
import 'package:paakaar/Models/Calls/call_model.dart';
import 'package:paakaar/Plugins/get/get.dart';

class CallOutSingleController extends GetxController {
  late CallModel callOut;
  late bool seeProfile;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void onInit() {
    callOut = Get.arguments['callOut'];
    print(callOut.proposeCount);
    // print(callOut.isPast);
    print(callOut.id);
    seeProfile = Get.arguments['seeProfile'] ?? false;
    super.onInit();
  }
}
