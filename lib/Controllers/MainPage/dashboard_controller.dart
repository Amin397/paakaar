import 'dart:async';
import 'dart:developer';
import 'package:get_storage/get_storage.dart';
import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Models/MainPage/Field.dart';
import 'package:paakaar/Models/MainPage/Tv.dart';
import 'package:paakaar/Models/MainPage/UpSlider.dart';
import 'package:paakaar/Models/MainPage/main_ads_model.dart';
import 'package:paakaar/Pages/Scores/VIew/Widgets/score_modal_view.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/project_request_utils.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Widgets/upgrade_plan_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:frefresh/frefresh.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class DashboardController extends GetxController {
  ScrollController? scrollController;




  final ProjectRequestUtils requests = ProjectRequestUtils();
  List<FieldModel> listOfFields = [];
  late List<UpSliderModel> listOfSliders;

  final FRefreshController refreshController = FRefreshController();

  late List<TvModel> listOfTvItems;

  final PageController indicatorPageController = PageController(
    viewportFraction: 0.04,
  );
  final PageController secondIndicatorPageController = PageController(
    viewportFraction: 0.04,
  );

  void getScore() async {
    ApiResult result = await requests.getDashboardScore();
    if (result.isDone) {
      Globals.userStream.setUserScore(result.data);
    }
  }

  final PageController callOutPageController =
      PageController(viewportFraction: 1);

  ScrollController? tvListController;

  List<UpSliderModel> get getListOfSliders {
    return isFieldsLoaded.isTrue &&
            listOfFields.any((element) => element.isSelected.isTrue)
        ? listOfSliders
            .where((element) =>
                element.field?.id ==
                    listOfFields
                        .singleWhere((element) => element.isSelected.isTrue)
                        .id ||
                element.field == null)
            .toList()
        : listOfSliders;
  }

  List<TvModel> get getListOfTvItems => isFieldsLoaded.isTrue &&
          listOfFields.any((element) => element.isSelected.isTrue)
      ? listOfTvItems
          .where((element) =>
              element.fieldId ==
                  listOfFields
                      .singleWhere((element) => element.isSelected.isTrue)
                      .id ||
              element.fieldId == 0)
          .toList()
      : listOfTvItems;

  // late List<MainAdsModel> listOfAds;
  List<MainAdsModel> listOfAds = [];

  //
  // List<AdModel> get getListOfAds => isFieldsLoaded.isTrue &&
  //         listOfFields.any((element) => element.isSelected.isTrue)
  //     ? listOfAds
  //         .where((element) =>
  //             element.fieldId ==
  //             listOfFields
  //                 .singleWhere((element) => element.isSelected.isTrue)
  //                 .id)
  //         .toList()
  //     : listOfAds;
  RxBool isFieldsLoaded = false.obs;
  RxBool isSlidersLoaded = false.obs;
  RxBool isCallOutsLoaded = false.obs;
  RxBool isTvLoaded = false.obs;
  RxBool isFieldSelected = false.obs;
  final PageController topSliderController = PageController(
    viewportFraction: 1,
  );

  RxInt currentPage = 1.obs;
  RxInt sliderTopPage = 0.obs;
  RxInt adCurrentPage = 0.obs;

  @override
  void onInit() {
    getScore();
    scrollController = ScrollController(initialScrollOffset: 0.0);
    tvListController = ScrollController(initialScrollOffset: 0.0);
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        // RemoteNotification? notification = message.notification;
        log('new message');
        if (message is RemoteMessage) {
          Get.snackbar(
            message.notification?.title ?? '',
            message.notification?.body ?? '',
            backgroundColor: Colors.white.withOpacity(0.9),
          );
        }
      },
    );

    if (Globals.userStream.user!.role!.isSpecial == false ||
        Globals.userStream.user?.isExpired == true ||
        Globals.userStream.user?.role?.membershipId == 1) {
      showUpgradePlanDialog();
    }

    allInits();
    super.onInit();
  }

  Future<void> getFields() async {
    isFieldsLoaded.value = false;
    listOfFields.clear();

    ApiResult result = await requests.getAllFields();
    if (result.isDone) {
      listOfFields = FieldModel.listFromJson(
        result.data,
      );
      listOfFields.first.isSelected.value = true;
      isFieldsLoaded.value = true;
    } else {
      ViewUtils.showErrorDialog();
    }
  }

  Future<void> getSlider() async {
    ApiResult result = await requests.getTopSliders();
    if (result.isDone) {
      listOfSliders = UpSliderModel.listFromJson(
        result.data,
      );
      isSlidersLoaded.value = true;
    } else {
      ViewUtils.showErrorDialog();
    }
  }

  Future<void> getTvItems() async {
    ApiResult result = await requests.getTvItems();
    if (result.isDone) {
      listOfTvItems = TvModel.listFromJson(
        result.data,
      );
      isTvLoaded.value = true;
    } else {
      ViewUtils.showErrorDialog();
    }
  }

  Future<void> getAds() async {
    ApiResult result = await requests.dashboardAd();
    if (result.isDone) {
      listOfAds = MainAdsModel.listFromJson(
        result.data,
      );
      isCallOutsLoaded.value = true;
    } else {
      ViewUtils.showErrorDialog();
    }
  }

  void onFieldClick(FieldModel field) {
    for (var element in listOfFields) {
      element.isSelected.value = false;
    }
    field.isSelected.value = true;

    updateTVs(field: field.id);
    update();
  }

  updateTVs({int? field}) {}

  void showUpgradePlanDialog() {
    final box = GetStorage();
    if (box.read('firstLogin') is bool) {

    } else {
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.dialog(
          UpgradePlanDialog(
            text: Globals.userStream.user?.isExpired == true
                ? "تاریخ عضویت شما به پایان رسیده است"
                : "جهت دیده شدن و دسترسی عموم به خدمات و تخصص تان ،اشتراک ویژه تهیه فرمایید",
            fromDashboard: true,
            topText:
            'بصورت پیش فرض ، کاربر عادی هستید و به رایگان از خدمات تیتراژ استفاده می کنید',
          ),
          barrierColor: ColorUtils.black.withOpacity(0.5),
          barrierDismissible: Globals.userStream.user?.isExpired == false,
        );

        box.write(
          'firstLogin',
          true,
        );
      });
    }
  }

  void onPageChanged(int value) {
    sliderTopPage.value = value;
  }

  void onAdPageChanged(int value) {
    adCurrentPage.value = value;
  }

  Future<void> allInits() async {
    await getFields();
    await getSlider();
    await getTvItems();
    await getAds();
    update();
  }

  void goToOffset({bool? next, ScrollController? controller}) {
    if (next!) {
      controller!.animateTo(controller.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    } else {
      controller!.animateTo(controller.position.minScrollExtent,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  void showModal() {
    showModalBottomSheet(
      context: Get.context!,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => ScoreModalView(
          // myScoreController: this,
          ),
    );
  }
}
