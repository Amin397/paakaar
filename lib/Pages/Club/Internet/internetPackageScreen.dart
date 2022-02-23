import 'dart:async';

import 'package:paakaar/Controllers/Club/Services/InternetPackageController.dart';
import 'package:paakaar/Models/Club/Services/Charge/OperatorModel.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/image_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:paakaar/Widgets/Shared/SinglePageScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class InternetPackageScreen extends StatelessWidget {
  final InternetPackageController internetPackageController =
      Get.put(InternetPackageController());

  @override
  Widget build(BuildContext context) {
    return SinglePageScreen(
      iconSetForAppBar: WidgetUtils.singlePageAppBar(
        icon: FeatherIcons.wifi,
        text: 'اینترنت',
      ),
      shapeStream: this.internetPackageController.shapeStream.stream,
      body: this.buildBody(),
    );
  }

  void showLottie(bool success) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pop(Get.context!);
    });
    showCupertinoDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (BuildContext context) {
        return SizedBox.expand(
          child: Container(
            margin: EdgeInsets.all(50.0),
            child: Center(
              child: success ? ImageUtils.creditSuccess : ImageUtils.creditFail,
            ),
          ),
        );
      },
    );
  }

  Widget checkBoxWidget(String text, String type) {
    return GestureDetector(
      onTap: () {
        this.internetPackageController.changeUserType(type);
      },
      child: Obx(
        () => Row(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 75),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: type == this.internetPackageController.userType.value
                    ? ColorUtils.yellow
                    : Colors.grey.withOpacity(0.2),
              ),
              height: 25.0,
              width: 25.0,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 75),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                },
                child: type == this.internetPackageController.userType.value
                    ? Center(
                        child: Icon(
                          Icons.done,
                          color: Colors.white,
                        ),
                      )
                    : Container(),
              ),
            ),
            SizedBox(
              width: 5.0,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 16.0,
                color: type == this.internetPackageController.userType.value
                    ? ColorUtils.black
                    : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        Container(
          height: Get.height / 8,
          width: Get.width,
          decoration: BoxDecoration(
            boxShadow: ViewUtils.boxShadow(
              blurRadius: 8.0,
              spreadRadius: 8.0,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: Obx(
              () {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 150),
                  child: this.internetPackageController.isLoaded.isTrue
                      ? this.buildList()
                      : ViewUtils.circularProgressIndicator(),
                );
              },
            ),
          ),
        ),
        ViewUtils.sizedBox(
          18,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            this.checkBoxWidget(
              "اعتباری",
              'postpaid',
            ),
            this.checkBoxWidget(
              "دائمی",
              'prepaid',
            ),
          ],
        ),
        Spacer(),
        SafeArea(
          child: WidgetUtils.button(
            text: "مشاهده بسته ها",
            onTap: () => this.internetPackageController.findPackages(),
          ),
        ),
      ],
    );
  }

  Widget buildOperator(Rx<OperatorModel> operator) {
    return Obx(
      () => GestureDetector(
        onTap: () => this
            .internetPackageController
            .pageController
            .animateToPage(
              this.internetPackageController.listOfOperators.indexOf(operator),
              duration: Duration(milliseconds: 175),
              curve: Curves.easeIn,
            ),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 175),
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: operator.value.isSelected ? ColorUtils.black : Colors.white,
            boxShadow: ViewUtils.boxShadow(
              spreadRadius: operator.value.isSelected ? 8.0 : 3.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.network(
                operator.value.logo,
                color: operator.value.isSelected ? ColorUtils.yellow : null,
                width: Get.width / 7,
                height: Get.width / 7,
              ),
              Text(
                operator.value.name,
                style: TextStyle(
                  color: !operator.value.isSelected
                      ? ColorUtils.black
                      : Colors.white,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildList() {
    return PageView.builder(
      onPageChanged: this.internetPackageController.onPageChanged,
      controller: internetPackageController.pageController,
      itemCount: this.internetPackageController.listOfOperators.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (_, int index) => this.buildOperator(
        this.internetPackageController.listOfOperators[index],
      ),
    );
  }
}
