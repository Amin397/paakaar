import 'dart:async';

import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Models/Club/ProviderModel.dart';
import 'package:paakaar/Models/Club/SingleProviderModel.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/ClubRequestUtils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

extension NegaClub on String {
  double toDouble() {
    double val = 0;
    try {
      val = double.parse(this.toString().replaceAll(',', '').trim());
    } catch (e) {}
    return val;
  }
}

class SingleProviderController extends GetxController {
  TextEditingController priceController = new TextEditingController();
  Completer<GoogleMapController> mapController = Completer();
  final ProviderModel provider;

  SingleProviderModel? singleProvider;
  RxBool isLoaded = false.obs;

  SingleProviderController(this.provider);

  @override
  void onInit() {
    this.getSingleProviderData();
    super.onInit();
  }

  void getSingleProviderData() async {
    ApiResult result = await ClubRequestUtils.instance.singleProvider(
      providerId: this.provider.id.toString(),
    );
    if (result.isDone) {
      this.singleProvider = SingleProviderModel.fromJson(result.data);
      this.isLoaded.value = true;
    } else {
      ViewUtils.showErrorDialog(result.data.toString());
    }
  }

  void payForProvider({
    bool fromWallet = false,
  }) async {
    double amount = this.priceController.text.toDouble();
    if (amount >= 5000) {
      EasyLoading.show();
      ApiResult result = await ClubRequestUtils.instance.payToProvider(
        provider: this.singleProvider!,
        amount: amount,
        fromWallet: fromWallet,
      );
      EasyLoading.dismiss();
      if (result.isDone) {
        if (fromWallet) {
          ViewUtils.showSuccessDialog(
            "عملیات با موفقیت انجام شد",
          );
          Globals.userStream.user?.credit -= amount.toInt();
          this.priceController.clear();
          Focus.maybeOf(context)?.requestFocus(
            new FocusNode(),
          );
        } else {
          launch(result.data.toString());
        }
      } else {
        ViewUtils.showErrorDialog(result.data.toString());
      }
    } else {
      ViewUtils.showErrorDialog(
        "مبلغ وارد شده باید بیشتر از ${ViewUtils.moneyFormat(5000)} تومان باشد",
      );
    }
  }

  String calcPercent() {
    return '0';
    // return (((Globals.userStream.user?.level?.discountPercent ?? 0) *
    //             double.parse(this.provider.discountPercent)) /
    //         100)
    //     .toStringAsFixed(1);
  }

  void showInfoDialog() {
    // TransitionHelper.push(
    //   context: context,
    //   targetPage: WebViewScreen(
    //     title: "توضیحات تخفیف",
    //     icon: Icons.local_offer_outlined,
    //     url:
    //         "https://blog.negaclub.ir/page/discount-detail?providerId=${this.widget.provider.code}&customerMobile=${Globals.userStream.user.mobile}",
    //   ),
    // );
  }
}
