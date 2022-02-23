import 'package:paakaar/Controllers/MainPage/dashboard_controller.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/image_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final DashboardController dashboardController;

  const CustomBottomNavigationBar({
    Key? key,
    required this.dashboardController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: ColorUtils.mainRed.shade900,
      shape: const CircularNotchedRectangle(),
      elevation: 1,
      notchMargin: 12,
      child: Container(
        height: Get.height / 12,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildIcon(
              index: 1,
              icon: ImageUtils.homeIcon,
            ),
            buildIcon(
              index: 2,
              icon: ImageUtils.person,
            ),
            SizedBox(
              width: Get.width / 10,
            ),
            buildIcon(
              index: 3,
              icon: ImageUtils.padLock,
            ),
            buildIcon(
              index: 4,
              icon: ImageUtils.chatIcon,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIcon({
    required int index,
    required String icon,
  }) {
    return Obx(
      () => InkWell(
        onTap: () {
          print(index);
          print(dashboardController.currentPage.value);
          dashboardController.currentPage.value = index;
        },
        child: Container(
          padding: EdgeInsets.only(
            top: Get.width * .02,
            left: Get.width * .02,
            right: Get.width * .02,
          ),
          child: SvgPicture.asset(
            icon,
            color: dashboardController.currentPage.value == index
                ? Colors.white
                : Colors.white.withOpacity(0.5),
            width: dashboardController.currentPage.value == index
                ? Get.width / 14
                : Get.width / 18,
          ),
        ),
      ),
    );
  }
}
