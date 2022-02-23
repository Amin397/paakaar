import 'package:paakaar/Controllers/Club/Services/Insurance/MotorInsuranceController.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:paakaar/Widgets/Shared/SinglePageScreen.dart';
import 'package:flutter/material.dart';

class MotorInsuranceScreen extends StatelessWidget {
  final MotorInsuranceController motorInsuranceController = Get.put(
    MotorInsuranceController(),
  );

  @override
  Widget build(BuildContext context) {
    return SinglePageScreen(
      iconSetForAppBar: WidgetUtils.singlePageAppBar(
        icon: 'assets/icons/carinsurance.svg',
        isIconAsset: true,
        changeColor: true,
        text: 'بدنه',
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
