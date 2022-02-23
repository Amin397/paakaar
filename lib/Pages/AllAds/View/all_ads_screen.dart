import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ionicons/ionicons.dart';
import 'package:paakaar/Controllers/MainPage/dashboard_controller.dart';
import 'package:paakaar/Models/Calls/ad_model.dart';
import 'package:paakaar/Pages/Ads/ad_info_screen.dart';
import 'package:paakaar/Pages/AllAds/Controller/all_ads_controller.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:paakaar/Widgets/custom_drawer_widget.dart';

import 'all_ads_slider_widget.dart';

class AllAdsScreen extends StatelessWidget {
  AllAdsScreen({Key? key }) : super(key: key);

  final AllAdsController allAdsController = Get.put(
    AllAdsController(),
  );

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: WidgetUtils.appBar(
          innerPage: true,
          key: allAdsController.scaffoldKey,
        ),
        drawer: CustomDrawerWidget(),
        key: allAdsController.scaffoldKey,
        backgroundColor: Colors.white,
        body: Container(
          padding: ViewUtils.scaffoldPadding,
          height: Get.height,
          width: Get.width,
          child: Column(
            children: [
              // BuildAllAdsSliderWidget(
              //   allAdsController: allAdsController,
              // ),

              ViewUtils.sizedBox(),
              buildSearchAndFilters(),
              GetBuilder(
                init: allAdsController,
                builder: (context) {
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: Get.height * .01,
                      ),
                      height: double.maxFinite,
                      width: Get.width,
                      child: (allAdsController.list.isNotEmpty)
                          ? GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio:
                                    Get.width / (Get.height / 2.8),
                              ),
                              itemBuilder: (_, index) => _buildAdsItem(
                                item: allAdsController.list[index],
                                index: index,
                              ),
                              itemCount: allAdsController.list.length,
                            )
                          : const Center(
                              child: Text('داده ای وجود ندارد'),
                            ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdsItem({
    AdModel? item,
    int? index,
  }) {
    return AnimationConfiguration.staggeredList(
      position: index!,
      child: SlideAnimation(
        verticalOffset: index * 25.0,
        child: FadeInAnimation(
          child: GestureDetector(
            onTap: () async {
              Get.to(
                () => AdInfoScreen(
                  ad: item!,
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Flexible(
                    flex: 4,
                    child: Container(
                      height: double.maxFinite,
                      width: double.maxFinite,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10.0)),
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/placeholder.jpg',
                            image: item!.cover,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      height: double.maxFinite,
                      width: double.maxFinite,
                      child: Center(
                        child: AutoSizeText(
                          item.title,
                          maxFontSize: 14.0,
                          minFontSize: 10.0,
                          maxLines: 2,
                          style: TextStyle(
                            color: ColorUtils.textColor,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSearchAndFilters() {
    return Row(
      children: [
        Expanded(
          child: Container(
              height: Get.height / 18,
              child: Obx(
                () => allAdsController.isCallOutsLoaded.isTrue
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GetBuilder(
                            init: allAdsController,
                            builder: (ctx) => Expanded(
                              child: WidgetUtils.selectOptions(
                                title: "انتخاب استان",
                                controller: allAdsController,
                                items: allAdsController.listOfStates,
                                isActive: (elem) => elem.isSelected,
                                displayFormat: displayStates,
                                makeActive: allAdsController.makeStateActive,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Expanded(
                            child: GetBuilder(
                              init: allAdsController,
                              builder: (ctx) => WidgetUtils.selectOptions(
                                title: "انتخاب شهر",
                                controller: allAdsController,
                                enabled: allAdsController.listOfStates
                                    .any((element) => element.isSelected),
                                errorMessage: "لطفا ابتدا استان را انتخاب کنید",
                                items: allAdsController.listOfStates
                                        .any((element) => element.isSelected)
                                    ? allAdsController.listOfStates
                                        .singleWhere(
                                            (element) => element.isSelected)
                                        .listOfCities
                                    : [],
                                isActive: (elem) => elem.isSelected,
                                displayFormat: displayCity,
                                makeActive: allAdsController.makeCityActive,
                              ),
                            ),
                          ),
                        ],
                      )
                    : WidgetUtils.loadingWidget(),
              )),
        ),
        // const SizedBox(
        //   width: 8.0,
        // ),
        // GestureDetector(
        //   onTap: () => allAdsController.getFilters(),
        //   child: Container(
        //     height: Get.height / 18,
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
        //       child: Row(
        //         children: [
        //           Icon(
        //             Ionicons.filter,
        //             color: ColorUtils.green.shade900,
        //           ),
        //         ],
        //       ),
        //     ),
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10.0),
        //       border: Border.all(
        //         color: ColorUtils.green.shade900.withOpacity(0.6),
        //         width: 1,
        //       ),
        //     ),
        //   ),
        // ),
        // const SizedBox(
        //   width: 8.0,
        // ),
      ],
    );
  }

  String displayStates(p1) {
    return p1.name;
  }

  String displayCity(p1) {
    return p1.name;
  }
}
