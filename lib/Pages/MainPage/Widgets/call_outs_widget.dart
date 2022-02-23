import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:paakaar/Controllers/MainPage/dashboard_controller.dart';
import 'package:paakaar/Models/Calls/ad_model.dart';
import 'package:paakaar/Models/MainPage/main_ads_model.dart';
import 'package:paakaar/Pages/Ads/ad_info_screen.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/routing_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';

class CallOutsWidget extends StatelessWidget {
  final DashboardController dashboardController;

  CallOutsWidget({
    Key? key,
    required this.dashboardController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double factor = 1920 / (Get.width - 48);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 300.0) {
          return Obx(
            () => Container(
              // height: dashboardController.isCallOutsLoaded.isTrue &&
              //         dashboardController.listOfAds.isNotEmpty
              //     ? Get.width / 1.7
              //     : Get.height / 75,
              child: dashboardController.isCallOutsLoaded.isTrue
                  ? GetBuilder(
                      init: dashboardController,
                      builder: (
                        context,
                      ) {
                        return AnimationLimiter(
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    height: 760 / factor,
                                    width: 1920 / factor,
                                    child: PageView.builder(
                                      itemBuilder: buildTvItem,
                                      controller: dashboardController
                                          .callOutPageController,
                                      scrollDirection: Axis.horizontal,
                                      onPageChanged:
                                          dashboardController.onAdPageChanged,
                                      itemCount: dashboardController
                                          .listOfAds.length,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0,),
                                  SmoothPageIndicator(
                                    controller: dashboardController
                                        .callOutPageController,
                                    count:
                                        dashboardController.listOfAds.length,
                                    effect: ExpandingDotsEffect(
                                      dotHeight: 10.0,
                                      dotWidth: 10.0,
                                      activeDotColor: ColorUtils.myRed,
                                    ),
                                    onDotClicked: (index) {},
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: TextButton(
                                      child: const Text(
                                        'مشاهده همه',
                                        style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 10.0,
                                        ),
                                      ),
                                      onPressed: () {
                                        Get.toNamed(
                                          RoutingUtils.allAds.name,
                                          arguments: {
                                            'sliders':
                                            dashboardController.listOfAds,
                                            'field': dashboardController
                                                .listOfFields
                                                .singleWhere(
                                                  (element) => element
                                                  .isSelected.value,

                                            ),
                                            'ads':dashboardController.listOfAds
                                          },
                                        );
                                        // Get.toNamed(
                                        //   RoutingUtils.allAds.name,
                                        //   arguments: {
                                        //     'sliders':
                                        //     dashboardController.listOfAds
                                        //   },
                                        // );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : WidgetUtils.loadingWidget(),
            ),
          );
        } else {
          return Obx(
                () => Container(
              // height: dashboardController.isCallOutsLoaded.isTrue &&
              //         dashboardController.listOfAds.isNotEmpty
              //     ? Get.width / 1.7
              //     : Get.height / 75,
              child: dashboardController.isCallOutsLoaded.isTrue
                  ? GetBuilder(
                init: dashboardController,
                builder: (
                    context,
                    ) {
                  return AnimationLimiter(
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 760 / factor,
                              width: 1920 / factor,
                              child: PageView.builder(
                                itemBuilder: buildTvItem,
                                controller: dashboardController
                                    .callOutPageController,
                                scrollDirection: Axis.horizontal,
                                onPageChanged:
                                dashboardController.onAdPageChanged,
                                itemCount: dashboardController
                                    .listOfAds.length,
                              ),
                            ),
                            const SizedBox(height: 8.0,),
                            SmoothPageIndicator(
                              controller: dashboardController
                                  .callOutPageController,
                              count:
                              dashboardController.listOfAds.length,
                              effect: ExpandingDotsEffect(
                                dotHeight: 10.0,
                                dotWidth: 10.0,
                                activeDotColor: ColorUtils.myRed,
                              ),
                              onDotClicked: (index) {},
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton(
                                child: const Text(
                                  'مشاهده همه',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 10.0,
                                  ),
                                ),
                                onPressed: () {
                                  Get.toNamed(
                                    RoutingUtils.allAds.name,
                                    arguments: {
                                      'sliders':
                                      dashboardController.listOfAds,
                                      'field': dashboardController
                                          .listOfFields
                                          .singleWhere(
                                            (element) => element
                                            .isSelected.value,
                                      ),
                                    },
                                  );
                                  // Get.toNamed(
                                  //   RoutingUtils.allAds.name,
                                  //   arguments: {
                                  //     'sliders':
                                  //     dashboardController.listOfAds
                                  //   },
                                  // );
                                },
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
              )
                  : WidgetUtils.loadingWidget(),
            ),
          );
        }
      },
    );
  }

  Widget buildTvItem(BuildContext context, int index) {

    MainAdsModel call = dashboardController.listOfAds[index];
    return AnimationConfiguration.staggeredList(
      position: index,
      child: SlideAnimation(
        verticalOffset: index * 25.0,
        child: FadeInAnimation(
          child: GestureDetector(
            onTap: () async {
              // Get.toNamed(
              //   RoutingUtils.allAds.name,
              // );
              Get.toNamed(
                RoutingUtils.allAds.name,
                arguments: {
                  'sliders':
                  dashboardController.listOfAds,
                  'field': dashboardController
                      .listOfFields
                      .singleWhere(
                        (element) => element
                        .isSelected.value,
                  ),
                  'ads':dashboardController.listOfAds
                },
              );
              // Get.to(
              //   () => AdInfoScreen(
              //     // ad: call,
              //   ),
              // );
            },
            child: Container(
              // margin: const EdgeInsets.all(8.0),
              width: double.maxFinite,
              height: double.maxFinite,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/placeholder.jpg',
                  image: call.adBannerPic!,
                  fit: BoxFit.cover,
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
