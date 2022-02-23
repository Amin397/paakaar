import 'package:paakaar/Controllers/Club/DashboardController.dart';
import 'package:paakaar/Pages/Club/Home/home_page_widget.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:flutter/material.dart';

class ClubDashboardScreen extends StatelessWidget {
  final ClubDashboardController dashboardController = Get.put(
    ClubDashboardController(),
  );

  @override
  Widget build(BuildContext context) {
    // return AnimationPage();
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        backgroundColor: ColorUtils.black,
        body: Directionality(
          child: buildPage(0),
          textDirection: TextDirection.rtl,
        ),
      ),
    );
  }

  Widget buildPage(int index) {
    return HomePageWidget(
      dashboardController: dashboardController,
    );
  }
}
