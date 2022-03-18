import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:store_redirect/store_redirect.dart';
import '../Models/version_model.dart';

class UpdateAlert extends StatelessWidget {
  UpdateAlert({Key? key, this.versionModel, this.packageName})
      : super(key: key);
  VersionModel? versionModel;
  String? packageName;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // if (canBack == true) {
        //   return true;
        // }
        return false;
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          height: Get.height * .55,
          width: Get.width,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              Lottie.asset(
                'assets/animations/update.json',
                height: Get.height * .2,
                width: Get.height * .2,
              ),
              const Divider(),
              SizedBox(
                height: Get.height * .1,
                width: Get.width,
                child: Center(
                  child: AutoSizeText(
                    (versionModel!.force!)
                        ? 'نسخه بروز اپلیکیشن در دسترس است \n برای ادامه ابتدا باید اپلیکیشن را بروز رسانی کنید'
                        : 'نسخه بروز اپلیکیشن در دسترس است \n میتوانید نسخه جدید اپلیکیشن را دریافت کنید',
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    maxFontSize: 18.0,
                    minFontSize: 14.0,
                    style: TextStyle(
                      color: ColorUtils.textColor,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              const Divider(),
              const Text(
                'دریافت از :',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.0,
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment:MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: Get.height * .04,
                          width: Get.width,
                          child: Row(
                            children: [
                              (versionModel!.hasGooglePlay!)
                                  ? Flexible(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          StoreRedirect.redirect(
                                            androidAppId: packageName,
                                          );
                                          // launch(versionModel!.googlePlayLink!);
                                        },
                                        child: Container(
                                          height: double.maxFinite,
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(6.0),
                                            boxShadow: ViewUtils.boxShadow(),
                                          ),
                                          child: const Center(
                                            child: AutoSizeText(
                                              'Google Play',
                                              minFontSize: 12.0,
                                              maxFontSize: 18.0,
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                              (versionModel!.hasGooglePlay!)
                                  ? SizedBox(
                                      width: Get.width * .03,
                                    )
                                  : const SizedBox(),
                              Flexible(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    launch(versionModel!.directLink!);
                                  },
                                  child: Container(
                                    height: double.maxFinite,
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                      color: ColorUtils.mainRed,
                                      borderRadius: BorderRadius.circular(6.0),
                                      boxShadow: ViewUtils.boxShadow(),
                                    ),
                                    child: const Center(
                                      child: AutoSizeText(
                                        'لینک مستقیم',
                                        minFontSize: 12.0,
                                        maxFontSize: 18.0,
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: Get.height * .01,),
                        (versionModel!.force!)?const SizedBox():GestureDetector(
                          onTap: (){
                            Get.back(result: true);
                          },
                          child: Container(
                            height: Get.height * .04,
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: const Center(
                              child: AutoSizeText(
                                'شاید بعدا',
                                maxLines: 1,
                                maxFontSize: 18.0,
                                minFontSize: 14.0,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
