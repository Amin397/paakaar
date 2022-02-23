import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/image_utils.dart';
import 'package:paakaar/Utils/routing_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';

class UpgradePlanDialog extends StatelessWidget {
  UpgradePlanDialog({Key? key , this.text , this.fromDashboard}) : super(key: key);

  String? text;
  bool? fromDashboard;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: LayoutBuilder(
        builder: (BuildContext context , BoxConstraints constraints){
          if(constraints.maxWidth > 300.0){
            return Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                width: Get.width / 1.2,
                height: Get.height * .4,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    LottieBuilder.asset(
                      ImageUtils.levelUp,
                    ),
                    // if (Globals.userStream.user?.isExpired == false)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () {
                          // if(fromDashboard!){
                          //   Get.close(1);
                          // }else{
                          //   Get.close(1);
                            Get.back();
                          // }
                        },
                        child: const Icon(
                          Ionicons.close_outline,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      child: Column(
                        children: [
                          Text(
                            "ارتقا عضویت",
                            style: TextStyle(
                              color: ColorUtils.red,
                              fontSize: 15.0,
                            ),
                          ),
                          ViewUtils.sizedBox(),
                          Container(
                            width: Get.width / 1.4,
                            child: Center(
                              child: AutoSizeText(
                                text!,
                                maxLines: 2,
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
                              text: "انتخاب اشتراک",
                              onTap: () {
                                if(fromDashboard!){
                                  Get.back();
                                  Get.toNamed(
                                    RoutingUtils.upgradePlan.name,
                                  );
                                }else{
                                  Get.back();
                                  Get.back();
                                  Get.toNamed(
                                    RoutingUtils.upgradePlan.name,
                                  );
                                }
                              },
                            ),
                          ),
                          ViewUtils.sizedBox(75),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }else{
            return Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                width: Get.width * .8,
                height: Get.height * .45,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    LottieBuilder.asset(
                      ImageUtils.levelUp,
                    ),
                    // if (Globals.userStream.user?.isExpired == false)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () {
                          if(fromDashboard!){
                            Get.close(1);
                          }else{
                            Get.close(1);
                            Get.back();
                          }
                        },
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
                              "ارتقا عضویت",
                              style: TextStyle(
                                color: ColorUtils.mainRed,
                                fontSize: 15.0,
                              ),
                            ),
                            ViewUtils.sizedBox(),
                            Container(
                              width: Get.width / 1.4,
                              child: Center(
                                child: AutoSizeText(
                                  text!,
                                  maxLines: 2,
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
                                text: "انتخاب اشتراک",
                                onTap: () {
                                  if(fromDashboard!){
                                    Get.back();
                                    Get.toNamed(
                                      RoutingUtils.upgradePlan.name,
                                    );
                                  }else{
                                    Get.back();
                                    Get.back();
                                    Get.toNamed(
                                      RoutingUtils.upgradePlan.name,
                                    );
                                  }
                                },
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
            );
          }
        },
      ),
    );
  }
}
