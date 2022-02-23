import 'dart:async';
import 'dart:convert';

import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Models/Club/LatestNewsModel.dart';
import 'package:paakaar/Models/Club/LevelModel.dart';
import 'package:paakaar/Models/Club/MainCategoryScreeModel.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/ClubRequestUtils.dart';
import 'package:paakaar/Utils/AuthUtils.dart';
import 'package:paakaar/Utils/image_utils.dart';
import 'package:paakaar/Utils/routing_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:ionicons/ionicons.dart';
import 'package:local_auth/local_auth.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

class ClubDashboardController extends GetxController {
  PageController pageController = new PageController();
  PageController bannerPageController = new PageController();
  late List<LatestNewsModel> listOfBanners;

  RxBool isNegaCardsLoaded = false.obs;

  RxBool isChanging = false.obs;
  Rx<LevelModel> get level => this.listOfLevels!.singleWhere(
        (element) => element.value.isSelected,
      );
  PageController negaCardPageController = PageController(viewportFraction: 0.9);

  final ClubRequestUtils requests = ClubRequestUtils();

  List<Rx<LevelModel>>? listOfLevels;
  RxBool isBannersLoaded = false.obs;
  RxInt pageNumber = 0.obs;

  RxList<MainCategoryModel> listOfItems = [
    MainCategoryModel(
      name: 'پرداخت قبض',
      icon: Icons.payments_outlined,
      id: 0,
      // screenWidget: PayBillScreen(
      //   currentTab: 0,
      // ),
    ),
    MainCategoryModel(
      id: 2,
      name: 'شارژ',
      icon: Icons.sim_card_outlined,
      screenWidget: ClubRoutingUtils.charge,
    ),

    MainCategoryModel(
      name: 'ثبت کارت',
      icon: Ionicons.card_outline,
      id: 12,
      screenWidget: ClubRoutingUtils.cards,
    ),
    MainCategoryModel(
      name: 'فعالیت ها',
      icon: FeatherIcons.activity,
      id: 1,
      // screenWidget: TransactionsWidget(
      //   initialPage: 0,
      // ),
    ),
    MainCategoryModel(
      name: 'بارکدخوان',
      icon: FeatherIcons.camera,
      id: 3,
      screenWidget: ClubRoutingUtils.qrScanner,
    ),
    MainCategoryModel(
      name: 'قبض موبایل',
      icon: FeatherIcons.phone,
      id: 4,
      // screenWidget: PayBillScreen(
      //   currentTab: 1,
      // ),
      // screenWidget: ReceiptMobilePaymentPage(),
    ),
    MainCategoryModel(
      name: 'بسته اینترنت',
      icon: FeatherIcons.wifi,
      id: 5,
      screenWidget: ClubRoutingUtils.internet,
      // screenWidget: InternetPackageScreen(),
    ),
    MainCategoryModel(
      name: 'کد های تخفیف',
      icon: FeatherIcons.code,
      id: 6,
      screenWidget: ClubRoutingUtils.voucherCodes,
      // screenWidget: VoucherCodeScreen(),
    ),
    MainCategoryModel(
      name: 'نیکوکاری',
      icon: FeatherIcons.heart,
      id: 7,
      screenWidget: ClubRoutingUtils.charity,
    ),
    // MainCategoryModel(
    //   name: 'پرداخت وجه',
    //   icon: FeatherIcons.creditCard,
    //   id: 8,
    // ),
    // screenWidget: PaymentPage()),
    MainCategoryModel(
      name: 'گردشگری',
      icon: FeatherIcons.flag,
      id: 9,
      // screenWidget: TravelScreen(),
    ),
    MainCategoryModel(
      name: 'بیمه',
      icon: FeatherIcons.userCheck,
      id: 10,
      screenWidget: ClubRoutingUtils.mainInsuranceScreen,
    ),
    MainCategoryModel(
      name: 'خودرو',
      icon: Ionicons.car_outline,
      id: 11,
      // screenWidget: CarScreen(),
    ),
  ].obs;

  Stream<bool> footerStream() async* {
    yield false;
    await Future.delayed(
      Duration(
        milliseconds: (this.listOfItems.length * 50) + 200,
      ),
    );
    yield true;
  }

  late RxList<List<bool>> list;

  @override
  void onInit() {
    this.getNews();
    LocalAuthentication localAuth = new LocalAuthentication();
    localAuth.canCheckBiometrics.then(
      (bool canCheck) {
        this.canCheckBiometrics.value = canCheck;
      },
    );
    this.registerSub();
    super.onInit();
  }

  void animateTo(int index) {
    this.pageController.animateToPage(
          index,
          duration: Duration(milliseconds: 175),
          curve: Curves.easeIn,
        );
  }

  Future<void> getNews() async {
    ApiResult result = await this.requests.mainNews();
    if (result.isDone) {
      this.listOfBanners = LatestNewsModel.listFromJson(result.data);
      this.isBannersLoaded.toggle();
    } else {
      ViewUtils.showErrorDialog(result.data.toString());
    }
  }

  void buyLevel() async {
    EasyLoading.show();
    ApiResult result = await this.requests.buyLevel(level.value.id.toString());
    EasyLoading.dismiss();
    if (result.isDone) {
      launch(result.data);
    } else {
      ViewUtils.showErrorDialog(result.data.toString());
    }
  }

  late StreamSubscription _sub;

  void showLottie(bool success) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pop(context);
    });
    showCupertinoDialog(
      barrierDismissible: false,
      context: this.context,
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

  @override
  void onClose() {
    this._sub.cancel();
    super.onClose();
  }

  void setFingerprint() async {
    bool didAuthenticate = await authenticate(
      'لطفا حسگر اثر انگشت را لمس کنید.',
    );
    // PrefHelpers.setFingerPrint(didAuthenticate.toString());
  }

  RxBool canCheckBiometrics = false.obs;

  void registerSub() {
    _sub = uriLinkStream.listen((Uri? uri) {
      Map<String, String> params = uri!.queryParameters;
      Map data = jsonDecode(params['data']!);
      showLottie(data['status'] == true);

      closeWebView();
      if (data['status'] == true) {
        // Globals.userStream.user!.level = this
        //     .listOfLevels!
        //     .singleWhere((element) => element.value.id == this.level.value.id)
        //     .value;
        Globals.userStream.streamController.sink.add(Globals.userStream.user!);
      }
    }, onError: (err) {});
  }
}
