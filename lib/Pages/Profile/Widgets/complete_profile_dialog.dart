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
                width: Get.width * .85,
                height: Get.height * .5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => Get.close(1),
                      child: const Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Ionicons.close_outline,
                          ),
                        ),
                      ),
                    ),
                    LottieBuilder.asset(
                      ImageUtils.levelUp,
                      height: Get.height * .07,
                      width: Get.width,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
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
                            SizedBox(
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
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                ),
                                height: double.maxFinite,
                                width: double.maxFinite,
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.close(1);
                                    },
                                    child: Container(
                                      width: Get.width,
                                      height: Get.height * .05,
                                      decoration: BoxDecoration(
                                        color: ColorUtils.mainRed,
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'متوجه شدم!',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
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
        } else {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Center(
              child: Container(
                width: Get.width * .85,
                height: Get.height * .5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => Get.close(1),
                      child: const Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Ionicons.close_outline,
                          ),
                        ),
                      ),
                    ),
                    LottieBuilder.asset(
                      ImageUtils.levelUp,
                      height: Get.height * .07,
                      width: Get.width,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
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
                            SizedBox(
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
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                ),
                                height: double.maxFinite,
                                width: double.maxFinite,
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.close(1);
                                    },
                                    child: Container(
                                      width: Get.width,
                                      height: Get.height * .05,
                                      decoration: BoxDecoration(
                                        color: ColorUtils.mainRed,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'متوجه شدم!',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
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
