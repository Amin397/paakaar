import 'package:paakaar/Plugins/get/get.dart';
import 'package:flutter/material.dart';

class SinglePageController extends GetxController {
  Rx<Offset> position =
      Offset((Get.width / 2) - (Get.width / 8), Get.height / 8).obs;

  RxInt animationDuration = 150.obs;
  RxBool isMoving = false.obs;
  RxBool isShown = true.obs;
  @override
  void onInit() {
    print(Get.parameters);
    super.onInit();
  }
}
