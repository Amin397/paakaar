import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:paakaar/Controllers/MainPage/dashboard_controller.dart';
import 'package:paakaar/Models/MainPage/UpSlider.dart';
import 'package:paakaar/Pages/SliderSingle/slider_single_screen.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';

class TopSliderWidget extends StatelessWidget {
  TopSliderWidget(this.dashboardController);

  final DashboardController dashboardController;

  @override
  Widget build(BuildContext context) {
    double factor = 1920 / (Get.width - 48);
    // print(1080 / factor);
    // print(factor);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (Get.width > 400.0) {
          return Obx(
            () => AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              width: Get.width,
              height: dashboardController.isSlidersLoaded.isTrue &&
                      dashboardController.getListOfSliders.isNotEmpty
                  ? Get.height * .33
                  : 0.0,
              child: dashboardController.isSlidersLoaded.isTrue
                  ? Column(
                      children: [
                        Container(
                          height: 1080 / factor,
                          width: 1920 / factor,
                          child: PageView.builder(
                            controller: dashboardController.topSliderController,
                            itemBuilder: buildBanner,
                            onPageChanged: dashboardController.onPageChanged,
                            itemCount:
                                dashboardController.getListOfSliders.length,
                          ),
                        ),
                        const SizedBox(
                          height: 6.0,
                        ),
                        SmoothPageIndicator(
                          controller: dashboardController.topSliderController,
                          count: dashboardController.getListOfSliders.length,
                          effect: ExpandingDotsEffect(
                            dotHeight: 10.0,
                            dotWidth: 10.0,
                            activeDotColor: ColorUtils.myRed,
                          ),
                          onDotClicked: (index) {},
                        )
                        // Container(
                        //   height: 8,
                        //   width: Get.width,
                        //   color: Colors.red,
                        //   child: PageView.builder(
                        //     controller:
                        //         dashboardController.indicatorPageController,
                        //     itemBuilder: buildPageIcon,
                        //     itemCount:
                        //         dashboardController.getListOfSliders.length,
                        //     scrollDirection: Axis.horizontal,
                        //   ),
                        // ),
                      ],
                    )
                  : WidgetUtils.loadingWidget(),
            ),
          );
        } else {
          return Obx(
            () => AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              width: Get.width,
              height: dashboardController.isSlidersLoaded.isTrue &&
                      dashboardController.getListOfSliders.isNotEmpty
                  ? Get.height * .28
                  : Get.height / 75,
              child: dashboardController.isSlidersLoaded.isTrue
                  ? Column(
                children: [
                  Container(
                    height: 1080 / factor,
                    width: 1920 / factor,
                    child: PageView.builder(
                      controller: dashboardController.topSliderController,
                      itemBuilder: buildBanner,
                      onPageChanged: dashboardController.onPageChanged,
                      itemCount:
                      dashboardController.getListOfSliders.length,
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  SmoothPageIndicator(
                    controller: dashboardController.topSliderController,
                    count: dashboardController.getListOfSliders.length,
                    effect: ExpandingDotsEffect(
                      dotHeight: 10.0,
                      dotWidth: 10.0,
                      activeDotColor: ColorUtils.myRed,
                    ),
                    onDotClicked: (index) {},
                  )
                  // Container(
                  //   height: 8,
                  //   width: Get.width,
                  //   color: Colors.red,
                  //   child: PageView.builder(
                  //     controller:
                  //         dashboardController.indicatorPageController,
                  //     itemBuilder: buildPageIcon,
                  //     itemCount:
                  //         dashboardController.getListOfSliders.length,
                  //     scrollDirection: Axis.horizontal,
                  //   ),
                  // ),
                ],
              )
                  : WidgetUtils.loadingWidget(),
            ),
          );
        }
      },
    );
  }

  Widget buildBanner(BuildContext context, int index) {
    UpSliderModel slider = dashboardController.getListOfSliders[index];
    return AnimationConfiguration.synchronized(
      child: SlideAnimation(
        verticalOffset: index * 50.0,
        child: FadeInAnimation(
          child: GestureDetector(
            onTap: () => Get.to(
              () => SliderSingleScreen(
                slider: slider,
              ),
            ),
            child: Container(
              width: Get.width,
              height: Get.height,
              // margin: EdgeInsets.symmetric(vertical: 8.0),
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1920 / 1080,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      slider.upSliderImage,
                      fit: BoxFit.cover,
                    ),
                  ),
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
