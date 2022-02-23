import 'package:paakaar/Controllers/Club/Providers/WorkGroupsController.dart';
import 'package:paakaar/Models/Club/WorkGroupModel.dart';
import 'package:paakaar/Pages/Club/Providers/Castes/CastesScreen.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neumorphic-package-by-serge-software/neumorphic-card.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:paakaar/Widgets/Shared/Club/CityPickerModal.dart';
import 'package:paakaar/Widgets/Shared/SinglePageScreen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shimmer/shimmer.dart';

class WorkGroupsScreen extends StatelessWidget {
  final WorkGroupsController workGroupsController = Get.put(
    WorkGroupsController(),
  );

  @override
  Widget build(BuildContext context) {
    return SinglePageScreen(
      iconSetForAppBar: WidgetUtils.singlePageAppBar(
        text: "نگاکلاب",
        icon: Ionicons.storefront_outline,
      ),
      fab: cityFab(),
      backgroundColor: ColorUtils.black,
      body: Column(
        children: [
          WidgetUtils.neuSearchField(
            onChange: this.workGroupsController.onSearch,
          ),
          ViewUtils.sizedBox(50),
          Expanded(
            child: this.buildItems(),
          ),
        ],
      ),
    );
  }

  Widget buildItems() {
    return Obx(
      () => GridView.builder(
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: Get.height / 40,
          crossAxisSpacing: Get.height / 40,
        ),
        itemBuilder: (_, index) {
          if (this.workGroupsController.isLoaded.isTrue) {
            if (index >= this.workGroupsController.getList.length) {
              return Container();
            }
          }

          return AnimatedSwitcher(
            duration: Duration(milliseconds: 175),
            child: this.workGroupsController.isLoaded.isTrue
                ? this.buildMainItem(
                    workGroup: this.workGroupsController.getList[index],
                  )
                : this.buildShimmer(),
          );
        },
        itemCount: this.workGroupsController.isLoaded.isTrue
            ? this.workGroupsController.getList.length + 1
            : 9,
      ),
    );
  }

  Widget buildMainItem({
    required WorkGroupModel workGroup,
  }) {
    return GestureDetector(
      onTap: () => Get.to(
        () => CastesScreen(
          workGroup: workGroup,
        ),
      ),
      child: NeumorphicContainer(
        decoration: MyNeumorphicDecoration(
          color: ColorUtils.black,
          borderRadius: BorderRadius.circular(10.0),
        ),
        height: Get.height / 9,
        width: Get.height / 9,
        bevel: 18.0,
        curveType: CurveType.emboss,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: Get.width / 11,
                height: Get.width / 11,
                child: Image.network(
                  workGroup.icon,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
              AutoSizeText(
                workGroup.name,
                textAlign: TextAlign.center,
                minFontSize: 2.0,
                maxFontSize: 12.0,
                maxLines: 2,
                style: TextStyle(
                  height: 1.6,
                  fontSize: 12.0,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildShimmer() {
    return NeumorphicContainer(
      decoration: MyNeumorphicDecoration(
        color: ColorUtils.black,
        borderRadius: BorderRadius.circular(10.0),
      ),
      curveType: CurveType.emboss,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Shimmer.fromColors(
              period: Duration(milliseconds: 500),
              baseColor: ColorUtils.yellow.withOpacity(0.7),
              highlightColor: ColorUtils.yellow.withOpacity(0.2),
              child: Icon(
                Ionicons.storefront_outline,
              ),
            ),
            Shimmer.fromColors(
              period: Duration(milliseconds: 500),
              baseColor: ColorUtils.yellow.withOpacity(0.7),
              highlightColor: ColorUtils.yellow.withOpacity(0.2),
              child: AutoSizeText(
                "در حال بارگزاری...",
                minFontSize: 2.0,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
