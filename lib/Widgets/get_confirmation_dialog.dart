import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class GetConfirmationDialog extends StatelessWidget {
  final String title;
  final String text;

  const GetConfirmationDialog({
    Key? key,
    this.title = 'آیا از این عملیات اطمینان دارید؟',
    required this.text,
  }) : super(key: key);

  static Future<bool> show({
    String title = 'آیا از این عملیات اطمینان دارید؟',
    required String text,
  }) async {
    return await Get.dialog(
      GetConfirmationDialog(
        text: text,
        title: title,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
        child: Container(
          width: Get.width / 1.2,
          height: Get.height / 4,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: ViewUtils.boxShadow(
              blurRadius: 12.0,
              spreadRadius: 2.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Get.close(1),
                      child: Icon(
                        Ionicons.close,
                        color: ColorUtils.black,
                      ),
                    ),
                    Text(
                      "${this.title}",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: ColorUtils.black,
                      ),
                    ),
                    Icon(
                      Ionicons.close,
                      color: Colors.transparent,
                    ),
                  ],
                ),
                ViewUtils.sizedBox(25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: (Get.width / 1.2) - 24,
                      child: AutoSizeText(
                        "${this.text}",
                        maxLines: 4,
                        minFontSize: 2.0,
                        maxFontSize: 14.0,
                        style: TextStyle(
                          fontSize: 14.0,
                          height: 1.5,
                          color: ColorUtils.textColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        margin: EdgeInsets.all(12.0),
                        width: Get.width / 7,
                        height: Get.height / 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            "لغو",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        Get.back(
                          result: true,
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(12.0),
                        width: Get.width / 7,
                        height: Get.height / 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: ColorUtils.green.shade600,
                        ),
                        child: Center(
                          child: Text(
                            "تایید",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
