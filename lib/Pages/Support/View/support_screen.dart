import 'package:flutter/material.dart';
import 'package:paakaar/Pages/ConnectUs/View/connect_us_screen.dart';
import 'package:paakaar/Pages/ReportFromUser/View/report_from_user_screen.dart';
import 'package:paakaar/Pages/Support/Controller/support_controller.dart';
import 'package:paakaar/Pages/Ticket/View/ticket_screen.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:paakaar/Widgets/custom_drawer_widget.dart';

class SupportScreen extends StatelessWidget {
  SupportScreen({Key? key}) : super(key: key);
  final SupportController supportController = Get.put(
    SupportController(),
  );

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: WidgetUtils.appBar(
          innerPage: true,
          key: supportController.scaffoldKey,
        ),
        key: supportController.scaffoldKey,
        drawer: CustomDrawerWidget(),
        body: Container(
          height: Get.height,
          width: Get.width,
          child: DefaultTabController(
            length: 3,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  Container(
                    width: Get.width,
                    height: Get.height * .05,
                    child: TabBar(
                      onTap: (page) {},
                      indicatorColor: ColorUtils.myRed,
                      tabs: [
                        Tab(
                          child: Center(
                            child: Text(
                              "تماس با ما",
                              style: TextStyle(
                                color: ColorUtils.mainRed,
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Center(
                            child: Text(
                              "تیکت",
                              style: TextStyle(
                                color: ColorUtils.mainRed,
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Center(
                            child: Text(
                              "گزارش تخلف",
                              style: TextStyle(
                                color: ColorUtils.mainRed,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: Get.height * .01,
                        horizontal: Get.width * .02,
                      ),
                      height: double.maxFinite,
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(
                        vertical: Get.height * .01,
                        horizontal: Get.width * .02,
                      ),
                      child: TabBarView(
                        children: [
                          ConnectUsScreen(),
                          SingleTicketScreen(),
                          ReportFromUserScreen(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
