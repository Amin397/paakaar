import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:persian_number_utility/persian_number_utility.dart'; //import

class ViewUtils {
  static const EdgeInsetsGeometry scaffoldPadding =
      EdgeInsets.symmetric(horizontal: 12.0);

  static Color blurColor = Colors.grey.shade200.withOpacity(0.4);

  static String moneyFormat(
    double? price, {
    bool toman = false,
  }) {
    price ??= 0.0;
    return price.toInt().toString().seRagham() + (toman ? ' تومان' : '');
  }

  static SizedBox sizedBox([
    double heightFactor = 50,
  ]) {
    return SizedBox(
      height: Get.height / heightFactor,
    );
  }

  static circularProgressIndicator() {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Container(
            height: Get.height / 15,
            width: Get.height / 15,
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(ColorUtils.yellow),
            ),
          ),
        ),
      ),
    );
  }

  static void showInfoDialog([
    String text = "خطایی رخ داد",
    String title = '',
  ]) {
    Get.snackbar(
      title,
      text,
      backgroundGradient: LinearGradient(
        colors: [
          ColorUtils.blue.withOpacity(0.4),
          ColorUtils.blue,
        ],
      ),
      backgroundColor: Colors.white.withOpacity(0.9),
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 12.0,
      ),
      icon: Icon(
        Ionicons.information_circle_outline,
        size: Get.height / 28,
      ),
      duration: const Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  static List<List<T>> generateChunks<T>(List<T> inList, int chunkSize) {
    List<List<T>> outList = [];
    List<T> tmpList = [];
    int counter = 0;

    for (int current = 0; current < inList.length; current++) {
      if (counter != chunkSize) {
        tmpList.add(inList[current]);
        counter++;
      }
      if (counter == chunkSize || current == inList.length - 1) {
        outList.add(tmpList.toList());
        tmpList.clear();
        counter = 0;
      }
    }

    return outList;
  }

  static void showErrorDialog([
    String text = "خطایی رخ داد",
    String title = "خطایی رخ داد",
  ]) {
    Get.snackbar(
      '',
      text,
      backgroundGradient: LinearGradient(
        colors: [
          ColorUtils.red.withOpacity(0.5),
          ColorUtils.red.withOpacity(0.8),
        ],
      ),
      colorText: Colors.white.withOpacity(0.7),
      backgroundColor: Colors.white.withOpacity(0.9),
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 12.0,
      ),
      margin: EdgeInsets.only(bottom: Get.height / 8),
      duration: const Duration(seconds: 3),
      icon: Icon(
        Ionicons.warning_outline,
        color: ColorUtils.red.shade100,
        size: Get.height / 28,
      ),
      snackPosition: SnackPosition.BOTTOM,
    );
    return;
  }

  static shadowedBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: ColorUtils.shadowColor,
          spreadRadius: 10.0,
          blurRadius: 7.0,
        ),
      ],
    );
  }

  static boxShadow({
    double spreadRadius = 3.0,
    double blurRadius = 12.0,
    Offset offset = Offset.zero,
  }) {
    return [
      BoxShadow(
        color: ColorUtils.shadowColor,
        spreadRadius: spreadRadius,
        blurRadius: blurRadius,
        offset: offset,
      ),
    ];
  }

  static mainBoxShadow() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: ColorUtils.shadowColor,
          spreadRadius: 5.0,
          blurRadius: 5.0,
        ),
      ],
    );
  }

  static void showSuccessDialog(
    text, {
    String title = 'عملیات موفق آمیز بود',
  }) {
    Get.snackbar(
      title,
      text,
      colorText: ColorUtils.textColor,
      backgroundGradient: LinearGradient(
        colors: [
          ColorUtils.green.shade600,
          ColorUtils.green.shade900,
        ],
      ),
      icon: Icon(
        Icons.done,
        color: ColorUtils.green,
        size: Get.height / 28,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 12.0,
      ),
      margin: EdgeInsets.only(bottom: Get.height / 8),
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
