import 'package:flutter/material.dart';
import 'package:paakaar/Controllers/Club/DashboardController.dart';
import 'package:paakaar/Models/Club/LatestNewsModel.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';

class MainPageBannersWidget extends StatelessWidget {
  final ClubDashboardController dashboardController;

  MainPageBannersWidget({
    Key? key,
    required this.dashboardController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: Get.height / 5.9,
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 150),
            child: Obx(
              () => this.dashboardController.isBannersLoaded.isTrue
                  ? Column(
                      children: [
                        Expanded(
                          child: PageView.builder(
                            controller:
                                this.dashboardController.bannerPageController,
                            itemBuilder: this.bannerBuilder,
                            onPageChanged: (int num) {
                              this.dashboardController.pageNumber.value = num;
                            },
                            itemCount:
                                this.dashboardController.listOfBanners.length,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                        if (this.dashboardController.listOfBanners.length >
                            1) ...[
                          Container(
                            height: 18,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    this
                                        .dashboardController
                                        .bannerPageController
                                        .animateToPage(
                                          index,
                                          duration: Duration(milliseconds: 375),
                                          curve: Curves.easeIn,
                                        );
                                  },
                                  child: Obx(
                                    () => AnimatedContainer(
                                      duration: Duration(milliseconds: 75),
                                      width: 8,
                                      height: 8,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 4.0),
                                      decoration: BoxDecoration(
                                        color: this
                                                    .dashboardController
                                                    .pageNumber
                                                    .value ==
                                                index
                                            ? ColorUtils.yellow
                                            : Colors.transparent,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: ColorUtils.yellow,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.1),
                                            spreadRadius: 5.0,
                                            blurRadius: 5.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount:
                                  this.dashboardController.listOfBanners.length,
                            ),
                          ),
                        ]
                      ],
                    )
                  : ViewUtils.circularProgressIndicator(),
            ),
          ),
        ),
      ],
    );
  }

  Widget bannerBuilder(BuildContext context, int index) {
    LatestNewsModel banner = this.dashboardController.listOfBanners[index];
    return GestureDetector(
      // onTap: () => SingleNewsWidget.show(
      //   latestNews: banner,
      //   context: context,
      // ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              child: Image.network(
                banner.cover,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      banner.title,
                      style: TextStyle(
                        color: ColorUtils.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                    Text(
                      'ادامه مطلب',
                      style: TextStyle(
                        color: ColorUtils.red,
                        fontSize: 10.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
