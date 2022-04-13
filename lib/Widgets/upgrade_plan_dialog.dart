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
  UpgradePlanDialog({Key? key , this.text , this.fromDashboard , this.topText}) : super(key: key);

  String? text;
  String? topText;
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
                height: Get.height * .45,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Icon(
                            Ionicons.close_outline,
                          ),
                        ),
                      ),
                    ),
                    LottieBuilder.asset(
                      ImageUtils.levelUp,
                      width: 150.0,
                      height: Get.height * .06,
                    ),
                    SizedBox(height: 16.0,),
                    SizedBox(
                      width: Get.width / 1.4,
                      child: Center(
                        child: AutoSizeText(
                          topText!,
                          maxLines: 2,
                          style: TextStyle(
                            color: ColorUtils.textColor,
                            height: 1.5,
                          ),
                          minFontSize: 1.0,
                        ),
                      ),
                    ),
                    // ViewUtils.sizedBox(),
                    // if (Globals.userStream.user?.isExpired == false)

                    ViewUtils.sizedBox(),
                    Text(
                      "ارتقا عضویت",
                      style: TextStyle(
                        color: ColorUtils.red,
                        fontSize: 15.0,
                      ),
                    ),
                    ViewUtils.sizedBox(),
                    SizedBox(
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
                    Spacer(),
                    SizedBox(
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
                    ViewUtils.sizedBox(),
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
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Icon(
                            Ionicons.close_outline,
                          ),
                        ),
                      ),
                    ),
                    LottieBuilder.asset(
                      ImageUtils.levelUp,
                      width: 150.0,
                      height: Get.height * .06,
                    ),
                    const SizedBox(height: 10.0,),
                    SizedBox(
                      width: Get.width / 1.4,
                      child: Center(
                        child: AutoSizeText(
                          topText!,
                          maxLines: 2,
                          style: TextStyle(
                            color: ColorUtils.textColor,
                            height: 1.5,
                          ),
                          minFontSize: 1.0,
                        ),
                      ),
                    ),
                    // ViewUtils.sizedBox(),
                    // if (Globals.userStream.user?.isExpired == false)

                    ViewUtils.sizedBox(),
                    Text(
                      "ارتقا عضویت",
                      style: TextStyle(
                        color: ColorUtils.red,
                        fontSize: 15.0,
                      ),
                    ),
                    ViewUtils.sizedBox(),
                    SizedBox(
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
                    Spacer(),
                    SizedBox(
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
                    ViewUtils.sizedBox(),
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
