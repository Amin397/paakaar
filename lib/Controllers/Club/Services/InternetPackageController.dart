import 'dart:async';
import 'dart:convert';

import 'package:paakaar/Models/Club/Services/Charge/OperatorModel.dart';
import 'package:paakaar/Models/Club/Services/Internet/InternetPackage.dart';
import 'package:paakaar/Pages/Club/Internet/internetPackageListScreen.dart';
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

class InternetPackageController extends GetxController {
  ClubRequestUtils requests = new ClubRequestUtils();
  PageController pageController = PageController(viewportFraction: 0.4);
  final StreamController<bool> shapeStream = StreamController<bool>.broadcast();

  RxList<Rx<OperatorModel>> listOfOperators = RxList<Rx<OperatorModel>>();
  RxBool isLoaded = false.obs;
  RxString userType = 'postpaid'.obs;
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

  @override
  void onInit() {
    this.getOperators();
    this.initUniLinks();
    super.onInit();
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
  }

  void findPackages() async {
    EasyLoading.show();
    ApiResult result = await ClubRequestUtils.instance.buyInternet(
      operatorId: this
          .listOfOperators
          .singleWhere((element) => element.value.isSelected)
          .value
          .id
          .toString(),
      simType: this.userType.value,
    );
    EasyLoading.dismiss();
    if (result.isDone) {
      Get.dialog(
        InternetPackageListModal(
          title: "انتخاب بسته",
          listOfPackages: InternetPackage.listFromJson(result.data),
        ),
      );
    } else {
      ViewUtils.showErrorDialog();
    }
  }

  void changeUserType(String type) {
    this.userType.value = type;
  }
}
