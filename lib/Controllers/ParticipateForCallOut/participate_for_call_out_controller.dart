import 'package:flutter/material.dart';
import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Models/Calls/call_model.dart';
import 'package:paakaar/Models/Calls/CallPriceType.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/project_request_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';

class ParticipateForCallOutController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descTextController = TextEditingController();

  late CallModel callOut;
  List<CallPriceType> listOfPriceTypes = [
    CallPriceType(
      id: 1,
      name: "ساعتی",
      isSelected: true,
    ),
    CallPriceType(
      id: 2,
      name: "روزانه",
    ),
    CallPriceType(
      id: 3,
      name: "ماهیانه",
    ),
    CallPriceType(
      id: 4,
      name: "پروژه ای",
    ),
    CallPriceType(
      id: 5,
      name: "توافقی",
    ),
  ];

  @override
  void onInit() {
    callOut = Get.arguments['callOut'];
    super.onInit();
  }

  bool isActive(p1) {
    return p1.isSelected;
  }

  void makeActive(p1) {
    for (var element in listOfPriceTypes) {
      element.isSelected = false;
    }
    p1.isSelected = true;
    if (p1.id == 5) {
      priceController.clear();
    }
    unFocus();
    update();
  }

  void unFocus() {
    Focus.of(Get.context!).requestFocus(FocusNode());
  }

  void sendProposal() async {
    if (listOfPriceTypes.singleWhere((element) => element.isSelected).id <
        4) {
      if (priceController.text.isEmpty) {
        ViewUtils.showErrorDialog(
          "لطفا قیمت را وارد کنید",
        );
        return;
      }
    }
    if (descTextController.text.isEmpty) {
      ViewUtils.showErrorDialog(
        "لطفا متن پیشنهاد را وارد کنید",
      );
      return;
    }
    ApiResult result = await ProjectRequestUtils.instance.sendProposal(
      callId: callOut.id,
      price: priceController.text.replaceAll(',', '').trim(),
      priceTypeId:
          listOfPriceTypes.singleWhere((element) => element.isSelected).id,
      text: descTextController.text,
    );
    if (result.isDone) {
      Get.back();
      Get.back();
      Get.back();
      Globals.userStream.user?.sentProposalCount++;
      Globals.userStream.sync();
      ViewUtils.showSuccessDialog(
        result.data.toString(),
      );
    } else {
      ViewUtils.showErrorDialog(
        result.data.toString(),
      );
    }
  }
}
