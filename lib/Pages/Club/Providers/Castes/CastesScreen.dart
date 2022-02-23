import 'package:paakaar/Controllers/Club/Providers/CastesController.dart';
import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Models/Club/CasteModel.dart';
import 'package:paakaar/Models/Club/WorkGroupModel.dart';
import 'package:paakaar/Pages/Club/Providers/Providers/ProviderListScreen.dart';
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

class CastesScreen extends StatelessWidget {
  final WorkGroupModel workGroup;
  late CastesController castesController;

  CastesScreen({
    required this.workGroup,
  }) {
    this.castesController = Get.put(
      CastesController(this.workGroup),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SinglePageScreen(
      iconSetForAppBar: WidgetUtils.singlePageAppBar(
        text: this.workGroup.name,
        changeColor: true,
        icon: this.workGroup.icon,
      ),
      fab: cityFab(),
      backgroundColor: ColorUtils.black,
      body: Column(
        children: [
          WidgetUtils.neuSearchField(
            onChange: this.castesController.onSearch,
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
          return AnimatedSwitcher(
            duration: Duration(milliseconds: 175),
            child: this.castesController.isLoaded.isTrue
                ? this.buildMainItem(
                    casteGroup: this.castesController.getList[index],
                  )
                : this.buildShimmer(),
          );
        },
        itemCount: this.castesController.isLoaded.isTrue
            ? this.castesController.getList.length
            : 9,
      ),
    );
  }

  Widget buildMainItem({
    required CasteModel casteGroup,
  }) {
    return GestureDetector(
      onTap: () {
        if (Globals.city.city != null) {
          Get.to(
            () => ProviderListScreen(
              caste: casteGroup,
              workGroup: this.workGroup,
            ),
          );
        } else {
          ViewUtils.showErrorDialog(
            'ابتدا باید شهر را انتخاب کنید',
          );
        }
      },
      child: NeumorphicContainer(
        decoration: MyNeumorphicDecoration(
          color: ColorUtils.black,
          borderRadius: BorderRadius.circular(10.0),
        ),
        bevel: 18.0,
        height: Get.height / 9,
        width: Get.height / 9,
        curveType: CurveType.emboss,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: Get.width / 11,
                height: Get.width / 11,
                child: Image.network(
                  casteGroup.icon,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
              AutoSizeText(
                casteGroup.name,
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
