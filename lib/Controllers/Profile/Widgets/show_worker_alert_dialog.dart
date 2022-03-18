import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/color_utils.dart';

class ShowWorkerAlertDialog extends StatelessWidget {
  const ShowWorkerAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: Get.height * .25,
        width: Get.width,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            AutoSizeText(
              'امکان افزودن تخصص را ندارید\nبرای افزودن تخصص ابتدا باید سطح عضویت خود را ارتقاء دهید',
              style: TextStyle(
                color: ColorUtils.textColor,
              ),
            ),
            Expanded(
              child: SizedBox(
                height: double.maxFinite,
                width: double.maxFinite,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: Container(
                      width: Get.width,
                      height: Get.height * .05,
                      decoration: BoxDecoration(
                        color: ColorUtils.green,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: const Center(
                        child: AutoSizeText(
                          'فهمیدم',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
