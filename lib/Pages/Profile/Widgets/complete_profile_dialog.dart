import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/image_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';

class CompleteProfileDialog extends StatelessWidget {
  CompleteProfileDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints raints) {
        if (raints.maxWidth > 460.0) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Center(
              child: Container(
                width: Get.width * .8,
                height: Get.height * .5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    LottieBuilder.asset(
                      ImageUtils.levelUp,
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () => Get.close(1),
                        child: const Icon(
                          Ionicons.close_outline,
                        ),
                      ),
                    ),
                    Positioned(
                      top: Get.height * .1,
                      child: Column(
                        children: [
                          Text(
                            "اکنون کاربر ویژه هستید",
                            style: TextStyle(
                              color: ColorUtils.myRed,
                              fontSize: 15.0,
                            ),
                          ),
                          ViewUtils.sizedBox(),
                          Container(
                            width: Get.width / 1.4,
                            child: Center(
                              child: AutoSizeText(
                                "جهت دیده شدن در ویترین خدمات و دسترسی کاربران به خدمات و تخصص شما٬ لطفا اطلاعات پروفایل خود (تخصص٬ نمونه کار و ...) را تکمیل نمایید",
                                maxLines: 5,
                                style: TextStyle(
                                  color: ColorUtils.textColor,
                                  height: 1.5,
                                ),
                                minFontSize: 1.0,
                              ),
                            ),
                          ),
                          ViewUtils.sizedBox(),
                          Container(
                            width: Get.width / 1.4,
                            child: WidgetUtils.button(
                              text: "متوجه شدم!",
                              onTap: () => Get.close(1),
                            ),
                          ),
                          ViewUtils.sizedBox(75),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Center(
              child: Container(
                width: Get.width * .8,
                height: Get.height * .45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    LottieBuilder.asset(
                      ImageUtils.levelUp,
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () => Get.close(1),
                        child: const Icon(
                          Ionicons.close_outline,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.maxFinite,
                        height: Get.height * .3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "اکنون کاربر ویژه هستید",
                              style: TextStyle(
                                color: ColorUtils.myRed,
                                fontSize: 15.0,
                              ),
                            ),
                            ViewUtils.sizedBox(),
                            Container(
                              width: Get.width / 1.4,
                              child: Center(
                                child: AutoSizeText(
                                  "جهت دیده شدن در ویترین خدمات و دسترسی کاربران به خدمات و تخصص شما٬ لطفا اطلاعات پروفایل خود (تخصص٬ نمونه کار و ...) را تکمیل نمایید",
                                  maxLines: 5,
                                  style: TextStyle(
                                    color: ColorUtils.textColor,
                                    height: 1.5,
                                  ),
                                  minFontSize: 1.0,
                                ),
                              ),
                            ),
                            ViewUtils.sizedBox(),
                            Container(
                              width: Get.width / 1.4,
                              child: WidgetUtils.button(
                                text: "متوجه شدم!",
                                onTap: () => Get.close(1),
                              ),
                            ),
                            ViewUtils.sizedBox(75),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
