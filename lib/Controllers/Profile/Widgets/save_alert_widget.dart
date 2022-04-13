import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/routing_utils.dart';

import '../../../main.dart';
import '../complete_profile_controller.dart';

class SaveAlertDialog extends StatelessWidget {
  final CompleteProfileController? controller;

  const SaveAlertDialog({Key? key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * .25,
      width: Get.width,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Align(
            alignment: Alignment.centerRight,
            child: Text('! توجه'),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: AutoSizeText(
              'در صورت اعمال تغییر در پروفایل خود \nحتما باید تغییرات را ذخیره نمایید ',
              maxFontSize: 16.0,
              maxLines: 3,
              textAlign: TextAlign.right,
              minFontSize: 12.0,
              style: TextStyle(
                color: ColorUtils.textColor,
                fontSize: 14.0,
              ),
            ),
          ),
          SizedBox(
            width: Get.width,
            height: Get.height * .05,
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      controller!.save(
                        fromAppBar: true,
                        fabAction: true
                      );
                    },
                    child: Container(
                      height: double.maxFinite,
                      width: double.maxFinite,
                      margin: EdgeInsets.symmetric(
                        horizontal: Get.width * .06,
                        vertical: Get.height * .005,
                      ),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                          )
                        ],
                        color: ColorUtils.green,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Center(
                        child: AutoSizeText(
                          'ذخیره',
                          maxLines: 1,
                          maxFontSize: 14.0,
                          minFontSize: 10.0,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      final box = GetStorage();
                      var firstEnter = box.read('firstEnter');
                      if (firstEnter is bool) {

                        // Get.offAndToNamed(RoutingUtils.dashboard.name);
                        // Future.delayed(Duration(seconds: 3) , (){
                        //   Get.back();
                        // });

                      } else {
                        var firstEnter = box.write(
                          'firstEnter',
                          true,
                        );
                      }

                      // Globals.profileGlobalsKeys.clearAllKeys();
                      controller!.onClose();
                      Get.offAndToNamed(RoutingUtils.dashboard.name);
                    },
                    child: SizedBox(
                      height: double.maxFinite,
                      width: double.maxFinite,
                      child: Center(
                        child: Text(
                          'لغو',
                          style: TextStyle(
                            color: ColorUtils.textColor,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
