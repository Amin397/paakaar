import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:frefresh/frefresh.dart';
import 'package:paakaar/Controllers/UserDashboardController/my_ads_controller.dart';
import 'package:paakaar/Models/Calls/ad_model.dart';
import 'package:paakaar/Pages/Ads/ad_info_screen.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:paakaar/Widgets/custom_drawer_widget.dart';

class MyAdsScreen extends StatelessWidget {
  final MyAdsController controller = Get.put(
    MyAdsController(),
  );

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        key: controller.scaffoldKey,
        appBar: WidgetUtils.appBar(
          innerPage: true,
          key: controller.scaffoldKey,
        ),
        drawer: CustomDrawerWidget(),
        floatingActionButton: GetBuilder(
          init: controller,
          builder: (_) =>
              controller.isDeleting ? buildFab() : Container(),
        ),
        body: Padding(
          padding: ViewUtils.scaffoldPadding,
          child: buildBody(),
        ),
      ),
    );
  }

  Widget buildAds() {
    return Obx(
      () => Expanded(
        child: controller.isAdsLoaded.isTrue
            ? GetBuilder(
                init: controller,
                builder: (context) {
                  return controller.listOfAds.isNotEmpty
                      ? AnimationLimiter(
                          child: FRefresh(
                            headerHeight: Get.height / 8,
                            header: Container(
                              margin: const EdgeInsets.all(8.0),
                              child: Center(
                                child: WidgetUtils.loadingWidget(),
                              ),
                            ),
                            controller: controller.adRefreshController,
                            onRefresh: () async {
                              await controller.getAds();
                              controller.adRefreshController.finishRefresh();
                            },
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.listOfAds.length,
                              itemBuilder: (BuildContext context, int index) {
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  child: SlideAnimation(
                                    child: FadeInAnimation(
                                      child: buildAd(
                                        controller.listOfAds[index],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : WidgetUtils.dataNotFound("آگهی ای");
                },
              )
            : WidgetUtils.loadingWidget(),
      ),
    );
  }

  Widget buildAd(AdModel ad) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: ViewUtils.boxShadow(),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: ad.isDeleting ? ColorUtils.mainRed : Colors.white,
          width: 0.5,
        ),
      ),
      height: Get.height / 8,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onLongPress: () {
            controller.enterDeletingMode(ad);
          },
          onTap: () {
            if (controller.isDeleting) {
              ad.isDeleting = !ad.isDeleting;
              controller.isDeleting =
                  controller.listOfAds.any((element) => element.isDeleting);
            } else {
              print(ad.state.name);
              Get.to(
                () => AdInfoScreen(
                  ad: ad,
                ),
              );
            }
            controller.update();
          },
          borderRadius: BorderRadius.circular(10.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: Get.width / 4,
                  height: Get.width / 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      ad.cover,
                      width: Get.width / 4,
                      height: Get.width / 4,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width:
                        (Get.width) - (((Get.width / 4)* 2)),
                    height: 40.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            child: AutoSizeText(
                              ad.title,
                              maxLines: 2,
                              maxFontSize: 16.0,
                              minFontSize: 12.0,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: ColorUtils.black,
                              ),
                            ),
                            height: double.maxFinite,
                            width: double.maxFinite,
                          ),
                        ),
                        Container(
                          width: Get.width / 5,
                          height: Get.height / 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: ColorUtils.mainRed,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                AdModel.getStatus(ad.status),
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: (Get.width) -
                        (8.0 + (Get.width / 4) + 16 + Get.width / 4),
                    child: Text(
                      ad.field.name,
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontSize: 11.0,
                        color: ColorUtils.textColor,
                      ),
                    ),
                  ),
                  Container(
                    width: (Get.width) -
                        (8.0 + (Get.width / 4) + 16 + Get.width / 4),
                    child: Text(
                      '${ad.state.name is String ? ad.state.name : ''} - ${ad.city.name}',
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontSize: 11.0,
                        color: ColorUtils.textColor,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Icon(
                Icons.arrow_right,
                color: ColorUtils.green,
              ),
            ],
          ),
        ),
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 4.0,
      ),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        ViewUtils.sizedBox(),
        const Text(
          "آگهی های من",
          style: TextStyle(
            color: ColorUtils.black,
            fontSize: 18.0,
            fontWeight: FontWeight.normal,
          ),
        ),
        ViewUtils.sizedBox(),
        buildAds(),
      ],
    );
  }

  Widget buildFab() {
    return FloatingActionButton(
      onPressed: () => controller.deleteAds(),
      child: const Icon(
        Icons.delete_outline,
      ),
    );
  }
}
