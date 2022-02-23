import 'package:flutter/material.dart';
import 'package:paakaar/Pages/ReportFromUser/Controller/report_from_user_controller.dart';
import 'package:paakaar/Pages/ReportFromUser/Model/report_model.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/routing_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';

class ReportFromUserScreen extends StatelessWidget {
  ReportFromUserScreen({Key? key}) : super(key: key);
  final ReportFromUserController reportFromUserController =
      Get.put(ReportFromUserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: ColorUtils.myRed,
        onPressed: () {
          Get.toNamed(
            RoutingUtils.newReport.name,
            arguments: {
              'controller':reportFromUserController
            }
          );
        },
        label: const Text(
          'ارسال گزارش جدید',
        ),
      ),
      body: Container(
        height: Get.height * .8,
        width: Get.height,
        padding: ViewUtils.scaffoldPadding,
        child: GetBuilder(
          init: reportFromUserController,
          builder: (ctx)=>(reportFromUserController.isLoaded.value)
              ? (reportFromUserController.reportList.isNotEmpty)
              ? ListView.builder(
            itemCount: reportFromUserController.reportList.length,
            itemBuilder: (BuildContext context, int index) =>
                _buildSingleTicket(
                  item: reportFromUserController.reportList[index],
                ),
          )
              : Center(
            child: WidgetUtils.dataNotFound('گزارشی ثبت نکرده اید'),
          )
              : WidgetUtils.loadingWidget(),
        ),
      ),
    );
  }

  Widget _buildSingleTicket({ReportModel? item}) {
    return InkWell(
      onLongPress: (){
        reportFromUserController.removeReport(report:item);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 4.0,
          horizontal: 4.0,
        ),
        width: Get.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: ColorUtils.mainRed,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: Get.width / 1.5,
                      ),
                      child: Text(
                        item!.text!,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
