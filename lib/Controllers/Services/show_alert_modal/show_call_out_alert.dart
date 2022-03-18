import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:paakaar/Models/MainPage/Field.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/routing_utils.dart';

class ShowCallOutAlert extends StatelessWidget {
  ShowCallOutAlert({
    Key? key,
    this.message,
    this.field,
    this.id,
    this.fromDrawer,
  }) : super(key: key);

  String? message;
  FieldModel? field;
  int? id;
  bool? fromDrawer;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
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
            const Center(
              child: Text('توجه !'),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: AutoSizeText(
                message!,
                maxFontSize: 16.0,
                maxLines: 4,
                textAlign: TextAlign.center,
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
                        // if(fromDrawer is bool) {
                          Get.back(
                            result: {
                              'back': false
                            },
                          );
                        // }
                        // }else{
                        //   if (id == 1) {
                        //     Get.back(
                        //       result: {
                        //         'back':false
                        //       },
                        //     );
                        //     Get.toNamed(
                        //       RoutingUtils.addCallOut.name,
                        //       arguments: {
                        //         'field': field,
                        //       },
                        //     );
                        //   }else{
                        //     print(id);
                        //   }
                        // }


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
                            'فهمیدم!',
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
                        Get.back(
                          result: {
                            'back':true
                          },
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
                          color: ColorUtils.myRed,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Center(
                          child: AutoSizeText(
                            'بازگشت',
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
