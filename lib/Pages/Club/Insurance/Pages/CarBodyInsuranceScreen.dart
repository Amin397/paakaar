import 'package:paakaar/Controllers/Club/Services/Insurance/CarBodyInsuranceController.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:paakaar/Widgets/Shared/SinglePageScreen.dart';
import 'package:flutter/material.dart';

class CarBodyInsuranceScreen extends StatelessWidget {
  final CarBodyInsuranceController carBodyInsuranceController = Get.put(
    CarBodyInsuranceController(),
  );

  @override
  Widget build(BuildContext context) {
    return SinglePageScreen(
      iconSetForAppBar: WidgetUtils.singlePageAppBar(
        icon: 'assets/icons/motorbike.svg',
        isIconAsset: true,
        changeColor: true,
        text: 'موتور',
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
