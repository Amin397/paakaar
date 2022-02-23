import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Widgets/complete_register.dart';
import 'package:flutter/material.dart';

class AlertUtils {
  static void completeData({
    required String mobile,
    required String code,
  }) {
    Get.dialog(
      Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          content: CompleteRegister(
            mobile: mobile,
            code: code,
          ),
        ),
      ),
      barrierColor: Colors.black.withOpacity(0.5),
      barrierDismissible: true,
    );
  }
}
