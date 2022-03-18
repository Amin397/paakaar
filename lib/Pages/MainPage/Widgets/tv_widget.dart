import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ionicons/ionicons.dart';
import 'package:paakaar/Controllers/MainPage/dashboard_controller.dart';
import 'package:paakaar/Models/MainPage/Tv.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:paakaar/Widgets/Shared/video_player_dialog.dart';

class TvWidget extends StatelessWidget {
  final DashboardController dashboardController;

  TvWidget({
    Key? key,
    required this.dashboardController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * .14,
      child: Obx(
        () => dashboardController.isTvLoaded.isTrue
            ? GetBuilder(
                init: dashboardController,
                builder: (
                  context,
                ) {
                  return Row(
                    children: [
                      (dashboardController.getListOfTvItems.isNotEmpty)?InkWell(
                        onTap: () {
                          dashboardController.goToOffset(
                            next: false,
                            controller: dashboardController.tvListController,
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Get.width * .01,
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios,
                            size: 18.0,
                          ),
                        ),
                      ):Container(),
                      Expanded(
                        child: SizedBox(
                          width: double.maxFinite,
                          height: double.maxFinite,
                          child: AnimationLimiter(
                            child: ListView.builder(
                              controller: dashboardController.tvListController,
                              itemBuilder: buildTvItem,
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  dashboardController.getListOfTvItems.length,
                            ),
                          ),
                        ),
                      ),
                      (dashboardController.getListOfTvItems.isNotEmpty)?InkWell(
                        onTap: () {
                          dashboardController.goToOffset(
                            next: true,
                            controller: dashboardController.tvListController,
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Get.width * .01,
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            size: 18.0,
                          ),
                        ),
                      ):Container(),
                    ],
                  );
                },
              )
            : WidgetUtils.loadingWidget(),
      ),
    );
  }

  Widget buildTvItem(BuildContext context, int index) {
    TvModel tv = dashboardController.getListOfTvItems[index];
    double factor = 1920 / (Get.width - 48);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints raints) {
        if (raints.maxWidth > 300.0) {
          return AnimationConfiguration.staggeredList(
            position: index,
            child: SlideAnimation(
              verticalOffset: index * 25.0,
              child: FadeInAnimation(
                child: GestureDetector(
                  onTap: () {
                    // Get.dialog(
                    Get.to(
                      () => VideoPlayerDialog(
                        url: tv.content,
                        fromDashboard: true,
                      ),
                    );
                    // print(tv.content);
                    // barrierColor: Colors.black.withOpacity(0.5),
                    // );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: (1080 / 3) / factor,
                              width: (1920 / 3) / factor,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: FadeInImage.assetNetwork(
                                  placeholder: 'assets/loading.gif',
                                  image: tv.cover,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              height: (1080 / 3) / factor,
                              width: (1920 / 3) / factor,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: ColorUtils.black.withOpacity(0.2),
                              ),
                              child: const Center(
                                child: Icon(
                                  Ionicons.play,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * .04,
                          width: Get.width / 3,
                          child: Center(
                            child: AutoSizeText(
                              tv.name,
                              maxLines: 1,
                              maxFontSize: 16.0,
                              minFontSize: 10.0,
                              style: const TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return AnimationConfiguration.staggeredList(
            position: index,
            child: SlideAnimation(
              verticalOffset: index * 25.0,
              child: FadeInAnimation(
                child: GestureDetector(
                  onTap: () {
                    Get.dialog(
                      VideoPlayerDialog(
                        url: tv.content,
                        fromDashboard: true,
                      ),
                      barrierColor: Colors.black.withOpacity(0.5),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: double.maxFinite,
                              height: Get.height / 14,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: FadeInImage.assetNetwork(
                                  placeholder: 'assets/loading.gif',
                                  image: tv.cover,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              width: double.maxFinite,
                              height: Get.height / 14,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: ColorUtils.black.withOpacity(0.2),
                              ),
                              child: const Center(
                                child: Icon(
                                  Ionicons.play,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * .03,
                          width: Get.width / 3,
                          child: Center(
                            child: AutoSizeText(
                              tv.name,
                              maxLines: 1,
                              maxFontSize: 14.0,
                              minFontSize: 10.0,
                              style: const TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                      ],
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
      },
    );
  }
}
