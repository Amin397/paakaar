import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:paakaar/Pages/NewReport/Controller/new_report_controller.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:paakaar/Plugins/get/get.dart';

class NewReportFromUserScreen extends StatelessWidget {
  NewReportFromUserScreen({Key? key}) : super(key: key);
  final NewReportController newReportController =
      Get.put(NewReportController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: WidgetUtils.appBar(
          innerPage: true,
        ),
        body: Container(
          height: Get.height,
          width: Get.width,
          padding: EdgeInsets.symmetric(
            horizontal: Get.width * .03,
            vertical: Get.height * .02,
          ),
          child: Column(
            children: [
              ViewUtils.sizedBox(),
              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'متن گزارش',
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ),
              ViewUtils.sizedBox(70),
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          height: double.maxFinite,
                          width: double.maxFinite,
                          child: TextField(
                            controller:
                                newReportController.reportMessageController,
                            maxLines: 20,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: ColorUtils.black.withOpacity(0.2),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: ColorUtils.orange,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // const Spacer(),
                      ViewUtils.sizedBox(80),
                      GestureDetector(
                        onTap: () {
                          newReportController.sendReport();
                        },
                        child: Container(
                          width: Get.width,
                          height: Get.height * .05,
                          decoration: BoxDecoration(
                            color: ColorUtils.green,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: const Center(
                            child: AutoSizeText(
                              "ارسال گزارش",
                              maxLines: 1,
                              maxFontSize: 18.0,
                              minFontSize: 14.0,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ),
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
}
