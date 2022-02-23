import 'dart:async';
import 'dart:convert';

import 'package:paakaar/Models/Club/Services/Charge/MobileChargeModel.dart';
import 'package:paakaar/Models/Club/Services/Charge/OperatorModel.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/ClubRequestUtils.dart';
import 'package:paakaar/Utils/image_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

class MobileChargeController extends GetxController {
  RxList<Rx<OperatorModel>> listOfOperators = RxList<Rx<OperatorModel>>();
  final StreamController<bool> shapeStream = StreamController<bool>.broadcast();

  TextEditingController chargeAmountController = new TextEditingController();

  RxBool isLoaded = false.obs;
  PageController pageController = PageController(viewportFraction: 0.4);
  PageController amountPageController = PageController(viewportFraction: 0.5);

  TextEditingController priceTextController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  List<Rx<MobileChargeModel>> listOfChargeAmounts = [
    MobileChargeModel(amount: 1000, isSelected: true).obs,
    MobileChargeModel(amount: 2000, isSelected: false).obs,
    MobileChargeModel(amount: 5000, isSelected: false).obs,
    MobileChargeModel(amount: 10000, isSelected: false).obs,
    MobileChargeModel(amount: 20000, isSelected: false).obs,
    MobileChargeModel(amount: 50000, isSelected: false).obs,
  ];
  ClubRequestUtils requests = new ClubRequestUtils();
  late StreamSubscription _sub;

  Future<void> initUniLinks() async {
    // ... check initialLink

    // Attach a listener to the stream
    _sub = linkStream.listen((String? link) {
      // Parse the link and warn the user, if it is not correct
      Map data = jsonDecode(Uri.parse(link!).queryParameters['data']!);
      closeWebView();
      this.showLottie(data['status'] == true);
    }, onError: (err) {
      // Handle exception by warning the user their action did not succeed
    });

    // NOTE: Don't forget to call _sub.cancel() in dispose()
  }

  @override
  void onInit() {
    this.initUniLinks();
    this.getOperators();
    super.onInit();
  }

  @override
  void onClose() {
    this._sub.cancel();
    super.onClose();
  }

  void getOperators() async {
    ApiResult result = await ClubRequestUtils.instance.allOperators();
    if (result.isDone) {
      this.listOfOperators.value = OperatorModel.listFromJson(result.data);
      this.listOfOperators.first.value.isSelected = true;
      this.listOfOperators.first.refresh();
      this.isLoaded.toggle();
    }
  }

  void submit() async {
    if (this.mobileController.text.length != 11) {
      ViewUtils.showErrorDialog(
        "لطفا شماره موبایل را به صورت کامل وارد کنید.",
      );
      return;
    } else {
      EasyLoading.show();
      ApiResult result = await ClubRequestUtils.instance.buyCharge(
        mobile: this.mobileController.text,
        amount: this.chargeAmountController.text.replaceAll(',', '').toString(),
      );
      EasyLoading.dismiss();

      if (result.isDone && result.data['url'] is String) {
        canLaunch(result.data['url']).then((value) {
          if (value) {
            launch(result.data['url']);
          }
        });
      } else {
        ViewUtils.showErrorDialog(result.data.toString());
      }
    }
  }

  void onPageChanged(int index) {
    this.listOfOperators.forEach(
          (element) => element.update(
            (val) {
              element.value.isSelected = false;
            },
          ),
        );
    this.listOfOperators[index].value.isSelected = true;
    this.shapeStream.sink.add(false);
    this.listOfOperators[index].refresh();
    if (this.listOfOperators[index].value.askAmount) {
      Future.delayed(Duration(milliseconds: 200), () {
        this.listOfChargeAmounts.forEach(
              (element) => element.update((val) => val!.isSelected = false),
            );

        this.listOfChargeAmounts.first.value.isSelected = true;
        this.listOfChargeAmounts.first.refresh();
        if (this.amountPageController.positions.isNotEmpty) {
          this.amountPageController.animateToPage(
                0,
                duration: Duration(milliseconds: 175),
                curve: Curves.bounceIn,
              );
        }
      });
    }
  }

  void onAmountChanged(int index) {
    this
        .listOfChargeAmounts
        .forEach((element) => element.update((val) => val!.isSelected = false));
    this.listOfChargeAmounts[index].value.isSelected = true;
    this.listOfChargeAmounts[index].refresh();

    this.chargeAmountController.text = ViewUtils.moneyFormat(
      this.listOfChargeAmounts[index].value.amount,
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
        return WillPopScope(
          onWillPop: () async => false,
          child: SizedBox.expand(
            child: Container(
              margin: EdgeInsets.all(50.0),
              child: Center(
                child:
                    success ? ImageUtils.creditSuccess : ImageUtils.creditFail,
              ),
            ),
          ),
        );
      },
    );
  }
}
