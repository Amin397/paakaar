import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ionicons/ionicons.dart';
import 'package:reorderables/reorderables.dart';
import 'package:paakaar/Controllers/Club/DashboardController.dart';
import 'package:paakaar/Models/Club/MainCategoryScreeModel.dart';
import 'package:paakaar/Pages/Club/Home/Widgets/MainPageBannersWidget.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Plugins/neumorphic-package-by-serge-software/neumorphic-card.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/routing_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Widgets/Shared/Club/club_card_widget.dart';

class HomePageWidget extends StatelessWidget {
  final ClubDashboardController dashboardController;

  HomePageWidget({
    Key? key,
    required this.dashboardController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
      ),
      child: Column(
        children: [
          ClubCardWidget(),
          ViewUtils.sizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _mainScreenContainer(
                disabled: true,
                title: 'نگاشاپ',
                icon: Ionicons.cart_outline,
                color: ColorUtils.black,
                index: 3,
                // func: () => TransitionHelper.push(
                //   context: context,
                //   targetPage: WebViewScreen(
                //     title: "نگاشاپ",
                //     icon: Ionicons.car_outline,
                //     url: "http://localhost:57974/#/",
                //   ),
                // ),
              ),
              _mainScreenContainer(
                title: 'نگاوالت',
                disabled: false,
                icon: Ionicons.wallet_outline,
                color: ColorUtils.black, index: 2,

                // func: () => Get.toNamed(
                //   RoutingUtils.negaWallet.name,
                // ),
                // func: () => TransitionHelper.push(
                //   context: context,
                //   targetPage: NegaWalletScreen(),
                // ),
              ),
              _mainScreenContainer(
                title: 'نگاکلاب',
                func: () => Get.toNamed(
                  ClubRoutingUtils.workGroups.name,
                ),
                icon: Ionicons.storefront_outline,
                color: ColorUtils.black,
                index: 1,
              ),
            ],
          ),
          ViewUtils.sizedBox(
            25,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  MainPageBannersWidget(
                    dashboardController: dashboardController,
                  ),
                  ViewUtils.sizedBox(),
                  buildItems(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _mainScreenContainer({
    required String title,
    Function? func,
    required Color color,
    required IconData icon,
    required int index,
    bool disabled = false,
  }) {
    return AnimationConfiguration.synchronized(
      duration: Duration(milliseconds: 300 * index),
      child: SlideAnimation(
        verticalOffset: -Get.height / 3,
        child: FadeInAnimation(
          child: GestureDetector(
            onTap: () {
              func!();
            },
            child: NeumorphicContainer(
              width: Get.width / 4,
              height: Get.width / 4,
              curveType: CurveType.concave,
              bevel: disabled ? 4.0 : 12.0,
              decoration: MyNeumorphicDecoration(
                color: ColorUtils.black,
                borderRadius: BorderRadius.circular(15.0),
                shape: BoxShape.rectangle,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    icon,
                    color:
                        disabled ? Colors.white.withOpacity(0.5) : Colors.white,
                    size: 35.0,
                  ),
                  AutoSizeText(
                    title,
                    maxFontSize: 24.0,
                    minFontSize: 10.0,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: disabled
                          ? Colors.white.withOpacity(0.5)
                          : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainItem({
    required MainCategoryModel item,
    required Color color,
    required int index,
  }) {
    return GestureDetector(
      onTap: () {
        if (item.screenWidget == null) {
        } else {
          Get.toNamed(
            item.screenWidget!.name,
          );
          // TransitionHelper.push(
          //   context: context,
          //   targetPage: item.screenWidget,
          // );
        }
      },
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: NeumorphicContainer(
          height: Get.height / 9,
          width: Get.height / 9,
          decoration: MyNeumorphicDecoration(
            color: ColorUtils.black,
            borderRadius: BorderRadius.circular(10.0),
          ),
          curveType: CurveType.emboss,
          bevel: 18,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    NeumorphicIcon(
                      item.icon!,
                      size: Get.width / 13,
                      style: NeumorphicStyle(
                        intensity: 0.2,
                        color: Colors.grey,
                      ),
                    ),
                    AutoSizeText(
                      item.name,
                      maxLines: 1,
                      minFontSize: 2,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildItems() {
    return Container(
      height: (Get.height / 6.1) * dashboardController.listOfItems.length / 3,
      child: AnimationLimiter(
        child: Obx(
          () => ReorderableWrap(
            buildDraggableFeedback:
                (BuildContext context, BoxConstraints raints, Widget child) {
              return ConstrainedBox(
                constraints: raints,
                child: child,
              );
            },

            maxMainAxisCount: 3,
            minMainAxisCount: 3,
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            spacing: 8.0,

            runSpacing: 4.0,
            onReorder: (int oldIndex, int newIndex) {
              MainCategoryModel row =
                  dashboardController.listOfItems.removeAt(oldIndex);
              dashboardController.listOfItems.insert(newIndex, row);
            },
            children:
                List.generate(dashboardController.listOfItems.length, (index) {
              if (index == (dashboardController.listOfItems.length)) {
                return Container();
              }
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: Duration(
                  milliseconds: dashboardController.listOfItems.length * 50,
                ),
                columnCount: 3,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: _buildMainItem(
                      item: dashboardController.listOfItems[index],
                      index: index,
                      color: ColorUtils.yellow,
                    ),
                  ),
                ),
              );
            }),
            // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //   crossAxisCount: 3,
            //   crossAxisSpacing: 12.0,
            //   mainAxisSpacing: 12.0,
            // ),
            // physics: NeverScrollableScrollPhysics(),
            // children: List.generate(da, int index) ,
            // itemCount: dashboardController.listOfItems.length + 1,
          ),
        ),
      ),
    );
  }
}
