import 'package:paakaar/Controllers/Club/Services/Insurance/ThirdPersonInsuranceController.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:paakaar/Widgets/Shared/SinglePageScreen.dart';
import 'package:flutter/material.dart';

class ThirdPersonInsuranceScreen extends StatelessWidget {
  final ThirdPersonInsuranceController thirdPersonInsuranceController = Get.put(
    ThirdPersonInsuranceController(),
  );

  @override
  Widget build(BuildContext context) {
    return SinglePageScreen(
      iconSetForAppBar: WidgetUtils.singlePageAppBar(
        icon: 'assets/icons/carCrash.svg',
        isIconAsset: true,
        changeColor: true,
        text: 'بیمه شخص ثالث',
      ),
      body: this.buildBody(),
    );
  }

  Widget buildBody() {
    return Column(
      children: [],
    );
  }
}
